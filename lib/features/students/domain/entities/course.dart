enum Course {
  info,
  mec,
  mamb,
  prod,
  tads,
  tga;

  String get displayName {
    switch (this) {
      case Course.info:
        return 'INFO';
      case Course.mec:
        return 'MEC';
      case Course.mamb:
        return 'MAMB';
      case Course.prod:
        return 'PROD';
      case Course.tads:
        return 'TADS';
      case Course.tga:
        return 'TGA';
    }
  }
}
