import 'package:pmu_labs/data/dtos/signs_dto.dart';
import 'package:pmu_labs/domain/models/card.dart';

extension SignDataDtoToModel on SignAttributesDataDto {
  CardData toDomain() => CardData(
    title ?? 'UNKNOWN',
    descriptionText: 'Узнать больше', //attributes?.description,
    signDesc: description,//attributes?.drop,
    imageUrl: imageUrl,
  );
}