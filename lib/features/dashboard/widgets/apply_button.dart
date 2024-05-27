import 'package:flutter/material.dart';
import 'package:simarku/features/books/bebas_baca/screen/read_book_view.dart';
import 'package:simarku/features/books/tukar_milik/screen/tukar_milik_book_view.dart';
import 'package:simarku/features/books/tukar_pinjam/screen/tukar_pinjam_book_view.dart';
import 'package:simarku/models/models.dart';
import '../../../utils/global/app_config.dart';

class ApplyButton extends StatelessWidget {
  final Category? category;
  final StoryModel book; // Add category property
  const ApplyButton({super.key, required this.category, required this.book});

  @override
  Widget build(BuildContext context) {
    String buttonText;
    VoidCallback? onTap;

    // Determine button text and onTap action based on category
    switch (category) {
      case Category.tukarPinjam:
        buttonText = 'Tukar Pinjam';
        onTap = () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TukarPinjamBookView(),
            ),
          );
        };
        break;
      case Category.tukarMilik:
        buttonText = 'Tukar Milik';
        onTap = () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TukarMilikBookView(),
            ),
          );
        };
        break;
      case Category.bebasBaca:
        buttonText = 'Baca Buku';
        onTap = () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReadBookView(
                book: book,
              ),
            ),
          );
        };
        break;
      default:
        buttonText = '';
        onTap = null;
    }

    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: AppTextStyle.paragraphMedium.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
