import 'package:flutter/material.dart';
import 'package:simarku/utils/global/app_config.dart';

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
    final scheduleFilter = [
      'Novel',
      'Cerpen',
      'Puisi',
      'Drama',
      'Misteri',
      'Thriller',
      'Fantasi',
      'Sains Fiksi',
      'Romansa',
      'Sejarah',
      'Biografi',
      'Horor',
      'Humor',
      'Agama & Spiritualitas',
    ];
    final eventTypeFilter = [
      'Buku Fisik',
      'E-Book',
    ];
    final locationFilter = [
      'Kab. Tanggerang',
      'Kota Bekasi',
      'DKI Jakarta',
      'Jawa Barat',
      'Jawa Tengah',
    ];
    final universityFilter = [
      'Universitas Budi Luhur',
      'Gunadarma',
      'UPI',
      'UNSIKA',
      'Telkom University',
      'PNJ',
    ];

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
                    filters: List<Widget>.generate(
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
                        selected:
                            widget.selectedItems['major'] == 'ID${index + 1}',
                      ),
                    ),
                  ),
                  _FilterSection(
                    title: 'Genre',
                    filters: List<Widget>.generate(
                      scheduleFilter.length,
                      (index) => FilterChip(
                        label: Text(' ${scheduleFilter[index]}'),
                        onSelected: (selected) {
                          setState(() {
                            selected
                                ? widget.selectedItems
                                    .addAll({'semester': scheduleFilter[index]})
                                : widget.selectedItems.remove('semester');
                          });
                        },
                        selected: widget.selectedItems['semester'] ==
                            scheduleFilter[index],
                      ),
                    ),
                  ),
                  _FilterSection(
                    title: 'Jenis Buku',
                    filters: List<Widget>.generate(
                      eventTypeFilter.length,
                      (index) => FilterChip(
                        label: Text('${eventTypeFilter[index]} SKS'),
                        onSelected: (selected) {
                          setState(() {
                            selected
                                ? widget.selectedItems
                                    .addAll({'credit': eventTypeFilter[index]})
                                : widget.selectedItems.remove('credit');
                          });
                        },
                        selected: widget.selectedItems['credit'] ==
                            eventTypeFilter[index],
                      ),
                    ),
                  ),
                  // _FilterSection(
                  //   title: 'Lokasi',
                  //   filters: List<Widget>.generate(
                  //     locationFilter.length,
                  //     (index) => FilterChip(
                  //       label: Text(locationFilter[index]),
                  //       onSelected: (selected) {
                  //         setState(() {
                  //           selected
                  //               ? widget.selectedItems
                  //                   .addAll({'level': locationFilter[index]})
                  //               : widget.selectedItems.remove('level');
                  //         });
                  //       },
                  //       selected: widget.selectedItems['level'] ==
                  //           locationFilter[index],
                  //     ),
                  //   ),
                  // ),
                  // _FilterSection(
                  //   title: 'Universitas',
                  //   filters: List<Widget>.generate(
                  //     universityFilter.length,
                  //     (index) => FilterChip(
                  //       label: Text(universityFilter[index]),
                  //       onSelected: (selected) {
                  //         setState(() {
                  //           selected
                  //               ? widget.selectedItems
                  //                   .addAll({'level': universityFilter[index]})
                  //               : widget.selectedItems.remove('level');
                  //         });
                  //       },
                  //       selected: widget.selectedItems['level'] ==
                  //           universityFilter[index],
                  //     ),
                  //   ),
                  // ),
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
    required this.filters,
  });

  final String title;
  final List<Widget> filters;

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
          Wrap(
            spacing: 8,
            children: filters,
          )
        ],
      ),
    );
  }
}
