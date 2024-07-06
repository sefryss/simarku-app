import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdfx/pdfx.dart';

class ReadPDFView extends StatefulWidget {
  final String pdfUrl;
  final String pdfFileName;

  const ReadPDFView({
    required this.pdfUrl,
    required this.pdfFileName,
  });

  @override
  _ReadPDFViewState createState() => _ReadPDFViewState();
}

class _ReadPDFViewState extends State<ReadPDFView> {
  PdfController? pdfController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    try {
      // Mendapatkan URL download dari Firebase Storage
      final Reference pdfRef = storage.ref(widget.pdfUrl);
      final pdfBytes = await pdfRef.getData();

      if (pdfBytes != null) {
        setState(() {
          pdfController = PdfController(
            document: PdfDocument.openData(pdfBytes),
          );
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("Error: File tidak ditemukan atau tidak dapat diakses.");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdfFileName),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : pdfController == null
                ? Text('Gagal memuat file PDF.')
                : PdfView(
                    controller: pdfController!,
                    onDocumentError: (error) {
                      print("Error loading PDF: $error");
                    },
                    // onPageError: (page, error) {
                    //   print("Error loading page $page: $error");
                    // },
                    // onViewCreated: (PdfViewController viewController) {
                    //   // You can use the controller to programmatically interact with the PDF viewer
                    // },
                  ),
      ),
    );
  }
}
