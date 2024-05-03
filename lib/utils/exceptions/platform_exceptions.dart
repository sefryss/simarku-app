class SMPlatformException implements Exception {
  final String code;

  SMPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Kredisensial login tidak sesuai. Mohon cek ulang informasi Anda';
      case 'INVALID_OPERATION':
        return 'Operasi tidak valid';
      case 'NETWORK_ERROR':
        return 'Terjadi kesalahan jaringan. Mohon periksa koneksi internet Anda';
      case 'PERMISSION_DENIED':
        return 'Izin ditolak';
      case 'SERVICE_UNAVAILABLE':
        return 'Layanan tidak tersedia. Mohon coba lagi nanti';
      case 'TIMEOUT':
        return 'Permintaan melebihi waktu maksimum. Mohon coba lagi';
      case 'UNKNOWN_ERROR':
        return 'Terjadi kesalahan yang tidak diketahui';
      case 'TOO_MANY_REQUESTS':
        return 'Terlalu banyak permintaan. Mohon coba lagi nanti';
      case 'INVALID_ARGUMENT':
        return 'Argumen tidak valid';
      case 'INVALID_PASSWORD':
        return 'Password tidak valid';
      case 'INVALID_PHONE_NUMBER':
        return 'Nomor telepon tidak valid';
      case 'OPERATION_NOT_ALLOWED':
        return 'Operasi tidak diizinkan';
      case 'SESSIONS_COOKIE_EXPIRED':
        return 'Cookie sesi telah kedaluwarsa';
      case 'UUID_ALREADY_EXISTS':
        return 'UUID sudah ada';
      case 'SIGN_IN_FAILED':
        return 'Gagal masuk';
      case 'NETWORK_REQUEST_FAILED':
        return 'Permintaan jaringan gagal. Mohon periksa koneksi internet Anda';
      case 'INTERNAL_ERROR':
        return 'Terjadi kesalahan internal';
      case 'INVALID_VERIFICATION_CODE':
        return 'Kode verifikasi tidak valid';
      default:
        return 'Terjadi kesalahan. Mohon coba lagi';
    }
  }
}
