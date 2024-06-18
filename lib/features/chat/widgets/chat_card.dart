import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/features/chat/widgets/widgets.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/utils/global/app_config.dart';

class ChatCard extends StatelessWidget {
  final UserModel user;
  const ChatCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 4),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => Get.to(() => DetailChatScreen(user: user)),
        child: ListTile(
          leading: ClipRRect(
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
          title: Text(
            user.fullName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.body2Regular,
          ),
          subtitle: Text(
            user.email,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.body4Regular.copyWith(color: AppColors.grey),
          ),
          trailing: Text(
            '18.00 AM',
            style: AppTextStyle.body3Regular.copyWith(color: AppColors.grey),
          ),
        ),
      ),
    );
  }
}
