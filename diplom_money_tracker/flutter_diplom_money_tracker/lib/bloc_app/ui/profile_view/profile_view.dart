import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const routeName = 'profileView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Профиль'),
      ),
      body: _userProfile(),
    ));
  }

  Widget _userProfile() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userAvatar(),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(
                'email',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 15,
              ),
              _logoutButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget _logoutButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9053EB),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            minimumSize: const Size(150, 50)),
        onPressed: () {},
        child: const Text(
          'Выйти',
          style: TextStyle(fontSize: 17),
        ));
  }

  Widget _userAvatar() {
    return CircleAvatar(
      radius: 40,
      child: Icon(Icons.person),
    );
  }
}
