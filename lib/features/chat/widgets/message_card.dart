import 'package:flutter/material.dart';
import 'package:simarku/controllers/chat/chat_controller.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';

class MessageCard extends StatelessWidget {
  final ChatModel message;
  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return ChatController.user.uid == message.fromId
        ? _greenMessage(context)
        : _blueMessage(context);
  }

  Widget _blueMessage(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                ),
              ),
              child: Text(
                message.msg,
                style:
                    AppTextStyle.body3Regular.copyWith(color: AppColors.white),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            message.sent,
            style: AppTextStyle.body4Regular.copyWith(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _greenMessage(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.second,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  topLeft: Radius.circular(12),
                ),
              ),
              child: Text(
                message.msg,
                style:
                    AppTextStyle.body3Regular.copyWith(color: AppColors.white),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            message.sent,
            style: AppTextStyle.body4Regular.copyWith(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
