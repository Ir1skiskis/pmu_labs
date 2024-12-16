import 'package:json_annotation/json_annotation.dart';

part 'signs_dto.g.dart';

@JsonSerializable(createToJson: false)
class SignsDto{
  final List<SignAttributesDataDto>? data;

  const SignsDto({this.data});

  factory SignsDto.fromJson(Map<String, dynamic> json) => _$SignsDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class SignsDataDto{
  final String? id;
  final String? type;
  final SignAttributesDataDto? attributes;

  const SignsDataDto({this.id, this.type, this.attributes});

  factory SignsDataDto.fromJson(Map<String, dynamic> json) => _$SignsDataDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class SignAttributesDataDto{
  final String? title;
  final String? imageUrl;
  final String? description;

  const SignAttributesDataDto({this.title, this.imageUrl, this.description});

  factory SignAttributesDataDto.fromJson(Map<String, dynamic> json) => _$SignAttributesDataDtoFromJson(json);
}