// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:module_business/module_business.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

// Project imports:

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const routeName = 'profileView';

  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    return SafeArea(
        child: BlocProvider(
      create: (context) => ProfileBloc(
          user: sessionCubit.currentUser,
          storageRepo: context.read<StorageRepository>()),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.imageSourceActionSheetIsVisible) {
            _showImageSourceActionSheet(context);
          }
        },
        child: Scaffold(
          appBar: _appBar(),
          body: _userProfile(),
        ),
      ),
    ));
  }

  PreferredSize _appBar() {
    final appBarheight = AppBar().preferredSize.height;

    return PreferredSize(
      preferredSize: Size.fromHeight(appBarheight),
      child: AppBar(centerTitle: true, title: const Text('Профиль')),
    );
  }

  Widget _userProfile() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
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
                    state.email,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _logoutButton(context),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _logoutButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9053EB),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            minimumSize: const Size(150, 50)),
        onPressed: () {
          context.read<SessionCubit>().signOut();
        },
        child: const Text(
          'Выйти',
          style: TextStyle(fontSize: 17),
        ));
  }

  Widget _userAvatar() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                context.read<ProfileBloc>().add(ChangeAvatarRequest());
              },
              child: CircleAvatar(
                radius: 40,
                backgroundImage: state.localAvatarPath != null
                    ? FileImage(File(state.localAvatarPath!))
                    : state.avatarPath != null
                        ? NetworkImage(state.avatarPath!) as ImageProvider
                        : const AssetImage('assets/images/defaultAvatar.png'),
              ),
            ),
            if (state.formStatus is FormSubmitting) _changeAvatarButton()
          ],
        );
      },
    );
  }

  Widget _changeAvatarButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) => TextButton(
            onPressed: () {
              context.read<ProfileBloc>().add(SaveUserAvatar());
            },
            child: const Text('Сохранить')));
  }

  void _showImageSourceActionSheet(BuildContext context) {
    void selectImageSource(ImageSource imageSource) {
      context
          .read<ProfileBloc>()
          .add(OpenImagePicker(imageSource: imageSource));
    }

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => Wrap(children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Камера'),
          onTap: () {
            Navigator.pop(context);
            selectImageSource(ImageSource.camera);
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo),
          title: const Text('Галерея'),
          onTap: () {
            Navigator.pop(context);
            selectImageSource(ImageSource.gallery);
          },
        )
      ]),
    );
  }
}
