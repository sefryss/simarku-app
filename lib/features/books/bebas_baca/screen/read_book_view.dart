import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';
import 'package:simarku/controllers/books/detail_book_controller.dart';
import 'package:simarku/controllers/firbase_data/firebase_data.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/constant.dart';
import 'package:simarku/utils/constantWidget.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/network/network_manager.dart';
import 'package:simarku/utils/pref_data.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:internet_file/internet_file.dart';

class ReadBookView extends StatefulWidget {
  final StoryModel book;
  const ReadBookView({
    super.key,
    required this.book,
  });

  @override
  State<ReadBookView> createState() => _ReadBookViewState();
}

class _ReadBookViewState extends State<ReadBookView> {
  PdfControllerPinch? pdfPinchController;

  addViewStory() {
    Future.delayed(Duration.zero, () async {
      FireBaseData.addStoryViews(widget.book, context);
    });
  }

  RecentController recentController = Get.put(RecentController());

  @override
  void initState() {
    super.initState();
    getBytes();
    PrefData.setRecentReadBook(widget.book.pdf ?? "");
    PrefData.setRecentReadBookName(widget.book.name ?? "");
    recentController.setRecentList(widget.book.id.toString());
    addViewStory();
  }

  Uint8List? _pdfBytes;
  void getBytes() async {
    FirebaseStorage storage =
        FirebaseStorage.instanceFor(bucket: 'e-book-a4896.appspot.com');

    Reference pdfRef = storage.refFromURL(widget.book.pdf ?? "");
    await pdfRef.getDownloadURL().then((url) async {
      _pdfBytes = await InternetFile.get(url);
      setState(() {
        pdfPinchController = PdfControllerPinch(
          document: PdfDocument.openData(_pdfBytes!),
        );
      });
    }).catchError((error) {
      print("Error getting PDF data: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        leading: SMBackButton(
          buttonColor: Colors.white,
        ),
        title: Text(
          widget.book.name ?? '',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: NetworkManager.instance.isConnected(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: getLottieAnimationWidget());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Terjadi kesalahan. Periksa koneksi anda'));
            } else {
              final isConnected = snapshot.data ?? false;
              if (isConnected) {
                if (pdfPinchController == null) {
                  return Center(child: CircularProgressIndicator());
                }

                return Container(
                  color: context.theme.focusColor,
                  child: PdfViewPinch(
                    controller: pdfPinchController!,
                    onPageChanged: (page) {},
                    builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
                      options: DefaultBuilderOptions(
                        loaderSwitchDuration: Duration(seconds: 1),
                        transitionBuilder: SomeWidget.transitionBuilder,
                      ),
                      documentLoaderBuilder: (context) =>
                          getLottieAnimationWidget(),
                      errorBuilder: (context, error) =>
                          Center(child: Text(error.toString())),
                      builder: SomeWidget.builder,
                    ),
                  ),
                );
              } else {
                return getProgressWidget(context);
              }
            }
          },
        ),
      ),
    );
  }
}

class SomeWidget {
  static Widget builder(
    BuildContext context,
    PdfViewPinchBuilders builders,
    PdfLoadingState state,
    WidgetBuilder loadedBuilder,
    PdfDocument? document,
    Exception? loadingError,
  ) {
    final Widget content = () {
      switch (state) {
        case PdfLoadingState.loading:
          return KeyedSubtree(
            key: const Key('pdfx.root.loading'),
            child: builders.documentLoaderBuilder?.call(context) ??
                Container(color: Colors.green),
          );
        case PdfLoadingState.error:
          return KeyedSubtree(
            key: const Key('pdfx.root.error'),
            child: builders.errorBuilder?.call(context, loadingError!) ??
                Center(child: Text(loadingError.toString())),
          );
        case PdfLoadingState.success:
          return KeyedSubtree(
            key: Key('pdfx.root.success.${document!.id}'),
            child: loadedBuilder(context),
          );
      }
    }();

    final defaultBuilder =
        builders as PdfViewPinchBuilders<DefaultBuilderOptions>;
    final options = defaultBuilder.options;

    return AnimatedSwitcher(
      duration: options.loaderSwitchDuration,
      transitionBuilder: options.transitionBuilder,
      child: content,
    );
  }

  static Widget transitionBuilder(Widget child, Animation<double> animation) =>
      FadeTransition(opacity: animation, child: child);

  static PhotoViewGalleryPageOptions pageBuilder(
    BuildContext context,
    Future<PdfPageImage> pageImage,
    int index,
    PdfDocument document,
  ) =>
      PhotoViewGalleryPageOptions(
        imageProvider: PdfPageImageProvider(
          pageImage,
          index,
          document.id,
        ),
        minScale: PhotoViewComputedScale.contained * 1,
        maxScale: PhotoViewComputedScale.contained * 3.0,
        initialScale: PhotoViewComputedScale.contained * 1.0,
        heroAttributes: PhotoViewHeroAttributes(tag: '${document.id}-$index'),
      );
}
