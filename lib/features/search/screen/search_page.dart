import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/search/widgets/widgets.dart';
import 'package:simarku/utils/global/app_config.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final RxString queryText = ''.obs;
  final TextEditingController textEditingController = TextEditingController();
  Map<String, dynamic> selectedItems = {};

  void updateSelectedItems(String key, dynamic value) {
    setState(() {
      if (value != null) {
        selectedItems[key] = value;
      } else {
        selectedItems.remove(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Jelajah',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                child: searchField(context, 'Cari Buku', textEditingController,
                    onChanged: (value) {
                  setState(() {
                    queryText.value = value;
                  });
                }),
              ),
              SizedBox(height: 16),
              BookFilter(
                selectedItems: selectedItems,
                updateSelectedItems: updateSelectedItems,
              ),
              SizedBox(height: 24),
              PopularBookWidget(
                queryText: queryText,
                selectedItems: selectedItems,
              ),
              SizedBox(height: 16),
              PhysicalBookWidget(
                queryText: queryText,
                selectedItems: selectedItems,
              ),
              SizedBox(height: 16),
              EBookWidget(
                queryText: queryText,
                selectedItems: selectedItems,
              ),
              //   SizedBox(height: 16),
              //   CollectionBookWidget(
              //     queryText: queryText,
              //     selectedItems: selectedItems,
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
