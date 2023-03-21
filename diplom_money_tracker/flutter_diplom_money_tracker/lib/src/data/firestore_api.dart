import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_diplom_money_tracker/src/business/auth/firebase_auth_service.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_category.dart';
import 'package:flutter_diplom_money_tracker/src/data/cost_item.dart';

CollectionReference<CostCategory>? getFirebaseCollection() {
  try {
    final userId = getUserData()?.uid;

    if (userId != null) {
      final collection =
          FirebaseFirestore.instance.collection(userId).withConverter(
                fromFirestore: (snapshot, options) =>
                    CostCategory.fromJson(snapshot.data()!),
                toFirestore: (value, options) => value.toJson(),
              );

      return collection;
    } else {
      throw 'Unauthorized user';
    }
  } catch (error) {
    print('ERROR: ${error.toString()}');
  }
}

void addCategory(String name, String color) {
  try {
    getFirebaseCollection()!
        .doc(name)
        .set(CostCategory(categoryName: name, categoryColor: color, items: []));
  } catch (error) {
    print('ADD CATEGORY ERROR: ${error.toString()}');
    // throw error.toString();
  }
}

void addCost(String categoryName, num price, String date) {
  try {
    final document = getFirebaseCollection()!.doc(categoryName).withConverter(
          fromFirestore: (snapshot, options) =>
              CostCategory.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    document.update({
      'costs': FieldValue.arrayUnion([
        {'date': date, 'price': price}
      ])
    });
  } catch (error) {
    print('ADD COST ERROR: ${error.toString()}');
    // throw error.toString();
  }
}

void deleteCost(String categoryName, CostItem item) {
  try {
    final document = getFirebaseCollection()!.doc(categoryName).withConverter(
          fromFirestore: (snapshot, options) =>
              CostItem.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    document.update({
      'costs': FieldValue.arrayRemove([
        {'date': item.costDay, 'price': item.costPrice}
      ])
    });
  } catch (error) {
    print('DELETE COST ERROR: ${error.toString()}');
    // throw error.toString();
  }
}

void deleteCategory(String categoryName) {
  try {
    getFirebaseCollection()!.doc(categoryName).delete();
  } catch (error) {
    print('DELETE CATEGORY ERROR: ${error.toString()}');
    // throw error.toString();
  }
}
