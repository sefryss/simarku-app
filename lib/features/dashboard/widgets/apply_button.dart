import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/books/bebas_baca/screen/read_book_view.dart';
import 'package:simarku/features/books/tukar_milik/screen/tukar_milik_book_view.dart';
import 'package:simarku/features/books/tukar_pinjam/screen/tukar_pinjam_book_view.dart';
import 'package:simarku/models/models.dart';
import '../../../utils/global/app_config.dart';

class ApplyButton extends StatelessWidget {
  final Category? category;
  final StoryModel book;
  final String receiverId;
  final String senderId;

  const ApplyButton({
    Key? key,
    required this.category,
    required this.book,
    required this.receiverId,
    required this.senderId,
  }) : super(key: key);

  bool get isLoanActive {
    if (book.loanEndTime == null) return false;
    return DateTime.now().isBefore(book.loanEndTime!.toDate());
  }

  String get loanDurationText {
    if (book.loanEndTime == null) return '';
    final duration = book.loanEndTime!.toDate().difference(DateTime.now());
    if (duration.inDays <= 7) {
      return '${duration.inDays} hari';
    } else if (duration.inDays <= 28) {
      return '${(duration.inDays / 7).round()} minggu';
    } else {
      return '1 bulan';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String buttonText = '';
    VoidCallback? onTap;
    bool isDisabled = false;

    // Determine button text and onTap action based on category
    if (category == Category.tukarPinjam) {
      if (isLoanActive) {
        // Special case for e-book type during loan period and current user is involved in the loan
        if (book.bookType == BookType.ebook &&
            (user != null &&
                (user.uid == receiverId || user.uid == senderId))) {
          buttonText = 'Bebas Baca';
          onTap = () {
            Get.to(() => ReadBookView(book: book));
          };
          isDisabled = false;
        } else {
          buttonText = 'Sedang Tukar Pinjam selama $loanDurationText';
          isDisabled = true;
        }
      } else {
        buttonText = 'Tukar Pinjam';
        onTap = () {
          showTukarPinjamDialog(context, book);
        };
      }
    } else if (category == Category.tukarMilik) {
      buttonText = 'Tukar Milik';
      onTap = () {
        showTukarMilikDialog(context, book);
      };
    } else if (category == Category.bebasBaca) {
      buttonText = 'Baca Buku';
      onTap = () {
        Get.to(() => ReadBookView(book: book));
      };
    }

    return Material(
      color: isDisabled ? AppColors.neutral01 : AppColors.primary,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: isDisabled ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: AppTextStyle.paragraphMedium
                .copyWith(color: isDisabled ? AppColors.primary : Colors.white),
          ),
        ),
      ),
    );
  }
}
