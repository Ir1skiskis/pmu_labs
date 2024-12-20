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

SignsDataDto _$SignsDataDtoFromJson(Map<String, dynamic> json) => SignsDataDto(
      id: json['id'] as String?,
      type: json['type'] as String?,
      attributes: json['attributes'] == null
          ? null
          : SignAttributesDataDto.fromJson(
              json['attributes'] as Map<String, dynamic>),
    );

SignAttributesDataDto _$SignAttributesDataDtoFromJson(
        Map<String, dynamic> json) =>
    SignAttributesDataDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
    );
