import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simarku/models/models.dart';

class AllFilterModalBottomSheet extends StatefulWidget {
  const AllFilterModalBottomSheet({
    super.key,
    required this.selectedItems,
    required this.updateSelectedItems,
  });

  final Map<String, dynamic> selectedItems;
  final Function(String, dynamic) updateSelectedItems;

  @override
  State<AllFilterModalBottomSheet> createState() =>
      _AllFilterModalBottomSheetState();
}

class _AllFilterModalBottomSheetState extends State<AllFilterModalBottomSheet> {
  late Map<String, dynamic> tempSelectedItems;

  @override
  void initState() {
    super.initState();
    tempSelectedItems = Map.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    const List<String> bookTypes = ['Buku Fisik', 'E-Book'];
    List<String> categories = ['Tukar Pinjam', 'Tukar Milik', 'Bebas Baca'];
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

                      return Wrap(
                        spacing: 8,
                        children: List<Widget>.generate(
                          categories.length,
                          (index) => FilterChip(
                            label: Text(categories[index]),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  tempSelectedItems['category'] =
                                      categories[index];
                                } else {
                                  tempSelectedItems.remove('category');
                                }
                              });
                            },
                            selected: tempSelectedItems['category'] ==
                                categories[index],
                            showCheckmark: false,
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
                                  tempSelectedItems['genre_id'] = [
                                    ...(tempSelectedItems['genre_id'] ?? []),
                                    genres[index].id,
                                  ];
                                } else {
                                  tempSelectedItems['genre_id'] =
                                      List<String>.from(
                                          tempSelectedItems['genre_id']!)
                                        ..remove(genres[index].id);
                                }
                              });
                            },
                            selected: (tempSelectedItems['genre_id'] ?? [])
                                .contains(genres[index].id),
                            showCheckmark: false,
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

                      return Wrap(
                        spacing: 8,
                        children: List<Widget>.generate(
                          bookTypes.length,
                          (index) => FilterChip(
                            label: Text(bookTypes[index]),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  tempSelectedItems['book_type'] =
                                      bookTypes[index];
                                } else {
                                  tempSelectedItems.remove('book_type');
                                }
                              });
                            },
                            selected: tempSelectedItems['book_type'] ==
                                bookTypes[index],
                            showCheckmark: false,
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
              try {
                widget.updateSelectedItems(
                    'category', tempSelectedItems['category']);
                if (tempSelectedItems.containsKey('genre_id') &&
                    (tempSelectedItems['genre_id'] as List).isNotEmpty) {
                  // Kirim filter genre yang dipilih ke fungsi updateSelectedItems
                  widget.updateSelectedItems(
                      'genre_id', tempSelectedItems['genre_id']);
                } else {
                  // Jika genre filter kosong, kirim null atau daftar kosong
                  widget.updateSelectedItems('genre_id', null);
                }
                widget.updateSelectedItems(
                    'book_type', tempSelectedItems['book_type']);
                setState(() {}); // Tambahkan setState di sini
                if (Navigator.canPop(context)) {
                  Navigator.pop(context, tempSelectedItems);
                }
              } catch (e) {
                print('Error: $e');
              }
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
