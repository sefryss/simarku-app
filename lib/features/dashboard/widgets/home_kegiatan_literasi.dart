import 'package:flutter/material.dart';

class LiteracyActivity extends StatelessWidget {
  const LiteracyActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 16,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (contaxt, index) {
          return LiteracyActifityCard();
        },
      ),
    );
  }
}

class LiteracyActifityCard extends StatelessWidget {
  const LiteracyActifityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 134,
      width: 328,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.hardEdge,
            child: Image.asset('assets/images/literacy_activity.png')),
      ),
    );
  }
}
