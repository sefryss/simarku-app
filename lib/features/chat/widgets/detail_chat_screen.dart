import 'package:flutter/material.dart';
import 'package:simarku/controllers/chat/chat_controller.dart';
import 'package:simarku/features/chat/widgets/widgets.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/shared_widgets/sm_back_button.dart';

class DetailChatScreen extends StatefulWidget {
  final UserModel user;
  const DetailChatScreen({super.key, required this.user});

  @override
  State<DetailChatScreen> createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  List<ChatModel> _list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        flexibleSpace: _appBar(widget.user),
        toolbarHeight: 70,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: StreamBuilder(
                stream: ChatController.getAllMessages(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _list.clear();

                    _list.add(ChatModel(
                        toId: ChatController.user.uid,
                        msg:
                            'Hi Mimin Simarku, mau nanya dong apakah saya bisa berdonasi buku? kalau bisa tolong kasih tau langkah-langkahnya min. Thanks.',
                        read: '',
                        type: Type.text,
                        fromId: 'xyz',
                        sent: '12.50 AM'));
                    _list.add(ChatModel(
                        toId: 'xyz',
                        msg:
                            'Haloo, bisa kak, kakak bisa berdonasi buku melalu simarku dengan cara kakak pergi ke aktivitas kemudian pilih Riwayat Donasi, kakak bisa menambahkan buku yang ingin kakak donasikan disana, Thanks.',
                        read: '',
                        type: Type.text,
                        fromId: ChatController.user.uid,
                        sent: '12.52 AM'));
                    if (_list.isNotEmpty) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _list.length,
                        itemBuilder: (context, index) {
                          return MessageCard(
                            message: _list[index],
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text('Gada Chat!'),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            _chatInput(),
          ],
        ),
      ),
    );
  }
}

Widget _appBar(UserModel user) {
  return SafeArea(
    child: Row(
      children: [
        // Back button
        SMBackButton(
          buttonColor: Colors.white,
        ),

        // User profile
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: user.profilePicture.isNotEmpty
              ? Image.network(
                  user.profilePicture,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/profile-placeholder.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(
          width: 10,
        ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.fullName,
              style:
                  AppTextStyle.body1Regular.copyWith(color: AppColors.n1White),
            ),
            Text(
              'Terakhir dilihat tidak tersedia',
              style:
                  AppTextStyle.body4Regular.copyWith(color: AppColors.n3white),
            )
          ],
        ),
      ],
    ),
  );
}

// Bottom chat input field
Widget _chatInput() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    child: Row(
      children: [
        // Input field & buttons
        Expanded(
          child: Card(
            color: AppColors.n1White,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                // Emoji button
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file_rounded,
                        color: AppColors.second, size: 25)),

                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onTap: () {},
                  decoration: const InputDecoration(
                      hintText: 'Type Something...',
                      hintStyle: TextStyle(color: AppColors.grey),
                      border: InputBorder.none),
                )),

                // Adding some space
                SizedBox(width: 8),
              ],
            ),
          ),
        ),

        // Send message button
        MaterialButton(
          onPressed: () {
            //   if (_textController.text.isNotEmpty) {
            //     if (_list.isEmpty) {
            //       // On first message (add user to my_user collection of chat user)
            //       APIs.sendFirstMessage(
            //           widget.user, _textController.text, Type.text);
            //     } else {
            //       // Simply send message
            //       APIs.sendMessage(
            //           widget.user, _textController.text, Type.text);
            //     }
            //     _textController.text = '';
            //   }
          },
          minWidth: 0,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
          shape: const CircleBorder(),
          color: AppColors.primary,
          child: const Icon(Icons.send, color: Colors.white, size: 28),
        )
      ],
    ),
  );
}
