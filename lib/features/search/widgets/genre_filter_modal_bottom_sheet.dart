import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simarku/models/genre_model.dart';

class GenreFilterModalBottomSheet extends StatefulWidget {
  const GenreFilterModalBottomSheet({
    Key? key,
    required this.selectedItems,
    required this.updateSelectedItems,
  }) : super(key: key);

  final Map<String, dynamic> selectedItems;
  final Function(String, dynamic) updateSelectedItems;

  @override
  State<GenreFilterModalBottomSheet> createState() =>
      _GenreFilterModalBottomSheetState();
}

class _GenreFilterModalBottomSheetState
    extends State<GenreFilterModalBottomSheet> {
  late Map<String, dynamic> tempSelectedItems;

  @override
  void initState() {
    super.initState();
    tempSelectedItems = Map.from(widget.selectedItems);
  }

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
                          tempSelectedItems['genre_id'] = [
                            ...(tempSelectedItems['genre_id'] ?? []),
                            genres[index].id,
                          ];
                        } else {
                          tempSelectedItems['genre_id'] =
                              List<String>.from(tempSelectedItems['genre_id']!)
                                ..remove(genres[index].id);
                        }
                      });
                    },
                    selected: (tempSelectedItems['genre_id'] ?? [])
                        .contains(genres[index].id),
                    showCheckmark: false,
                  ),
                ),
              ),
            );
          },
        ),
        const Divider(height: 1),
        // Di GenreFilterModalBottomSheet, tambahkan penanganan untuk menghapus filter genre
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: () {
              // Periksa jika genre filter kosong
              if (tempSelectedItems.containsKey('genre_id') &&
                  (tempSelectedItems['genre_id'] as List).isNotEmpty) {
                // Kirim filter genre yang dipilih ke fungsi updateSelectedItems
                widget.updateSelectedItems(
                    'genre_id', tempSelectedItems['genre_id']);
              } else {
                // Jika genre filter kosong, kirim null atau daftar kosong
                widget.updateSelectedItems('genre_id', null);
              }
              Navigator.pop(context, tempSelectedItems);
            },
            child: const Text('Pilih'),
          ),
        ),
      ],
    );
  }
}
