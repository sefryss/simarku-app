import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:simarku/features/article/screen/all_article/screen/all_article_page.dart';
import 'package:simarku/features/books/bebas_baca/screen/all_bebas_baca_view.dart';
import 'package:simarku/features/books/tukar_milik/screen/all_tukar_milik_view.dart';
import 'package:simarku/features/books/tukar_pinjam/screen/all_tukar_pinjam_view.dart';
import 'package:simarku/utils/global/app_config.dart';

class MainFeature extends StatelessWidget {
  const MainFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Fitur Tukar Pinjam
        GestureDetector(
          onTap: () {
            Get.to(() => AllTukarPinjamView());
          },
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 58,
                    child:
                        SvgPicture.asset('assets/icons/background_fitur.svg'),
                  ),
                  SizedBox(
                    width: 32,
                    child: Image.asset('assets/icons/tukar_pinjam.png'),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Tukar \nPinjam',
                style: AppTextStyle.body4Medium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        //Fitur Tukar Milik
        GestureDetector(
          onTap: () {
            Get.to(() => AllTukarMilikView());
          },
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 58,
                    child:
                        SvgPicture.asset('assets/icons/background_fitur.svg'),
                  ),
                  SizedBox(
                    width: 32,
                    child: Image.asset('assets/icons/book swap.png'),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Tukar \nMilik',
                style: AppTextStyle.body4Medium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        //Fitur Donasi Buku
        GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 58,
                    child:
                        SvgPicture.asset('assets/icons/background_fitur.svg'),
                  ),
                  SizedBox(
                    width: 32,
                    child: Image.asset('assets/icons/donation book.png'),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Donasi \nBuku',
                style: AppTextStyle.body4Medium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        //Fitur Lainnya
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return AllFeature();
              },
            );
          },
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 58,
                    child:
                        SvgPicture.asset('assets/icons/background_fitur.svg'),
                  ),
                  SizedBox(
                    width: 32,
                    child: Image.asset('assets/icons/all.png'),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Fitur \nLainnya',
                style: AppTextStyle.body4Medium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AllFeature extends StatelessWidget {
  const AllFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.45,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  height: 4,
                  width: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.neutral04),
                ),
                const SizedBox(height: 16),
                Text(
                  'Semua Fitur',
                  style: AppTextStyle.body2SemiBold,
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Fitur Tukar Pinjam
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => AllTukarPinjamView());
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 58,
                                          child: SvgPicture.asset(
                                              'assets/icons/background_fitur.svg'),
                                        ),
                                        SizedBox(
                                          width: 32,
                                          child: Image.asset(
                                              'assets/icons/tukar_pinjam.png'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      'Tukar \nPinjam',
                                      style: AppTextStyle.body4Medium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              //Fitur Tukar Milik
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => AllTukarMilikView());
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 58,
                                          child: SvgPicture.asset(
                                              'assets/icons/background_fitur.svg'),
                                        ),
                                        SizedBox(
                                          width: 32,
                                          child: Image.asset(
                                              'assets/icons/book swap.png'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      'Tukar \nMilik',
                                      style: AppTextStyle.body4Medium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              //Fitur Donasi Buku
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 58,
                                          child: SvgPicture.asset(
                                              'assets/icons/background_fitur.svg'),
                                        ),
                                        SizedBox(
                                          width: 32,
                                          child: Image.asset(
                                              'assets/icons/donation book.png'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      'Donasi \nBuku',
                                      style: AppTextStyle.body4Medium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              //Fitur Bebas Baca
                              GestureDetector(
                                onTap: () => Get.to(
                                  () => AllBebasBacaView(),
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 58,
                                          child: SvgPicture.asset(
                                              'assets/icons/background_fitur.svg'),
                                        ),
                                        SizedBox(
                                          width: 32,
                                          child: Image.asset(
                                              'assets/icons/icon_bebas_baca.png'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      'Bebas \nBaca',
                                      style: AppTextStyle.body4Medium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Fitur Sekilas Info
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => AllArticlePage());
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 58,
                                          child: SvgPicture.asset(
                                              'assets/icons/background_fitur.svg'),
                                        ),
                                        SizedBox(
                                          width: 32,
                                          child: Image.asset(
                                              'assets/icons/sekilas ilmu.png'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      'Sekilas \nInfo',
                                      style: AppTextStyle.body4Medium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              //Fitur Massage
                              GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 58,
                                          child: SvgPicture.asset(
                                              'assets/icons/background_fitur.svg'),
                                        ),
                                        SizedBox(
                                          width: 32,
                                          child: Image.asset(
                                              'assets/icons/message.png'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      'Pesan',
                                      style: AppTextStyle.body4Medium,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              //Fitur Kosongan
                              const Column(
                                children: [
                                  SizedBox(
                                    width: 56,
                                    child: Text(''),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '\n',
                                    style: AppTextStyle.body4Medium,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              const Column(
                                children: [
                                  SizedBox(width: 56, child: Text('')),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '\n',
                                    style: AppTextStyle.body4Medium,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
