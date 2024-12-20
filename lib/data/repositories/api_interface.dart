import 'package:pmu_labs/domain/models/card.dart';

typedef OnErrorCallback = void Function(String? error);

abstract class ApiInterface {
  Future<List<CardData>?> loadData();
}
