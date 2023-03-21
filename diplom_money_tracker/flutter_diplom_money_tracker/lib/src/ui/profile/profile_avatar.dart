import 'dart:io';

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

  XFile? _avatarFromGallery;
  String? _imageUrl;

  bool _imageNotLoaded = false;

  @override
  void initState() {
    super.initState();

    _loadUserAvatar();
  }

  void picImageFromGallery() async {
    final chosenImage = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _avatarFromGallery = chosenImage;
      _imageNotLoaded = true;
    });
  }

  void saveAvatarToFirebase() {
    final imgRef =
        storage.ref().child('avatars/${widget.currentUser.uid}_avatar');
    if (_avatarFromGallery != null) {
      imgRef.putFile(File(_avatarFromGallery!.path));

      setState(() {
        _imageNotLoaded = false;
      });
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
    ImageProvider backgroundImage;
    if (_avatarFromGallery != null) {
      backgroundImage = FileImage(File(_avatarFromGallery!.path));
    } else if (_imageUrl != null) {
      backgroundImage = NetworkImage(_imageUrl!);
    } else {
      backgroundImage = const AssetImage('assets/images/defaultAvatar.png');
    }
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              picImageFromGallery();
            },
            child: CircleAvatar(radius: 40, backgroundImage: backgroundImage)),
        _imageNotLoaded
            ? TextButton(
                onPressed: saveAvatarToFirebase, child: const Text('Сохранить'))
            : SizedBox()
      ],
    );
  }
}
