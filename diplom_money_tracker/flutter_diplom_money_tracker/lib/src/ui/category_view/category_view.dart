import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_category.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_item.dart';
import 'package:flutter_diplom_money_tracker/src/ui/category_view/cost_card.dart';

final List<CostItem> items = [
  CostItem(costPrice: 30, costDay: '30/12/2012'),
  CostItem(costPrice: 23.4, costDay: '30/10/2000')
];

class CategoryView extends StatefulWidget {
  static const routeName = 'currentCategory';
  const CategoryView({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late DocumentReference<CostCategory> _document;

  @override
  void initState() {
    super.initState();

    _document = FirebaseFirestore.instance
        .collection('testUsercollection')
        .doc('jiMjjEpUqv4nUQ783lmx')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              CostCategory.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.categoryName),
            backgroundColor: const Color(0xFF9053EB),
          ),
          body: StreamBuilder<DocumentSnapshot<CostCategory>>(
              stream: _document.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                if (snapshot.hasData) {
                  var output = snapshot.data!.data();
                  var itemsList = output!.items;
                  return ListView.separated(
                    itemCount: itemsList.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 25,
                    ),
                    itemBuilder: (context, index) =>
                        CostCard(item: itemsList[index]),
                    padding: const EdgeInsets.all(25),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              })),
    );
  }
}
