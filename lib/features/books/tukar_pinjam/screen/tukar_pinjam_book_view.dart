import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simarku/controllers/tukar_pinjam/tukar_pinjam_controller.dart';
import 'package:simarku/features/chat/screen/chat_page.dart';
import 'package:simarku/models/auth/user_model.dart';
import 'package:simarku/models/models.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:simarku/utils/loaders/loaders.dart';
import 'package:simarku/utils/shared_widgets/shared_widget.dart';
import 'package:simarku/utils/validation/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> showTukarPinjamDialog(BuildContext context, StoryModel book) {
  final controller = Get.put(TukarPinjamController());
  bool isRequestPending = false;
  final List<String> loanDurations = [
    '1 Minggu',
    '2 Minggu',
    '3 Minggu',
    '1 Bulan'
  ];
  String selectedDuration = loanDurations[0];

  Future<bool> checkExistingPendingRequest(String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('TukarPinjam')
        .where('senderId', isEqualTo: userId)
        .where('status', isEqualTo: 'Pending')
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.neutral02,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Center(
                      child: Text(
                        "Tukar Pinjam",
                        style: AppTextStyle.heading5SemiBold,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Pilih Bukumu",
                      style: AppTextStyle.body1Regular,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: AppTextStyle.body2Regular
                                .copyWith(color: AppColors.black),
                            validator: (value) =>
                                SMValidator.validateEmptyField(
                                    'Buku Saya', value),
                            enabled: false,
                            controller: controller.ownerController,
                            decoration: InputDecoration(
                              hintText: 'Pilih Bukumu',
                              hintStyle: AppTextStyle.paragraphRegular
                                  .copyWith(color: const Color(0xFF8B849B)),
                              errorMaxLines: 2,
                              errorStyle: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.red),
                              helperStyle: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.b1Yellow),
                              helperMaxLines: 2,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: AppColors.second,
                                    width: 1,
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: AppColors.second,
                                    width: 1,
                                  )),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            await controller.showMyBookDialog(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            height: 45,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.primary),
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.neutral02,
                            ),
                            child: Text(
                              'Pilih Buku',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Pilih Durasi Peminjaman",
                      style: AppTextStyle.body1Regular,
                    ),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedDuration,
                      items: loanDurations
                          .map((duration) => DropdownMenuItem<String>(
                                value: duration,
                                child: Text(duration),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDuration = value!;
                        });
                      },
                      style: AppTextStyle.body2Medium
                          .copyWith(color: AppColors.black),
                      decoration: InputDecoration(
                        enabled: false,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: AppColors.second,
                              width: 1,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: AppColors.second,
                              width: 1,
                            )),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(height: 24),
                    SMElevatedButton(
                      isLoading: isRequestPending,
                      onPressed: isRequestPending
                          ? null
                          : () async {
                              if (controller.selectedBookId.value.isEmpty) {
                                SMLoaders.errorSnackBar(
                                  title: 'Buku Belum Dipilih',
                                  message:
                                      'Pilih buku yang ingin diajukan terlebih dahulu.',
                                );
                                return;
                              }

                              setState(() {
                                isRequestPending = true;
                              });
                              try {
                                final user = FirebaseAuth.instance.currentUser;
                                if (user == null) {
                                  throw 'User tidak login';
                                }

                                final hasPendingRequest =
                                    await checkExistingPendingRequest(user.uid);
                                if (hasPendingRequest) {
                                  throw 'Anda sudah memiliki pengajuan yang sedang diproses';
                                }

                                // Fetch receiver user
                                String receiverUserId;
                                if (book.ownerId is List) {
                                  // Ambil elemen pertama dari list
                                  receiverUserId =
                                      (book.ownerId as List).first as String;
                                } else {
                                  receiverUserId = book.ownerId as String;
                                }
                                UserModel receiverUser = await controller
                                    .fetchRequestedUser(receiverUserId);

                                // Get IDs dynamically
                                final senderBookId = controller.selectedBookId
                                    .value; // ID buku pengirim yang dipilih dari dialog
                                final receiverBookId = book
                                    .id; // ID buku penerima dari detail buku

                                await controller.sendTukarPinjamRequest(
                                  receiverUser,
                                  senderBookId, // langsung sebagai string
                                  receiverBookId!,
                                  selectedDuration,
                                );

                                // Tutup dialog
                                Navigator.of(context).pop();

                                // Beri umpan balik kepada pengguna
                                SMLoaders.successSnackBar(
                                    title: 'Pengajuan Terkirim',
                                    message:
                                        'Permintaan tukar pinjam buku telah diajukan');
                              } catch (e) {
                                // Tampilkan error snackbar jika gagal
                                SMLoaders.errorSnackBar(
                                    title: 'Pengajuan Gagal', message: ' $e');
                              } finally {
                                setState(() {
                                  isRequestPending = false;
                                });
                              }
                            },
                      labelText: 'Ajukan Tukar Pinjam',
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: 10),
                    SMOutlineElevatedButtonWithIcon(
                      borderColor: AppColors.primary,
                      icon: Icon(
                        Icons.chat_outlined,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        Get.to(() => ChatPage());
                      },
                      labelText: 'Tanya Pemilik',
                      labelColor: AppColors.primary,
                      backgroundColor: AppColors.neutral02,
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
