import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  late XFile? _avatarImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    try {
      _avatarImage = XFile('assets/images/altAvatar.jpg');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            duration: Duration(milliseconds: 1000),
            backgroundColor: Colors.red,
            content: Text('Ошибка загрузки изображения')),
      );
    }
  }

  void picImageFromGallery() async {
    final chosenImage = await _picker.pickImage(source: ImageSource.gallery);

    if (chosenImage != null) {
      setState(() {
        _avatarImage = chosenImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // picImageFromGallery();
      },
      child: CircleAvatar(
          radius: 40,
          backgroundImage: const AssetImage('assets/images/defaultAvatar.png')

          // backgroundImage:_avatarImage != null
          //     ? FileImage(File('assets/images/altAvatar.jpg'))
          //     : const AssetImage('assets/images/defaultAvatar.png')
          // as ImageProvider),
          ),
    );
  }
}
