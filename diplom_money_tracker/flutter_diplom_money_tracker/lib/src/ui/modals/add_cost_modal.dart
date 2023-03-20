import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/data/firestore_api.dart';

class AddCostModal extends StatefulWidget {
  const AddCostModal({super.key});

  @override
  State<AddCostModal> createState() => _AddCostModalState();
}

class _AddCostModalState extends State<AddCostModal> {
  final TextEditingController _nameController = TextEditingController();

  String? currentDate;

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

  void openDateModal() async {
    final chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now());

    if (chosenDate != null) {
      setState(() {
        currentDate =
            '${chosenDate.day}/${chosenDate.month}/${chosenDate.year}';
      });
    }
  }

  void addCostToCategory() {
    if (_nameController.text != '') {
      try {
        addCost('asd', int.parse(_nameController.text), currentDate!);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              duration: Duration(milliseconds: 1000),
              backgroundColor: Colors.green,
              content: Text('Добавляем...')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              duration: const Duration(milliseconds: 1000),
              backgroundColor: Colors.red,
              content: Text(e.toString())),
        );
      }
    }
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
              TextButton(
                  onPressed: openDateModal,
                  child: Text(
                    currentDate ?? '--/--/--',
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _nameController,
            keyboardType: TextInputType.number,
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
                addCostToCategory();
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
