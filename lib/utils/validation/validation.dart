class SMValidator {
//Empty Text Validation
  static String? validateEmptyField(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName wajib diisi';
    }
    return null;
  }

// Validasi Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email wajib diisi';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Alamat email tidak valid';
    }
    return null;
  }

// Validasi Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kata sandi wajib diisi';
    }

    //Panjang password minimal 8 karakter
    if (value.length < 8) {
      return 'Kata sandi minimal 8 karakter';
    }

    //Check harus ada minimal 1 Huruf Besar
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Kata sandi minimal terdapat 1 huruf besar';
    }

    //Harus mengandung minimal 1 angka
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Kata sandi minimal terdapat 1 angka';
    }

    //Harus mengandunng karakter spesial
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Kata sandi minimal terdapat 1 simbol';
    }

    return null;
  }

// Validasi Konfirmasi Kata Sandi
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi kata sandi wajib diisi';
    }

    // Cek apakah konfirmasi kata sandi sama dengan kata sandi pertama
    if (value != password) {
      return 'Konfirmasi kata sandi tidak cocok';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor Telepon wajib diisi';
    }

    // Validasi untuk nomor Indonesia (minimal 10 digit, maksimal 15 digit)
    final phoneRegExp = RegExp(r'^\d{10,15}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Nomor telepon tidak valid (10-15 digit)';
    }

    return null;
  }
}
