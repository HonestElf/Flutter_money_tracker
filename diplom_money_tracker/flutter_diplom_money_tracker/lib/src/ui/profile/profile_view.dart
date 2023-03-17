import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/business/auth/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_diplom_money_tracker/src/ui/profile/profile_avatar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();

    _currentUser = getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9053EB),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileAvatar(),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text(
                  _currentUser != null
                      ? _currentUser!.email!
                      : 'user not found',
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9053EB),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        minimumSize: const Size(150, 50)),
                    onPressed: firebaseLogout,
                    child: const Text(
                      'Выйти',
                      style: TextStyle(fontSize: 17),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
