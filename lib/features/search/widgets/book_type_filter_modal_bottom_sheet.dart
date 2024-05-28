import 'package:flutter/material.dart';

class BookTypeFilterModalBottomSheet extends StatefulWidget {
  const BookTypeFilterModalBottomSheet({
    Key? key,
    required this.selectedItems,
    required this.updateSelectedItems,
  }) : super(key: key);

  final Map<String, dynamic> selectedItems;
  final Function(String, dynamic) updateSelectedItems;

  @override
  State<BookTypeFilterModalBottomSheet> createState() =>
      _BookTypeFilterModalBottomSheetState();
}

class _BookTypeFilterModalBottomSheetState
    extends State<BookTypeFilterModalBottomSheet> {
  late Map<String, dynamic> tempSelectedItems;

  @override
  void initState() {
    super.initState();
    tempSelectedItems = Map.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    const List<String> bookTypes = ['Buku Fisik', 'E-Book'];

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
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Wrap(
            spacing: 8,
            children: List<Widget>.generate(
              bookTypes.length,
              (index) => FilterChip(
                label: Text(bookTypes[index]),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      tempSelectedItems['book_type'] = bookTypes[index];
                    } else {
                      tempSelectedItems.remove('book_type');
                    }
                  });
                },
                selected: tempSelectedItems['book_type'] == bookTypes[index],
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
                  'book_type', tempSelectedItems['book_type']);
              Navigator.pop(context, tempSelectedItems);
            },
            child: const Text('Pilih'),
          ),
        ),
      ],
    );
  }
}
