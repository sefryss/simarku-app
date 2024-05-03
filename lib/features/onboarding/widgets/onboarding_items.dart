class OnboardingInfo {
  final String title;
  final String description;
  final String image;

  OnboardingInfo({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboaringItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      title: "Membaca Kapanpun, Dimanapun",
      description:
          "SiMarKu hadir untuk mendukung gerakan literasi generasi Z. Temukan akses mudah ke informasi buku dan kegiatan literasi.",
      image: "assets/images/onboarding_1.svg",
    ),
    OnboardingInfo(
      title: "Dunia Literasi di Ujung Jari",
      description:
          "Temukan berbagai informasi tentang buku favoritmu, ikuti kegiatan literasi menarik, Semangat literasi ada di genggamanmu!",
      image: "assets/images/onboarding_2.svg",
    ),
    OnboardingInfo(
      title: "Berbagi Kebahagiaan dengan Membaca",
      description:
          "Tukar pinjam, tukar milik, dan donasi buku untuk menyebarkan kecintaan membaca dan membantu sesama.",
      image: "assets/images/onboarding_3.svg",
    ),
  ];
}
