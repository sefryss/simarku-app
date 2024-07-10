import 'package:flutter/material.dart';

class CategoryFilterModalBottomSheet extends StatefulWidget {
  const CategoryFilterModalBottomSheet({
    Key? key,
    required this.selectedItems,
    required this.updateSelectedItems,
  }) : super(key: key);

  final Map<String, dynamic> selectedItems;
  final Function(String, dynamic) updateSelectedItems;

  @override
  State<CategoryFilterModalBottomSheet> createState() =>
      _CategoryFilterModalBottomSheetState();
}

class _CategoryFilterModalBottomSheetState
    extends State<CategoryFilterModalBottomSheet> {
  late Map<String, dynamic> tempSelectedItems;

  @override
  void initState() {
    super.initState();
    tempSelectedItems = Map.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Tukar Pinjam',
      'Tukar Milik',
      'Bebas Baca',
      'Koleksi'
    ];

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
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Wrap(
            spacing: 8,
            children: List<Widget>.generate(
              categories.length,
              (index) => FilterChip(
                label: Text(categories[index]),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      tempSelectedItems['category'] = categories[index];
                    } else {
                      tempSelectedItems.remove('category');
                    }
                  });
                },
                selected: tempSelectedItems['category'] == categories[index],
                showCheckmark: false,
              ),
            ),
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: () {
              widget.updateSelectedItems(
                  'category', tempSelectedItems['category']);
              Navigator.pop(context, tempSelectedItems);
            },
            child: const Text('Pilih'),
          ),
        ),
      ],
    );
  }
}
