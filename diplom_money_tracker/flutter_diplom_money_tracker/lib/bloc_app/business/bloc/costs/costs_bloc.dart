import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/costs/costs_events.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/costs/costs_state.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/entities/cost_category.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/repositories/database_repository.dart';

class CostsBloc extends Bloc<CostsEvent, CostsState> {
  final DatabaseRepository dataRepo;

  late final StreamSubscription<List<CostCategory>> dataStream;
  CostsBloc({required this.dataRepo}) : super(CostsState()) {
    on<CostsEvent>(_onEvent);

    final categories = dataRepo.getAllCategories();

    dataStream = dataRepo.stream.listen((event) {
      print('EVENT: ${event}');
      add(LoadAllCategories(categories: event));
    });
  }

  Future<void> _onEvent(CostsEvent event, Emitter<CostsState> emit) async {
    if (event is LoadAllCategories) {
      emit(state.copyWith(costCategories: event.categories));
    } else if (event is ChangeDate) {
      emit(state.copyWith(
          chosenMonth: event.date.month, chosenYear: event.date.year));
    } else if (event is OpenAddModal) {
      emit(state.copyWith(addCategoryWindowIsVisible: true));
    } else if (event is CloseAddModal) {
      emit(state.copyWith(addCategoryWindowIsVisible: false));
    } else if (event is AddNewCategory) {
      try {
        await dataRepo.addNewCategory(event.categoryName, event.categoryColor);
        emit(state.copyWith(addCategoryWindowIsVisible: false, costCategories: [
          ...state.costCategories,
          CostCategory(
              categoryName: event.categoryName,
              categoryColor: event.categoryColor)
        ]));
      } catch (e) {
        rethrow;
      }
    }
    //else if (event is AddNewCost) {
    // } else if (event is DeleteCategory) {
    // } else if (event is DeleteCost) {}
  }

  @override
  Future<void> close() {
    dataStream.cancel();
    return super.close();
  }
}
