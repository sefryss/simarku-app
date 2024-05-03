import 'package:flutter/material.dart';

class UniversityFilterModalBottomSheet extends StatefulWidget {
  const UniversityFilterModalBottomSheet({
    super.key,
    required this.selectedItems,
  });

  final Map<String, dynamic> selectedItems;

  @override
  State<UniversityFilterModalBottomSheet> createState() =>
      _UniversityFilterModalBottomSheetState();
}

class _UniversityFilterModalBottomSheetState
    extends State<UniversityFilterModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // Replace with your actual data or use static values for demonstration
    final universityFilter = [
      'Universitas Budi Luhur',
      'Gunadarma',
      'UPI',
      'UNSIKA',
      'Telkom University',
      'PNJ',
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ListTile(
          title: Text(
            'Universitas',
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
              universityFilter.length,
              (index) => FilterChip(
                label: Text(universityFilter[index]),
                onSelected: (selected) {
                  setState(() {
                    selected
                        ? widget.selectedItems.addAll({
                            'major': 'ID${index + 1}',
                            'major_name': universityFilter[index],
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
