import 'package:pmu_labs/domain/models/card.dart';

abstract class ApiInterface{
  Future<List<CardData>?> loadData();
}