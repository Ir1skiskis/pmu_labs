import 'package:equatable/equatable.dart';
import 'package:pmu_labs/domain/models/card.dart';

class HomeState extends Equatable {
  final List<CardData>? data;
  final bool isLoading;
  final String? error;

  const HomeState({
    this.data,
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    List<CardData>? data,
    bool? isLoading,
    String? error,
  }) =>
      HomeState(
        data: data ?? this.data,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [
        data,
        isLoading,
        error,
      ];
}
