import 'package:pmu_labs/data/dtos/signs_dto.dart';
import 'package:pmu_labs/domain/models/card.dart';

import '../../domain/models/home_data.dart';

extension SignDataDtoToModel on SignAttributesDataDto {
  CardData toDomain() => CardData(
        title ?? 'UNKNOWN',
        id: id ?? 'UNKNOWN',
        descriptionText: 'Узнать больше', //attributes?.description,
        signDesc: description, //attributes?.drop,
        imageUrl: imageUrl,
      );
}

extension SignDtoToModel on SignsDto {
  HomeData toDomain() => HomeData(
    data: data?.map((e) => e.toDomain()).toList(),
  );
}