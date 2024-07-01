import 'package:flutter/material.dart';
import 'package:simarku/features/search/widgets/all_filter_modal_bottom_sheet.dart';
import 'package:simarku/features/search/widgets/category_filter_modal_bottom_sheet.dart';
import 'package:simarku/features/search/widgets/book_type_filter_modal_bottom_sheet.dart';
import 'package:simarku/features/search/widgets/genre_filter_modal_bottom_sheet.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/global/app_theme.dart';

class BookFilter extends StatefulWidget implements PreferredSizeWidget {
  const BookFilter({
    Key? key,
    required this.selectedItems,
    required this.updateSelectedItems,
  }) : super(key: key);

  final Map<String, dynamic> selectedItems;
  final Function(String, dynamic) updateSelectedItems;

  @override
  _BookFilterState createState() => _BookFilterState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _BookFilterState extends State<BookFilter> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.theme;
    final filters = [
      CustomFilterChip(
        label: const Text('Kategori '),
        onSelected: (selected) {
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
                selectedItems: widget.selectedItems,
                updateSelectedItems: widget.updateSelectedItems,
              );
            },
          );
        },
        selected: widget.selectedItems.containsKey('category'),
      ),
      CustomFilterChip(
        label: const Text('Genre'),
        onSelected: (selected) {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            builder: (context) {
              return GenreFilterModalBottomSheet(
                selectedItems: widget.selectedItems,
                updateSelectedItems: widget.updateSelectedItems,
              );
            },
          );
        },
        selected: widget.selectedItems.containsKey('genre_id'),
      ),
      CustomFilterChip(
        label: const Text('Jenis Buku'),
        onSelected: (selected) {
          showModalBottomSheet(
            context: context,
            showDragHandle: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            builder: (context) {
              return BookTypeFilterModalBottomSheet(
                selectedItems: widget.selectedItems,
                updateSelectedItems: widget.updateSelectedItems,
              );
            },
          );
        },
        selected: widget.selectedItems.containsKey('book_type'),
      ),
    ];

    return Container(
      height: 56,
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
          _FilterChip(
            selectedCount: widget.selectedItems.length,
            selectedItems: widget.selectedItems,
            updateSelectedItems: widget.updateSelectedItems,
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.selectedItems,
    required this.updateSelectedItems,
    required this.selectedCount,
  });

  final Map<String, dynamic> selectedItems;
  final Function(String, dynamic) updateSelectedItems;
  final int selectedCount;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = AppTheme.theme;

    const contentColor = Color(0xFF697586);
    const iconTheme = IconThemeData(size: 18, color: contentColor);

    final isVisibleCount = selectedCount > 0;

    return isVisibleCount
        ? Badge.count(
            count: selectedCount,
            backgroundColor: AppColors.primary,
            child: _buildFilterChip(context, size, theme, iconTheme),
          )
        : _buildFilterChip(context, size, AppTheme.theme, iconTheme);
  }

  Widget _buildFilterChip(BuildContext context, Size size, ThemeData theme,
      IconThemeData iconTheme) {
    return FilterChip.elevated(
      backgroundColor: AppColors.white,
      showCheckmark: false,
      elevation: 2,
      surfaceTintColor: Colors.white,
      padding: const EdgeInsets.all(8),
      label: SizedBox(
        height: 20,
        child:
            IconTheme(data: iconTheme, child: Icon(Icons.filter_alt_rounded)),
      ),
      selected: false,
      onSelected: (value) {
        showModalBottomSheet<Map<String, dynamic>>(
          context: context,
          builder: (context) {
            return Container(
              constraints: BoxConstraints(maxHeight: size.height * 0.8),
              decoration: BoxDecoration(
                color: AppTheme.theme.scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: AllFilterModalBottomSheet(
                selectedItems: selectedItems,
                updateSelectedItems: (key, value) {
                  updateSelectedItems(key, value);
                },
              ),
            );
          },
          constraints: BoxConstraints(maxHeight: size.height * 0.8),
          showDragHandle: true,
          backgroundColor: AppTheme.theme.scaffoldBackgroundColor,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
        );
      },
    );
  }
}

class CustomFilterChip extends StatelessWidget {
  const CustomFilterChip({
    Key? key,
    required this.label,
    this.onSelected,
    this.selected = false,
  }) : super(key: key);

  final Widget label;
  final ValueChanged<bool>? onSelected;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FilterChip(
      showCheckmark: false,
      padding: const EdgeInsets.only(left: 16, top: 8, right: 8, bottom: 8),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          label,
          const SizedBox(width: 8),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: Color(0xFF697586),
          ),
        ],
      ),
      selected: selected,
      backgroundColor:
          selected ? theme.scaffoldBackgroundColor : AppColors.white,
      onSelected: onSelected,
      side: BorderSide(color: AppColors.neutral04),
    );
  }
}
