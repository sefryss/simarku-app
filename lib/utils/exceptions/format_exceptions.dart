class SMFormatException implements Exception {
  final String message;

  const SMFormatException(
      [this.message =
          'Terjadi kealahan format yang tidak terduga. Mohon periksa input anda.']);

  factory SMFormatException.fromMessage(String message) {
    return SMFormatException(message);
  }

  String get formattedMessage => message;

  factory SMFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const SMFormatException(
            'Format alamat email tidak sesuai. Mohon masukkan email yang sesuai.');
      case 'invalid-password-format':
        return const SMFormatException(
            'Format password tidak sesuai. Mohon gunakan password yang sesuai.');
      case 'invalid-phone-number':
        return const SMFormatException(
            'Format nomor telepon tidak sesuai. Mohon masukkan nomor telepon yang sesuai.');
      case 'invalid-url-format':
        return const SMFormatException(
            'Format URL tidak sesuai. Mohon masukkan URL yang sesuai.');
      default:
        return const SMFormatException();
    }
  }
}
