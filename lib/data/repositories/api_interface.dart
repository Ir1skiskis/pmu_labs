import 'package:pmu_labs/domain/models/home_data.dart';

typedef OnErrorCallback = void Function(String? error);

abstract class ApiInterface {
  Future<HomeData?> loadData();
}
