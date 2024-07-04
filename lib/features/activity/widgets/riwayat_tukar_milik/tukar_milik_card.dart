import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simarku/controllers/tukar_milik/tukar_milik_controller.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';

class TukarMilikCard extends StatelessWidget {
  const TukarMilikCard({
    Key? key,
    required this.book,
    required this.sender,
    required this.formattedTimestamp,
    required this.request,
    required this.currentUser,
    required this.controller,
    required this.isSender,
  });

  final StoryModel book;
  final UserModel sender;
  final String formattedTimestamp;
  final TukarMilikModel request;
  final User currentUser;
  final TukarMilikController controller;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 132,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: book.image != null && book.image!.isNotEmpty
                        ? DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: NetworkImage(book.image!),
                          )
                        : null,
                    color: book.image == null || book.image!.isEmpty
                        ? Colors.grey[200]
                        : null,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isSender
                            ? 'Mengajukan Tukar Milik ke ${sender.fullName}'
                            : 'Pengajuan Tukar Milik dari ${sender.fullName}',
                        style: AppTextStyle.body2Regular.copyWith(
                          color: AppColors.neutral06,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(book.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppTextStyle.body2Medium),
                      const SizedBox(height: 4),
                      Text(
                        'Kategori: ${getCategoryString(book.category!)}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: AppTextStyle.body3Regular.copyWith(
                          color: AppColors.neutral06,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Pengajuan: ${formattedTimestamp}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: AppTextStyle.body3Regular.copyWith(
                          color: AppColors.neutral06,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Status: ${request.status}',
                        style: AppTextStyle.body3Regular.copyWith(
                          color: AppColors.neutral06,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (currentUser.uid == request.receiverId &&
                          request.status == 'Pending')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () =>
                                  controller.rejectTukarMilikRequest(request),
                              child: Text('Tolak',
                                  style: AppTextStyle.body2Medium
                                      .copyWith(color: AppColors.primary)),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            InkWell(
                                onTap: () =>
                                    controller.acceptTukarMilikRequest(request),
                                child: Text(
                                  'Terima',
                                  style: AppTextStyle.body2Medium
                                      .copyWith(color: AppColors.second),
                                ))
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

