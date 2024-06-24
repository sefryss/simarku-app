import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simarku/controllers/chat/chat_controller.dart';
import 'package:simarku/features/chat/widgets/widgets.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<UserModel> _allUsers = [];
  List<UserModel> _searchList = [];
  bool _isSearching = false;
  String _searchQuery = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: SMBackButton(
          buttonColor: Colors.white,
        ),
        title: _isSearching
            ? TextField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove the underline
                  hintText: 'Cari nama pengguna....',
                  hintStyle: TextStyle(color: Colors.white),
                ),
                autofocus: true,
                style: TextStyle(
                    fontSize: 17, letterSpacing: 0.5, color: Colors.white),
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                    _searchList = _allUsers
                        .where((user) => user.fullName
                            .toLowerCase()
                            .contains(val.toLowerCase()))
                        .toList();
                  });
                },
              )
            : Text(
                'Pesan',
                style: TextStyle(color: AppColors.white),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                _searchQuery = '';
                _searchList.clear();
              });
            },
            icon: Icon(
              _isSearching
                  ? CupertinoIcons.clear_circled_solid
                  : Icons.search_rounded,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No users found.'));
            }

            _allUsers = snapshot.data!.docs
                .map((doc) => UserModel.fromSnapshot(
                    doc as DocumentSnapshot<Map<String, dynamic>>))
                .toList();

            List<UserModel> usersToShow = _isSearching
                ? _searchQuery.isNotEmpty
                    ? _searchList
                    : []
                : _allUsers;

            if (_isSearching &&
                _searchQuery.isNotEmpty &&
                usersToShow.isEmpty) {
              return Center(child: Text('Pengguna tidak ditemukan.'));
            }

            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: usersToShow.length,
              itemBuilder: (context, index) {
                return ChatCard(user: usersToShow[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
