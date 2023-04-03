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

    dataStream = dataRepo.stream.listen((event) {
      add(LoadAllCategories(categories: event));
    });

    add(ChangeDate(date: DateTime.now()));
  }

  Future<void> _onEvent(CostsEvent event, Emitter<CostsState> emit) async {
    if (event is LoadAllCategories) {
      emit(state.copyWith(costCategories: event.categories));
    } else if (event is ChangeDate) {
      emit(state.copyWith(
          chosenMonth: event.date.month, chosenYear: event.date.year));
    } else if (event is OpenAddCategoryModal) {
      emit(state.copyWith(addCategoryWindowIsVisible: true));
    } else if (event is CloseAddCategoryModal) {
      emit(state.copyWith(addCategoryWindowIsVisible: false));
    } else if (event is OpenAddCostModal) {
      emit(state.copyWith(addCostWindowIsVisible: true));
    } else if (event is CloseAddCostModal) {
      emit(state.copyWith(addCostWindowIsVisible: false));
    } else if (event is SetCurrentEditingCategory) {
      emit(state.copyWith(currentEditingCategory: event.categoryName));
    } else if (event is AddNewCategory) {
      try {
        emit(state.copyWith(addCategoryWindowIsVisible: false));
        await dataRepo.addNewCategory(event.categoryName, event.categoryColor);
      } catch (e) {
        rethrow;
      }
    } else if (event is AddNewCost) {
      emit(state.copyWith(addCostWindowIsVisible: false));
      await dataRepo.addNewCost(event.categoryName, event.price, event.date);
    } else if (event is DeleteCategory) {
      try {
        await dataRepo.deleteCategory(event.categoryName);
      } catch (e) {
        rethrow;
      }
    } else if (event is DeleteCost) {
      await dataRepo.deleteCost(event.categoryName, event.item);
    }
  }

  @override
  Future<void> close() {
    print('CLOSED');
    dataStream.cancel();
    return super.close();
  }
}
