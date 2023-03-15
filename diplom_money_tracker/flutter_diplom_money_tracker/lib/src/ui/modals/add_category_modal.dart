import 'package:flutter/material.dart';

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
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Добавить категорию',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                )),
            TextField(
              controller: _nameController,
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
            ),
            TextField(
              controller: _colorController,
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
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9053EB),
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Добавить', style: TextStyle(fontSize: 17))),
            ElevatedButton(
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
                },
                child: const Text('Отмена',
                    style: TextStyle(fontSize: 17, color: Colors.red))),
          ],
        ),
      ),
    );
  }
}
