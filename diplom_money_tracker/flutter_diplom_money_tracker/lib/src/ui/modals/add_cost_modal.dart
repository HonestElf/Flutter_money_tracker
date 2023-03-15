import 'package:flutter/material.dart';

class AddCostModal extends StatefulWidget {
  const AddCostModal({super.key});

  @override
  State<AddCostModal> createState() => _AddCostModalState();
}

class _AddCostModalState extends State<AddCostModal> {
  final TextEditingController _nameController = TextEditingController();

  late String? currentDate;

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();

    currentDate = '${now.day}/${now.month}/${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Добавить расход',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  )),
              Text(
                currentDate ?? '--/--/--',
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF9053EB), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                label: Text('Введите сумму'),
                floatingLabelStyle: TextStyle(color: Color(0xFF9053EB))),
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
              child: const Text('Отменить',
                  style: TextStyle(fontSize: 17, color: Colors.red))),
        ],
      ),
    );
  }
}
