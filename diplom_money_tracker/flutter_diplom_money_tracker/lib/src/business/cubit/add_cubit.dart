// Package imports:
import 'package:bloc/bloc.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/business/bloc/costs/costs_bloc.dart';
import 'package:flutter_diplom_money_tracker/src/business/bloc/costs/costs_events.dart';

enum ModalSate { opened, closed }

class AddCubit extends Cubit<ModalSate> {
  final CostsBloc costsBloc;

  AddCubit({required this.costsBloc}) : super(ModalSate.closed);

  void addNewCategory(String categoryName, String categoryColor) {
    costsBloc.add(AddNewCategory(
        categoryName: categoryName, categoryColor: categoryColor));
  }

  void addNewCost(String categoryName, num price, String date) {
    costsBloc
        .add(AddNewCost(categoryName: categoryName, date: date, price: price));
  }

  void closeCategoryModal() {
    costsBloc.add(CloseAddCategoryModal());
  }

  void closeCostModal() {
    costsBloc.add((CloseAddCostModal()));
  }
}
