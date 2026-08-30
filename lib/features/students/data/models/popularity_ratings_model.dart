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

  factory PopularityRatingsModel.fromMap(Map<String, Object?> map) {
    return PopularityRatingsModel(
      resenha: map['resenha'] as int? ?? 1,
      presencaVip: map['presenca_vip'] as int? ?? 1,
      aura: map['aura'] as int? ?? 1,
      modoParceiro: map['modo_parceiro'] as int? ?? 1,
      carismaNatural: map['carisma_natural'] as int? ?? 1,
      humorDeMilhoes: map['humor_de_milhoes'] as int? ?? 1,
      energiaDeGrupo: map['energia_de_grupo'] as int? ?? 1,
      criatividadeCaotica: map['criatividade_caotica'] as int? ?? 1,
      modoAtleta: map['modo_atleta'] as int? ?? 1,
      talentoDePalco: map['talento_de_palco'] as int? ?? 1,
      dripEscolar: map['drip_escolar'] as int? ?? 1,
      coracaoDeDorama: map['coracao_de_dorama'] as int? ?? 1,
      queridinhoDosProfessores: map['queridinho_dos_professores'] as int? ?? 1,
      cerebroTurbo: map['cerebro_turbo'] as int? ?? 1,
      caosControlado: map['caos_controlado'] as int? ?? 1,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'resenha': resenha,
      'presenca_vip': presencaVip,
      'aura': aura,
      'modo_parceiro': modoParceiro,
      'carisma_natural': carismaNatural,
      'humor_de_milhoes': humorDeMilhoes,
      'energia_de_grupo': energiaDeGrupo,
      'criatividade_caotica': criatividadeCaotica,
      'modo_atleta': modoAtleta,
      'talento_de_palco': talentoDePalco,
      'drip_escolar': dripEscolar,
      'coracao_de_dorama': coracaoDeDorama,
      'queridinho_dos_professores': queridinhoDosProfessores,
      'cerebro_Turbo': cerebroTurbo,
      'caos_controlado': caosControlado,
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
