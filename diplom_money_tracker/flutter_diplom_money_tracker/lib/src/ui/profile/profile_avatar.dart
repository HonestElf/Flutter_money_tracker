import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key, required this.currentUser});

  final User currentUser;

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  final storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  String? _imageUrl;

  @override
  void initState() {
    super.initState();

    _loadUserAvatar();
  }

  void picImageFromGallery() async {
    final chosenImage = await _picker.pickImage(source: ImageSource.gallery);

    final imgRef =
        storage.ref().child('avatars/${widget.currentUser.uid}_avatar');

    if (chosenImage != null) {
      imgRef.putFile(File(chosenImage.path));
      _loadUserAvatar();
    }
  }

  void _showError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(milliseconds: 2000),
          backgroundColor: Colors.red,
          content: Text(errorMessage)),
    );
  }

  void _loadUserAvatar() async {
    try {
      final imageUrl = await storage
          .ref('avatars/${widget.currentUser.uid}_avatar')
          .getDownloadURL();

      setState(() {
        _imageUrl = imageUrl;
      });
    } on FirebaseException catch (fireError) {
      setState(() {
        _imageUrl = null;
      });

      if (fireError.code == 'object-not-found') {
        _showError('Аватар не найден');
      }
    } catch (error) {
      setState(() {
        _imageUrl = null;
      });
      _showError('Ошибка загрузки изображения');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          picImageFromGallery();
        },
        child: CircleAvatar(
          radius: 40,
          backgroundImage: _imageUrl != null
              ? NetworkImage(_imageUrl!)
              : const AssetImage('assets/images/altAvatar.jpg')
                  as ImageProvider,
        ));
  }
}
