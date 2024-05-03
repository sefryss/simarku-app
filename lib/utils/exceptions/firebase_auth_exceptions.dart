class SMFirebaseAuthException implements Exception {
  final String code;

  SMFirebaseAuthException(
    this.code,
  );

  String get message {
    switch (code) {
      case 'invalid-credential':
        return 'Kredensial tidak valid. Mohon periksa kembali';
      case 'invalid-email':
        return 'Format email tidak valid. Mohon periksa kembali email Anda';
      case 'user-not-found':
        return 'Pengguna tidak ditemukan. Mohon periksa kembali email Anda';
      case 'wrong-password':
        return 'Password salah. Mohon periksa kembali password Anda';
      case 'user-disabled':
        return 'Akun pengguna dinonaktifkan. Mohon hubungi administrator';
      case 'email-already-in-use':
        return 'Email sudah terdaftar. Tolong gunakan email lain';
      case 'operation-not-allowed':
        return 'Operasi tidak diizinkan. Mohon hubungi administrator';
      case 'weak-password':
        return 'Password terlalu lemah. Gunakan password yang lebih kuat';
      case 'requires-recent-login':
        return 'Operasi ini memerlukan autentikasi ulang. Mohon login kembali';
      case 'provider-already-linked':
        return 'Provider sudah terhubung ke akun ini';
      case 'credential-already-in-use':
        return 'Kredensial sudah digunakan oleh pengguna lain';
      case 'account-exists-with-different-credential':
        return 'Akun sudah terdaftar dengan credential yang berbeda';
      case 'network-request-failed':
        return 'Permintaan jaringan gagal. Mohon periksa koneksi internet Anda';
      case 'user-mismatch':
        return 'User tidak cocok dengan kredensial yang disediakan';
      case 'invalid-verification-code':
        return 'Kode verifikasi tidak valid';
      case 'invalid-verification-id':
        return 'ID verifikasi tidak valid';
      case 'invalid-phone-number':
        return 'Nomor telepon tidak valid';
      case 'missing-verification-code':
        return 'Kode verifikasi hilang';
      case 'missing-verification-id':
        return 'ID verifikasi hilang';
      case 'quota-exceeded':
        return 'Quota request telah tercapai';
      case 'app-deleted':
        return 'Aplikasi telah dihapus';
      case 'app-not-authorized':
        return 'Aplikasi tidak diotorisasi untuk menggunakan Firebase Authentication';
      default:
        return 'Terjadi kesalahan. Mohon coba lagi';
    }
  }
}
