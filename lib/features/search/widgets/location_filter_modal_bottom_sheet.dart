import 'package:flutter/material.dart';

class LocationFilterModalBottomSheet extends StatefulWidget {
  const LocationFilterModalBottomSheet({
    super.key,
    required this.selectedItems,
  });

  final Map<String, dynamic> selectedItems;

  @override
  State<LocationFilterModalBottomSheet> createState() =>
      _LocationFilterModalBottomSheetState();
}

class _LocationFilterModalBottomSheetState
    extends State<LocationFilterModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // Replace with your actual data or use static values for demonstration
    final locationFilter = [
      'Kab. Tanggerang',
      'Kota Bekasi',
      'DKI Jakarta',
      'Jawa Barat',
      'Jawa Tengah',
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ListTile(
          title: Text(
            'Lokasi',
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
              locationFilter.length,
              (index) => FilterChip(
                label: Text(locationFilter[index]),
                onSelected: (selected) {
                  setState(() {
                    selected
                        ? widget.selectedItems.addAll({
                            'major': 'ID${index + 1}',
                            'major_name': locationFilter[index],
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
