// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signs_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignsDto _$SignsDtoFromJson(Map<String, dynamic> json) => SignsDto(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => SignAttributesDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SignAttributesDataDto _$SignAttributesDataDtoFromJson(
        Map<String, dynamic> json) =>
    SignAttributesDataDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
    );
