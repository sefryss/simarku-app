import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simarku/models/models.dart';

class BookTypeFilterModalBottomSheet extends StatefulWidget {
  const BookTypeFilterModalBottomSheet({
    super.key,
    required this.selectedItems,
  });

  final Map<String, dynamic> selectedItems;

  @override
  State<BookTypeFilterModalBottomSheet> createState() =>
      _BookTypeFilterModalBottomSheetState();
}

class _BookTypeFilterModalBottomSheetState
    extends State<BookTypeFilterModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ListTile(
          title: Text(
            'Jenis Buku',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 24 / 16,
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('books').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // Get unique book types from the stories
            List<BookType> bookTypes = snapshot.data!.docs
                .map((doc) {
                  StoryModel story = StoryModel.fromFirestore(doc);
                  return story.bookType!;
                })
                .toSet()
                .toList();

            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Wrap(
                spacing: 8,
                children: List<Widget>.generate(
                  bookTypes.length,
                  (index) => FilterChip(
                    label: Text(getBookTypeString(bookTypes[index])),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          widget.selectedItems.addAll({
                            'book_type': bookTypes[index],
                            'book_type_name':
                                getBookTypeString(bookTypes[index]),
                          });
                        } else {
                          widget.selectedItems.remove('book_type');
                        }
                      });
                    },
                    selected:
                        widget.selectedItems['book_type'] == bookTypes[index],
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
