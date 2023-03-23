class AuthRepository {
  Future<String> attemptAutoLogin() async {
    await Future.delayed(Duration(seconds: 1));

    throw Exception('not signed in');
  }

  Future<String> login(
      {required String username, required String password}) async {
    print('attempring logn');

    await Future.delayed(const Duration(seconds: 3));

    print('logged in');
    return 'SomeUserName';
    // throw Exception('bad connection');
  }

  Future<void> signUp(
      {required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 3));
    print('signed up');
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 2));
    print('signed out');
  }
}
