import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmu_labs/data/repositories/sign_repository.dart';
import 'package:pmu_labs/presentation/home_page/bloc/events.dart';
import 'package:pmu_labs/presentation/home_page/bloc/state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SignsRepository repo;

  HomeBloc(this.repo) : super(const HomeState()) {
    on<HomeLoadDataEvent>(_onLoadData);
  }

  Future<void> _onLoadData(
      HomeLoadDataEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    String? error;

    final data = await repo.loadData(
      q: event.search,
      onError: (e) => error = e,
    );

    emit(state.copyWith(
      isLoading: false,
      data: data,
      error: error,
    ));
  }
}
