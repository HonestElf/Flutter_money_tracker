import 'package:bloc/bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/costs/costs_bloc,.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/costs/costs_events.dart';

enum ModalSate { opened, closed }

class CategoryAddCubit extends Cubit<ModalSate> {
  final CostsBloc costsBloc;

  CategoryAddCubit({required this.costsBloc}) : super(ModalSate.closed);

  void addNewCategory(String categoryName, String categoryColor) {
    costsBloc.add(AddNewCategory(
        categoryName: categoryName, categoryColor: categoryColor));
  }

  void closeModal() {
    costsBloc.add(CloseAddModal());
  }
}
