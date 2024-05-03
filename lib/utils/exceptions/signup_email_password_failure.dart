class signInWithEmailAndPasswordFailure {
  final String message;

  const signInWithEmailAndPasswordFailure(
      [this.message = 'An Unknown error occured.']);

  factory signInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-passsword':
        return const signInWithEmailAndPasswordFailure(
            'Please enter a stronger password.');
      case 'invalid-email':
        return const signInWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted');
      case 'email-already-in-use':
        return const signInWithEmailAndPasswordFailure(
            'An account already exists for that email.');
      case 'operation-not-allowed':
        return const signInWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support.');
      case 'user-disabled':
        return const signInWithEmailAndPasswordFailure(
            'This user has been disabled. Please contact support for help.');

      default:
        return const signInWithEmailAndPasswordFailure();
    }
  }
}
