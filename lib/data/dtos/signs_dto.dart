import 'package:json_annotation/json_annotation.dart';

part 'signs_dto.g.dart';

@JsonSerializable(createToJson: false)
class SignsDto {
  final List<SignAttributesDataDto>? data;

  const SignsDto({this.data});

  factory SignsDto.fromJson(Map<String, dynamic> json) =>
      _$SignsDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class SignAttributesDataDto {
  final String? id;
  final String? title;
  final String? imageUrl;
  final String? description;

  const SignAttributesDataDto(
      {this.id, this.title, this.imageUrl, this.description});

  factory SignAttributesDataDto.fromJson(Map<String, dynamic> json) =>
      _$SignAttributesDataDtoFromJson(json);
}
