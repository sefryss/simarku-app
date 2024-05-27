import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simarku/models/models.dart';


class AllFilterModalBottomSheet extends StatefulWidget {
  const AllFilterModalBottomSheet({
    super.key,
    required this.selectedItems,
  });

  final Map<String, dynamic> selectedItems;

  @override
  State<AllFilterModalBottomSheet> createState() =>
      _AllFilterModalBottomSheetState();
}

class _AllFilterModalBottomSheetState extends State<AllFilterModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ListTile(
          title: Text(
            'Filter',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              height: 30 / 20,
            ),
          ),
          contentPadding: EdgeInsets.only(left: 16, right: 8),
        ),
        const Divider(height: 1),
        Expanded(
          child: Scrollbar(
            thickness: 4,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _FilterSection(
                    title: 'Kategori',
                    stream: FirebaseFirestore.instance
                        .collection('books')
                        .snapshots(),
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

                      return Wrap(
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
                            selected: widget.selectedItems['category'] ==
                                categories[index],
                          ),
                        ),
                      );
                    },
                  ),
                  _FilterSection(
                    title: 'Genre',
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

                      return Wrap(
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
                            selected: widget.selectedItems['major'] ==
                                genres[index].id,
                          ),
                        ),
                      );
                    },
                  ),
                  _FilterSection(
                    title: 'Jenis Buku',
                    stream: FirebaseFirestore.instance
                        .collection('books')
                        .snapshots(),
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

                      return Wrap(
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
                            selected: widget.selectedItems['book_type'] ==
                                bookTypes[index],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: () {
              widget.selectedItems.addAll({'apply': true});
              Navigator.pop(context, widget.selectedItems);
            },
            child: const Text(
              'Pilih',
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({
    required this.title,
    required this.stream,
    required this.builder,
  });

  final String title;
  final Stream<QuerySnapshot> stream;
  final AsyncWidgetBuilder<QuerySnapshot> builder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              height: 21 / 14,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: builder,
          ),
        ],
      ),
    );
  }
}
