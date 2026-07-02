import '../../domain/entities/popularity_ratings.dart';

class PopularityRatingsModel extends PopularityRatings {
  const PopularityRatingsModel({
    super.resenha = 1,
    super.presencaVip = 1,
    super.aura = 1,
    super.modoParceiro = 1,
    super.carismaNatural = 1,
    super.humorDeMilhoes = 1,
    super.energiaDeGrupo = 1,
    super.criatividadeCaotica = 1,
    super.modoAtleta = 1,
    super.talentoDePalco = 1,
    super.dripEscolar = 1,
    super.coracaoDeDorama = 1,
    super.queridinhoDosProfessores = 1,
    super.cerebroTurbo = 1,
    super.caosControlado = 1,
  });

  factory PopularityRatingsModel.fromJson(Map<String, dynamic> json) {
    return PopularityRatingsModel(
      resenha: json['resenha'] as int? ?? 1,
      presencaVip: json['presencaVip'] as int? ?? 1,
      aura: json['aura'] as int? ?? 1,
      modoParceiro: json['modoParceiro'] as int? ?? 1,
      carismaNatural: json['carismaNatural'] as int? ?? 1,
      humorDeMilhoes: json['humorDeMilhoes'] as int? ?? 1,
      energiaDeGrupo: json['energiaDeGrupo'] as int? ?? 1,
      criatividadeCaotica: json['criatividadeCaotica'] as int? ?? 1,
      modoAtleta: json['modoAtleta'] as int? ?? 1,
      talentoDePalco: json['talentoDePalco'] as int? ?? 1,
      dripEscolar: json['dripEscolar'] as int? ?? 1,
      coracaoDeDorama: json['coracaoDeDorama'] as int? ?? 1,
      queridinhoDosProfessores: json['queridinhoDosProfessores'] as int? ?? 1,
      cerebroTurbo: json['cerebroTurbo'] as int? ?? 1,
      caosControlado: json['caosControlado'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resenha': resenha,
      'presencaVip': presencaVip,
      'aura': aura,
      'modoParceiro': modoParceiro,
      'carismaNatural': carismaNatural,
      'humorDeMilhoes': humorDeMilhoes,
      'energiaDeGrupo': energiaDeGrupo,
      'criatividadeCaotica': criatividadeCaotica,
      'modoAtleta': modoAtleta,
      'talentoDePalco': talentoDePalco,
      'dripEscolar': dripEscolar,
      'coracaoDeDorama': coracaoDeDorama,
      'queridinhoDosProfessores': queridinhoDosProfessores,
      'cerebroTurbo': cerebroTurbo,
      'caosControlado': caosControlado,
    };
  }

  factory PopularityRatingsModel.fromEntity(PopularityRatings entity) {
    return PopularityRatingsModel(
      resenha: entity.resenha,
      presencaVip: entity.presencaVip,
      aura: entity.aura,
      modoParceiro: entity.modoParceiro,
      carismaNatural: entity.carismaNatural,
      humorDeMilhoes: entity.humorDeMilhoes,
      energiaDeGrupo: entity.energiaDeGrupo,
      criatividadeCaotica: entity.criatividadeCaotica,
      modoAtleta: entity.modoAtleta,
      talentoDePalco: entity.talentoDePalco,
      dripEscolar: entity.dripEscolar,
      coracaoDeDorama: entity.coracaoDeDorama,
      queridinhoDosProfessores: entity.queridinhoDosProfessores,
      cerebroTurbo: entity.cerebroTurbo,
      caosControlado: entity.caosControlado,
    );
  }
}
