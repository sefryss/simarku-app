import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/books/book_controller.dart';
import 'package:simarku/features/books/edit_book/widgets/widgets.dart';
import 'package:simarku/models/book_model.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class EditBookPage extends StatelessWidget {
  final StoryModel book;

  const EditBookPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookController());
    controller
        .setAllDataFromStoryModel(book); // Set data from the selected book

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: SMBackButton(
            buttonColor: Colors.white,
          ),
          title: Text(
            'Edit Buku',
            style: TextStyle(color: AppColors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: AppColors.primary,
                    height: 220,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: BookImageWidget(),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Form(
                    key: controller.bookFormKey,
                    child: Column(
                      children: [
                        BookTitleWidget(),
                        SizedBox(
                          height: 16.0,
                        ),
                        BookCategoryWidget(),
                        SizedBox(
                          height: 16.0,
                        ),
                        BookTypeWidget(),
                        SizedBox(
                          height: 16.0,
                        ),
                        BookGenreWidget(),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BookAuthorWidget(),
                            SizedBox(
                              width: 16.0,
                            ),
                            BookPublisherWidget(),
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BookReleaseDateWidget(),
                            SizedBox(
                              width: 16,
                            ),
                            BookPageWidget(),
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        BookOwnerWidget(),
                        SizedBox(
                          height: 16.0,
                        ),
                        BookDescWidget(),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 24,
            ),
            child: SubmitBookButton(bookId: book.id!)));
  }
}
