import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simarku/models/models.dart';

class GenreFilterModalBottomSheet extends StatefulWidget {
  const GenreFilterModalBottomSheet({
    super.key,
    required this.selectedItems,
  });

  final Map<String, dynamic> selectedItems;

  @override
  State<GenreFilterModalBottomSheet> createState() =>
      _GenreFilterModalBottomSheetState();
}

class _GenreFilterModalBottomSheetState
    extends State<GenreFilterModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ListTile(
          title: Text(
            'Genre',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 24 / 16,
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('genre_list')
              .where('is_active', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<Genre> genres = snapshot.data!.docs.map((doc) {
              return Genre.fromFirestore(doc);
            }).toList();

            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Wrap(
                spacing: 8,
                children: List<Widget>.generate(
                  genres.length,
                  (index) => FilterChip(
                    label: Text(genres[index].genre!),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          widget.selectedItems.addAll({
                            'major': genres[index].id,
                            'major_name': genres[index].genre,
                          });
                        } else {
                          widget.selectedItems.remove('major');
                        }
                      });
                    },
                    selected: widget.selectedItems['major'] == genres[index].id,
                  ),
                ),
              ),
            );
          },
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: () {
              widget.selectedItems.addAll({'apply': true});
              Navigator.pop(context, widget.selectedItems);
            },
            child: const Text('Pilih'),
          ),
        ),
      ],
    );
  }
}
