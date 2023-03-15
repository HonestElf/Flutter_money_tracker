import 'package:flutter/material.dart';

class CostsView extends StatefulWidget {
  const CostsView({super.key});

  @override
  State<CostsView> createState() => _CostsViewState();
}

class _CostsViewState extends State<CostsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Text('Нет статей расходов'),
    );
  }
}
