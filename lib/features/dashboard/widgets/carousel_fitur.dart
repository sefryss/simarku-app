import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simarku/utils/global/app_config.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselFitur extends StatelessWidget {
  final CarouselFiturInfo carouselFiturInfo;

  const CarouselFitur({
    Key? key,
    required this.carouselFiturInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white, // Ganti warna container sesuai kebutuhan
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carouselFiturInfo.title,
                  style: AppTextStyle.heading5SemiBold,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    carouselFiturInfo.description,
                    style: AppTextStyle.body3Regular
                        .copyWith(color: AppColors.neutral06),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            Expanded(
              child: SvgPicture.asset(
                carouselFiturInfo.image,
                width: 120,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CarouselFiturInfo {
  final String title;
  final String description;
  final String image;

  CarouselFiturInfo({
    required this.title,
    required this.description,
    required this.image,
  });
}

class CarouselFiturItems {
  static List<CarouselFiturInfo> items = [
    CarouselFiturInfo(
      title: 'Tukar Pinjam',
      description:
          'Bosan dengan koleksi buku yang kamu punya? \nIngin membaca buku yang lain? \nAyo, coba Tukar Pinjam!',
      image: 'assets/icons/carousel_tukar_pinjam.svg',
    ),
    CarouselFiturInfo(
      title: 'Tukar Milik',
      description:
          'Tidak puas dengan buku bacaan yang kamu punya. \nMungkin dengan menukarnya bisa menjadi solusi. \Mulai Tukar Buku dengan bookmates lainnya!',
      image: 'assets/icons/carousel_book_swap.svg',
    ),
    CarouselFiturInfo(
      title: 'Donasi Buku',
      description:
          'Donasi tidak selalu berbentuk uang. Kamu dapat  \nberkontribusi lewat buku juga lho, \njadi tunggu apa lagi? Donasikan bukumu disini.',
      image: 'assets/icons/carousel_donation.svg',
    ),
  ];
}

class CarouselSliderWithIndicator extends StatefulWidget {
  @override
  _CarouselSliderWithIndicatorState createState() =>
      _CarouselSliderWithIndicatorState();
}

class _CarouselSliderWithIndicatorState
    extends State<CarouselSliderWithIndicator> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 150),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: CarouselFiturItems.items.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return CarouselFitur(
                  carouselFiturInfo: CarouselFiturItems.items[index]);
            },
            options: CarouselOptions(
              enlargeCenterPage: false,
              enableInfiniteScroll: true,
              height: 150,
              aspectRatio: 16 / 9,
              autoPlay: true,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
              pauseAutoPlayOnTouch: true,
              onPageChanged: (index, _) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              CarouselFiturItems.items.length,
              (index) => _Indicator(index: index, selectedIndex: _currentPage),
            ),
          ),
        ],
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final int index;
  final int selectedIndex;

  const _Indicator({
    Key? key,
    required this.index,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == selectedIndex ? AppColors.primary : Colors.grey,
      ),
    );
  }
}
