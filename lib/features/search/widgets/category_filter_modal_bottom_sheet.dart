import 'package:flutter/material.dart';

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
    // Replace with your actual data or use static values for demonstration
    final categoryFilter = [
      'Fiksi',
      'Non-Fiksi',
      'Pendidikan',
      'Otomotif',
      'Kesehatan',
      'Travel',
      'Masakan',
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
              categoryFilter.length,
              (index) => FilterChip(
                label: Text(categoryFilter[index]),
                onSelected: (selected) {
                  setState(() {
                    selected
                        ? widget.selectedItems.addAll({
                            'major': 'ID${index + 1}',
                            'major_name': categoryFilter[index],
                          })
                        : widget.selectedItems.remove('major');
                  });
                },
                selected: widget.selectedItems['major'] == 'ID${index + 1}',
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
            child: const Text('Pilih'),
          ),
        ),
      ],
    );
  }
}
