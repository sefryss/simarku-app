import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simarku/models/models.dart';

class CategoryFilterModalBottomSheet extends StatefulWidget {
  const CategoryFilterModalBottomSheet({
    super.key,
    required this.selectedItems,
  });

  final Map<String, dynamic> selectedItems;

  @override
  State<CategoryFilterModalBottomSheet> createState() =>
      _CategoryFilterModalBottomSheetState();
}

class _CategoryFilterModalBottomSheetState
    extends State<CategoryFilterModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ListTile(
          title: Text(
            'Kategori',
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

            // Get unique categories from the stories
            List<Category> categories = snapshot.data!.docs
                .map((doc) {
                  StoryModel story = StoryModel.fromFirestore(doc);
                  return story.category!;
                })
                .toSet()
                .toList();

            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Wrap(
                spacing: 8,
                children: List<Widget>.generate(
                  categories.length,
                  (index) => FilterChip(
                    label: Text(getCategoryString(categories[index])),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          widget.selectedItems.addAll({
                            'category': categories[index],
                            'category_name':
                                getCategoryString(categories[index]),
                          });
                        } else {
                          widget.selectedItems.remove('category');
                        }
                      });
                    },
                    selected:
                        widget.selectedItems['category'] == categories[index],
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
