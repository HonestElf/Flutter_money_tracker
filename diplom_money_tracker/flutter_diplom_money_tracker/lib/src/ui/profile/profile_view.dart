import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/business/auth/firebase_auth_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    // return Column(children: [
    //   CircleAvatar(radius: 40),
    //   IconButton(onPressed: firebaseLogout, icon: Icon(Icons.logout))
    // ]);
    return const Padding(
      padding: EdgeInsets.all(25),
      child: ListTile(
        title: Text('user email'),
        subtitle:
            ElevatedButton(onPressed: firebaseLogout, child: Text('Выйти')),
        leading: CircleAvatar(
          radius: 40,
        ),
      ),
    );
  }
}
