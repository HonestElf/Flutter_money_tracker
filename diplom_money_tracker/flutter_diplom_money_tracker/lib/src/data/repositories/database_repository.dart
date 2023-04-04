// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/data/entities/cost_category.dart';
import 'package:flutter_diplom_money_tracker/src/data/entities/cost_item.dart';

class DatabaseRepository {
  late CollectionReference<CostCategory> _collection;
  final String userId;

  Stream<List<CostCategory>> _getStream() {
    return _collection.snapshots().map((event) => event.docs
        .map((doc) => CostCategory(
            categoryName: doc.data().categoryName,
            categoryColor: doc.data().categoryColor,
            items: doc.data().items))
        .toList());
  }

  Stream<List<CostCategory>> get data => _getStream();

  late final Stream<List<CostCategory>> stream =
      _getStream().asBroadcastStream();

  DatabaseRepository({required this.userId}) {
    _collection = FirebaseFirestore.instance.collection(userId).withConverter(
          fromFirestore: (snapshot, options) =>
              CostCategory.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  List<CostCategory> getAllCategories() {
    final List<CostCategory> categoriesList = [];
    _collection.snapshots().map((event) {
      for (var element in event.docs) {
        categoriesList.add(element.data());
      }
    });

    return categoriesList;
  }

  Future<void> addNewCategory(String name, String color) async {
    try {
      await _collection.doc(name).set(
          CostCategory(categoryName: name, categoryColor: color, items: []));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addNewCost(String categoryName, num price, String date) async {
    try {
      final document = _collection.doc(categoryName).withConverter(
            fromFirestore: (snapshot, options) =>
                CostCategory.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );
      await document.update({
        'costs': FieldValue.arrayUnion([
          {'date': date, 'price': price}
        ])
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCategory(String categoryName) async {
    try {
      await _collection.doc(categoryName).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCost(String categoryName, CostItem item) async {
    try {
      final document = _collection.doc(categoryName).withConverter(
            fromFirestore: (snapshot, options) =>
                CostItem.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson(),
          );

      await document.update({
        'costs': FieldValue.arrayRemove([
          {'date': item.costDay, 'price': item.costPrice}
        ])
      });
    } catch (e) {
      rethrow;
    }
  }
}
