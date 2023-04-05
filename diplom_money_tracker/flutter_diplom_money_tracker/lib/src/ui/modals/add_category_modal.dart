// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';

class AddCategoryModal extends StatefulWidget {
  const AddCategoryModal({super.key});

  @override
  State<AddCategoryModal> createState() => _AddCategoryModalState();
}

class _AddCategoryModalState extends State<AddCategoryModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      content: BlocBuilder<AddCubit, ModalSate>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Добавить категорию',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    )),
                NameField(nameController: _nameController),
                ColorField(colorController: _colorController),
                const SizedBox(
                  height: 30,
                ),
                SubmitButton(
                    nameController: _nameController,
                    colorController: _colorController),
                const CancelButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NameField extends StatelessWidget {
  const NameField({super.key, required this.nameController});
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameController,
      decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF9053EB), width: 1),
          ),
          label: Text(
            'Название',
          ),
          floatingLabelStyle: TextStyle(
            color: Color(0xFF9053EB),
          )),
    );
  }
}

class ColorField extends StatelessWidget {
  const ColorField({super.key, required this.colorController});
  final TextEditingController colorController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: colorController,
      maxLength: 6,
      decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF9053EB), width: 1),
          ),
          label: Text(
            'Цвет',
          ),
          focusColor: Colors.green,
          floatingLabelStyle: TextStyle(
            color: Color(0xFF9053EB),
          )),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCubit, ModalSate>(
      builder: (context, state) {
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              minimumSize: Size(MediaQuery.of(context).size.width, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AddCubit>().closeCategoryModal();
            },
            child: const Text('Отмена',
                style: TextStyle(fontSize: 17, color: Colors.red)));
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {super.key, required this.nameController, required this.colorController});

  final TextEditingController nameController;
  final TextEditingController colorController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCubit, ModalSate>(
      builder: (context, state) {
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9053EB),
              minimumSize: Size(MediaQuery.of(context).size.width, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            onPressed: () {
              if (nameController.text != '' && colorController.text != '') {
                Navigator.of(context).pop();
                context
                    .read<AddCubit>()
                    .addNewCategory(nameController.text, colorController.text);
              }
            },
            child: const Text('Добавить', style: TextStyle(fontSize: 17)));
      },
    );
  }
}
