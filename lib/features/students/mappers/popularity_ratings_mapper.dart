import '../data/models/popularity_ratings_model.dart';
import '../domain/entities/popularity_ratings.dart';

class PopularityRatingsMapper {
  static PopularityRatingsModel toModel(PopularityRatings entity) {
    return PopularityRatingsModel.fromEntity(entity);
  }

  static PopularityRatings toEntity(PopularityRatingsModel model) {
    return PopularityRatings(
      resenha: model.resenha,
      presencaVip: model.presencaVip,
      aura: model.aura,
      modoParceiro: model.modoParceiro,
      carismaNatural: model.carismaNatural,
      humorDeMilhoes: model.humorDeMilhoes,
      energiaDeGrupo: model.energiaDeGrupo,
      criatividadeCaotica: model.criatividadeCaotica,
      modoAtleta: model.modoAtleta,
      talentoDePalco: model.talentoDePalco,
      dripEscolar: model.dripEscolar,
      coracaoDeDorama: model.coracaoDeDorama,
      queridinhoDosProfessores: model.queridinhoDosProfessores,
      cerebroTurbo: model.cerebroTurbo,
      caosControlado: model.caosControlado,
    );
  }
}
