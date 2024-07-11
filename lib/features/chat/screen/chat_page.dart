import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simarku/controllers/chat/chat_controller.dart';
import 'package:simarku/features/chat/widgets/widgets.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/loaders/loaders.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<UserModel> _list = [];
  List<UserModel> _searchList = [];
  bool _isSearching = false;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //for hiding keyboard when a tap is detected on screen
      onTap: FocusScope.of(context).unfocus,
      child: PopScope(
        canPop: !_isSearching,
        onPopInvoked: (_) async {
          if (_isSearching) {
            setState(() => _isSearching = !_isSearching);
          } else {
            Navigator.of(context).pop();
          }
        },

        //
        child: Scaffold(
          //app bar
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: SMBackButton(
              buttonColor: Colors.white,
            ),
            title: _isSearching
                ? TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Cari pengguna...',
                        hintStyle: AppTextStyle.body3Regular
                            .copyWith(color: AppColors.white)),
                    autofocus: true,
                    style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                    //when search text changes then updated search list
                    onChanged: (val) {
                      //search logic
                      _searchList.clear();

                      for (var i in _list) {
                        if (i.fullName
                            .toLowerCase()
                            .contains(val.toLowerCase())) {
                          _searchList.add(i);
                          setState(() {
                            _searchList;
                          });
                        }
                      }
                    },
                  )
                : const Text(
                    'Pesan',
                    style: TextStyle(color: AppColors.white),
                  ),
            actions: [
              //search user button
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(
                    _isSearching
                        ? CupertinoIcons.clear_circled_solid
                        : Icons.search,
                    color: AppColors.white,
                  )),
            ],
          ),

          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: () {
                  _addChatUserDialog(context);
                },
                child: const Icon(
                  Icons.person_add_outlined,
                  color: AppColors.neutral02,
                )),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: StreamBuilder(
              stream: ChatController.getMyUsersId(),

              //get id of only known users
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  //if data is loading
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());

                  //if some or all data is loaded then show it
                  case ConnectionState.active:
                  case ConnectionState.done:
                    return StreamBuilder(
                      stream: ChatController.getAllUsers(
                          snapshot.data?.docs.map((e) => e.id).toList() ?? []),

                      //get only those user, who's ids are provided
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          //if data is loading
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                          // return const Center(
                          //     child: CircularProgressIndicator());

                          //if some or all data is loaded then show it
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final data = snapshot.data?.docs;
                            _list = data
                                    ?.map((e) => UserModel.fromJson(e.data()))
                                    .toList() ??
                                [];

                            if (_list.isNotEmpty) {
                              return ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  itemCount: _isSearching
                                      ? _searchList.length
                                      : _list.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ChatCard(
                                        user: _isSearching
                                            ? _searchList[index]
                                            : _list[index]);
                                  });
                            } else {
                              return const Center(
                                child: Text('Belum ada pesan!',
                                    style: AppTextStyle.body2Regular),
                              );
                            }
                        }
                      },
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  // for adding new chat user
  void _addChatUserDialog(BuildContext context) {
    String fullName = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: Row(
                children: [
                  Text('Tambah Pengguna', style: AppTextStyle.body2Regular)
                ],
              ),

              //content
              content: TextFormField(
                maxLines: null,
                onChanged: (value) => fullName = value,
                decoration: InputDecoration(
                    hintText: 'Nama Lengkap Pengguna',
                    hintStyle: AppTextStyle.body3Regular,
                    prefixIcon:
                        const Icon(Icons.people, color: AppColors.primary),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: Text('Batal', style: TextStyle(fontSize: 16))),

                //add button
                MaterialButton(
                    onPressed: () async {
                      //hide alert dialog
                      Navigator.pop(context);
                      if (fullName.isNotEmpty) {
                        await ChatController.addChatUser(fullName)
                            .then((value) {
                          if (!value) {
                            SMLoaders.errorSnackBar(
                              title: 'Pengguna tidak ditemukan',
                              message: 'Pastikan nama pengguna benar!',
                            );
                          }
                        });
                      }
                    },
                    child: Text(
                      'Tambah',
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ));
  }
}
