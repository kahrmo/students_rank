class PopularityRatings {
  final int resenha;
  final int presencaVip;
  final int aura;
  final int modoParceiro;
  final int carismaNatural;
  final int humorDeMilhoes;
  final int energiaDeGrupo;
  final int criatividadeCaotica;
  final int modoAtleta;
  final int talentoDePalco;
  final int dripEscolar;
  final int coracaoDeDorama;
  final int queridinhoDosProfessores;
  final int cerebroTurbo;
  final int caosControlado;

  const PopularityRatings({
    this.resenha = 1,
    this.presencaVip = 1,
    this.aura = 1,
    this.modoParceiro = 1,
    this.carismaNatural = 1,
    this.humorDeMilhoes = 1,
    this.energiaDeGrupo = 1,
    this.criatividadeCaotica = 1,
    this.modoAtleta = 1,
    this.talentoDePalco = 1,
    this.dripEscolar = 1,
    this.coracaoDeDorama = 1,
    this.queridinhoDosProfessores = 1,
    this.cerebroTurbo = 1,
    this.caosControlado = 1,
  });

  static const Map<String, String> criteriaLabels = {
    'resenha': 'Resenha',
    'presencaVip': 'Presença VIP',
    'aura': 'Aura',
    'modoParceiro': 'Modo Parceiro',
    'carismaNatural': 'Carisma Natural',
    'humorDeMilhoes': 'Humor de Milhões',
    'energiaDeGrupo': 'Energia de Grupo',
    'criatividadeCaotica': 'Criatividade Caótica',
    'modoAtleta': 'Modo Atleta',
    'talentoDePalco': 'Talento de Palco',
    'dripEscolar': 'Drip Escolar',
    'coracaoDeDorama': 'Coração de Dorama',
    'queridinhoDosProfessores': 'Queridinho dos Professores',
    'cerebroTurbo': 'Cérebro Turbo',
    'caosControlado': 'Caos Controlado',
  };


  int get totalScore =>
      resenha +
      presencaVip +
      aura +
      modoParceiro +
      carismaNatural +
      humorDeMilhoes +
      energiaDeGrupo +
      criatividadeCaotica +
      modoAtleta +
      talentoDePalco +
      dripEscolar +
      coracaoDeDorama +
      queridinhoDosProfessores +
      cerebroTurbo +
      caosControlado;

  PopularityRatings copyWith({
    int? resenha,
    int? presencaVip,
    int? aura,
    int? modoParceiro,
    int? carismaNatural,
    int? humorDeMilhoes,
    int? energiaDeGrupo,
    int? criatividadeCaotica,
    int? modoAtleta,
    int? talentoDePalco,
    int? dripEscolar,
    int? coracaoDeDorama,
    int? queridinhoDosProfessores,
    int? cerebroTurbo,
    int? caosControlado,
  }) {
    return PopularityRatings(
      resenha: resenha ?? this.resenha,
      presencaVip: presencaVip ?? this.presencaVip,
      aura: aura ?? this.aura,
      modoParceiro: modoParceiro ?? this.modoParceiro,
      carismaNatural: carismaNatural ?? this.carismaNatural,
      humorDeMilhoes: humorDeMilhoes ?? this.humorDeMilhoes,
      energiaDeGrupo: energiaDeGrupo ?? this.energiaDeGrupo,
      criatividadeCaotica: criatividadeCaotica ?? this.criatividadeCaotica,
      modoAtleta: modoAtleta ?? this.modoAtleta,
      talentoDePalco: talentoDePalco ?? this.talentoDePalco,
      dripEscolar: dripEscolar ?? this.dripEscolar,
      coracaoDeDorama: coracaoDeDorama ?? this.coracaoDeDorama,
      queridinhoDosProfessores: queridinhoDosProfessores ?? this.queridinhoDosProfessores,
      cerebroTurbo: cerebroTurbo ?? this.cerebroTurbo,
      caosControlado: caosControlado ?? this.caosControlado,
    );
  }
}
