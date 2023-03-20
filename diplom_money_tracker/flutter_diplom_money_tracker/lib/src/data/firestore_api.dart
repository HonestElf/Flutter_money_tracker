import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_category.dart';

CollectionReference<CostCategory>? getAllCategories() {
  try {
    final categories = FirebaseFirestore.instance
        .collection('testUsercollection')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              CostCategory.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    return categories;
  } catch (error) {
    print('ERROR: ${error.toString()}');
  }
}

String addCategory(String name, String color) {
  try {
    final categories = FirebaseFirestore.instance
        .collection('testUsercollection')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              CostCategory.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    categories
        .doc(name)
        .set(CostCategory(categoryName: name, categoryColor: color, items: []));
    return 'Success';
  } catch (error) {
    throw error.toString();
  }
}

String addCost(String categoryName, num price, String date) {
  try {
    final document = FirebaseFirestore.instance
        .collection('testUsercollection')
        .doc('jiMjjEpUqv4nUQ783lmx')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              CostCategory.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    document.update({
      'costs': FieldValue.arrayUnion([
        {'date': date, 'price': price}
      ])
    });

    return 'Success';
  } catch (error) {
    throw error.toString();
  }
}
