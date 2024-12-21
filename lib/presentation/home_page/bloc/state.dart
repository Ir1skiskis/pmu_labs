import 'package:equatable/equatable.dart';

import '../../../domain/models/home_data.dart';

class HomeState extends Equatable {
  final HomeData? data;
  final bool isLoading;
  final String? error;

  const HomeState({
    this.data,
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    HomeData? data,
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
