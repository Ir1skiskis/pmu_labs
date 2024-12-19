import 'package:dio/dio.dart';
import 'package:pmu_labs/data/dtos/signs_dto.dart';
import 'package:pmu_labs/data/mappers/signs_mapper.dart';
import 'package:pmu_labs/domain/models/card.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:html/parser.dart' as html;
import 'api_interface.dart';
import 'dart:core';

const _imagePlaceholder = 'https://trikky.ru/wp-content/blogs.dir/1/files/2020/03/24/iz-bisera.jpg';

// Преобразует JSON в формат SignsDto
Map<String, dynamic> transformJsonToSignsDtoFormat(
    Map<String, dynamic> pages, List<(String, String)> descs) {
  final transformedData = pages.values.map((sign) {
    final title = sign['title'] as String;
    final imageUrl = sign['original']?['source'] as String? ?? _imagePlaceholder;
    final description = descs.firstWhere((desc) => desc.$1 == title).$2;

    return {
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
    };
  }).toList();

  // Формируем структуру, которая будет соответствовать SignsDto
  return {
    'data': transformedData,
  };
}

void getBySearch(Map<String, dynamic> map, String? title){
  map.removeWhere((key, value) {
    return value is Map<String, dynamic> && value['title'] != title;
  });
}

void removeByTitle(Map<String, dynamic> map, String title) {
  map.removeWhere((key, value) {
    return value is Map<String, dynamic> && value['title'] == title;
  });
}

class SignsRepository extends ApiInterface {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ));

  static const String _baseUrl = 'https://vedmak.fandom.com/api.php';

  @override
  Future<List<CardData>?> loadData({String? q}) async {
    try {
      String url = '';
      if (q != null && q != "") {
        url =
            '$_baseUrl?action=query&format=json&titles=$q&prop=pageimages&piprop=original&format=json&origin=*';
      } else {
        url =
            '$_baseUrl?action=query&generator=categorymembers&gcmtitle=Category:Ведьмачьи_Знаки&gcmnamespace=0&gcmlimit=50&prop=pageimages&piprop=original&format=json&origin=*';
      }

      final Response<dynamic> response =
          await _dio.get<Map<dynamic, dynamic>>(url);
      final pages = response.data['query']['pages'] as Map<String, dynamic>;

      removeByTitle(pages, 'Ведьмачьи Знаки');

      List<(String, String)> descs = [];

      for (var sign in pages.values.take(10)) {
        final Response<dynamic> respDesc = await _dio.get<
                Map<dynamic, dynamic>>(
            'https://vedmak.fandom.com/api.php?action=parse&page=${sign['title']}&prop=text&section=1&format=json');
        final htmlContent = respDesc.data['parse']['text']['*'];
        var doc = html.parse(htmlContent);

        String text = doc.body?.text ?? '';
        text = text.replaceAll(RegExp(r'\[.*?\]'), '');
        text = text.replaceAll('↑', '');
        text = text.trim();
        descs.add((sign['title'], text));
      }

      final transData = transformJsonToSignsDtoFormat(pages, descs);

      if (q != null && q != "") {
        getBySearch(pages, q);
        final transData = transformJsonToSignsDtoFormat(pages, descs);
        final SignsDto dto = SignsDto.fromJson(transData);
        final List<CardData>? data =
            dto.data?.map((e) => e.toDomain()).toList();
        return data;
      }

      final SignsDto dto = SignsDto.fromJson(transData);
      final List<CardData>? data = dto.data?.map((e) => e.toDomain()).toList();
      return data;
    } on DioException catch (e) {
      return null;
    }
  }
}
