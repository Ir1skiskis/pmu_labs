import 'package:dio/dio.dart';
import 'package:pmu_labs/data/dtos/signs_dto.dart';
import 'package:pmu_labs/data/mappers/signs_mapper.dart';
import 'package:pmu_labs/domain/models/card.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:html/parser.dart' as html;
import 'api_interface.dart';
import 'dart:core';

const _imagePlaceholder =
    'https://i.pinimg.com/736x/c5/a3/c1/c5a3c132b54d48dbc17cb2cc2b4113a0.jpg';

Map<String, dynamic> transformJsonToSignsDtoFormat(
    Map<String, dynamic> pages, List<(String, String)> descs) {
  final transformedData = pages.values.map((sign) {
    final title = sign['title'] as String;
    final imageUrl =
        sign['original']?['source'] as String? ?? _imagePlaceholder;
    final description = descs.firstWhere((desc) => desc.$1 == title).$2;
    final id = sign['pageid'].toString();

    return {
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'id': id,
    };
  }).toList();

  return {
    'data': transformedData,
  };
}

void getBySearch(Map<String, dynamic> map, String? title) {
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
  Future<List<CardData>?> loadData(
      {OnErrorCallback? onError, String? q}) async {
    try {
      String url = '';
      if (q != null && q != "") {
        url =
            '$_baseUrl?action=query&format=json&titles=$q&prop=pageimages&piprop=original&format=json&origin=*';
      } else {
        url =
            '$_baseUrl?action=query&generator=categorymembers&gcmtitle=Category:Ведьмачьи_Знаки&gcmnamespace=0&gcmlimit=50&prop=pageimages&piprop=original&format=json&origin=*';
      }

      final List<CardData>? data;
      SignsDto dto;

      final Response<dynamic> response =
          await _dio.get<Map<dynamic, dynamic>>(url);
      final pages = response.data['query']['pages'] as Map<String, dynamic>;

      removeByTitle(pages, 'Ведьмачьи Знаки');

      List<(String, String)> descs = [];

      for (var sign in pages.values) {
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

      dto = SignsDto.fromJson(transData);
      if (q != null && q != "") {
        getBySearch(pages, q);
        final transData = transformJsonToSignsDtoFormat(pages, descs);
        dto = SignsDto.fromJson(transData);
      }

      data = dto.data?.map((e) => e.toDomain()).toList();
      return data;
    } on DioException catch (e) {
      onError?.call(e.error?.toString());
      return null;
    }
  }
}
