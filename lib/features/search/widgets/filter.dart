import 'package:flutter/material.dart';
import 'package:simarku/features/search/widgets/all_filter_modal_bottom_sheet.dart';
import 'package:simarku/features/search/widgets/category_filter_modal_bottom_sheet.dart';
import 'package:simarku/features/search/widgets/event_type_filter_modal_bottom_sheet.dart';
import 'package:simarku/features/search/widgets/location_filter_modal_bottom_sheet.dart';
import 'package:simarku/features/search/widgets/schedule_filter_modal_bottom_sheet.dart';
import 'package:simarku/features/search/widgets/university_filter_modal_bottom_sheet.dart';
import 'package:simarku/utils/global/app_config.dart';

class EventFilter extends StatelessWidget implements PreferredSizeWidget {
  const EventFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> selectedItems = {};
    final theme = Theme.of(context);
    final filters = [
      CustomFilterChip(
        label: const Text('Kategori '),
        onSelected: (_) {
          // Handle the selection logic
          showModalBottomSheet(
              context: context,
              showDragHandle: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              builder: (context) {
                return CategoryFilterModalBottomSheet(
                    selectedItems: selectedItems);
              });
        },
        selected: false, // Set this based on your static data
      ),
      CustomFilterChip(
        label: const Text('Genre'),
        onSelected: (_) {
          // Handle the selection logic
          showModalBottomSheet(
              context: context,
              showDragHandle: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              builder: (context) {
                return ScheduleFilterModalBottomSheet(
                    selectedItems: selectedItems);
              });
        },
        selected: false, // Set this based on your static data
      ),
      CustomFilterChip(
        label: const Text(
          'Jenis Buku',
        ),
        onSelected: (_) {
          // Handle the selection logic
          showModalBottomSheet(
              context: context,
              showDragHandle: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              builder: (context) {
                return EventTypeFilterModalBottomSheet(
                    selectedItems: selectedItems);
              });
        },
        selected: false, // Set this based on your static data
      ),
      // CustomFilterChip(
      //   label: const Text('Lokasi'),
      //   onSelected: (_) {
      //     // Handle the selection logic
      //     showModalBottomSheet(
      //         context: context,
      //         showDragHandle: true,
      //         backgroundColor: theme.scaffoldBackgroundColor,
      //         isScrollControlled: true,
      //         shape: const RoundedRectangleBorder(
      //           borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      //         ),
      //         builder: (context) {
      //           return LocationFilterModalBottomSheet(
      //               selectedItems: selectedItems);
      //         });
      //   },
      //   selected: false, // Set this based on your static data
      // ),
      // CustomFilterChip(
      //   label: const Text('Universitas'),
      //   onSelected: (_) {
      //     // Handle the selection logic
      //     showModalBottomSheet(
      //         context: context,
      //         showDragHandle: true,
      //         backgroundColor: theme.scaffoldBackgroundColor,
      //         isScrollControlled: true,
      //         shape: const RoundedRectangleBorder(
      //           borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      //         ),
      //         builder: (context) {
      //           return UniversityFilterModalBottomSheet(
      //               selectedItems: selectedItems);
      //         });
      //   },
      //   selected: false, // Set this based on your static data
      // ),
    ];

    return Container(
      height: 56,
      // padding: const EdgeInsets.only(left: 16),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16),
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 48, right: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => filters[index],
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemCount: filters.length,
            ),
          ),
          const _FilterChip(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _FilterChip extends StatelessWidget {
  const _FilterChip();

  @override
  Widget build(BuildContext context) {
    const contentColor = Color(0xFF697586);
    const iconTheme = IconThemeData(size: 18, color: contentColor);

    return Badge.count(
      count: 0,
      backgroundColor: AppColors.primary,
      child: FilterChip.elevated(
        elevation: 2,
        surfaceTintColor: Colors.white,
        padding: const EdgeInsets.all(8),
        label: const SizedBox(
          height: 20,
          child:
              IconTheme(data: iconTheme, child: Icon(Icons.filter_alt_rounded)),
        ),
        selected: false,
        onSelected: (value) {
          final size = MediaQuery.of(context).size;
          final theme = Theme.of(context);
          Map<String, dynamic> selectedItems = {}; // Define selectedItems here

          showModalBottomSheet<Map<String, dynamic>>(
            context: context,
            builder: (context) {
              // Add the 'builder' parameter

              return Container(
                  // Replace with the actual content of your bottom sheet
                  constraints: BoxConstraints(maxHeight: size.height * 0.8),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: AllFilterModalBottomSheet(
                      selectedItems:
                          selectedItems) // Replace with your actual content
                  );
            },
            constraints: BoxConstraints(maxHeight: size.height * 0.8),
            showDragHandle: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
          );
        },
      ),
    );
  }
}

class CustomFilterChip extends StatelessWidget {
  const CustomFilterChip({
    super.key,
    required this.label,
    this.onSelected,
    this.selected = false,
  });

  final Widget label;
  final ValueChanged<bool>? onSelected;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    const contentColor = Color(0xFF697586);
    const iconTheme = IconThemeData(size: 18, color: contentColor);

    return FilterChip(
      padding: const EdgeInsets.only(left: 16, top: 8, right: 8, bottom: 8),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          label,
          const SizedBox(width: 8),
          const IconTheme(
            data: iconTheme,
            child: Icon(Icons.keyboard_arrow_down_rounded),
          ),
        ],
      ),
      selected: selected,
      onSelected: onSelected,
      side: BorderSide(color: AppColors.neutral04),
    );
  }
}
