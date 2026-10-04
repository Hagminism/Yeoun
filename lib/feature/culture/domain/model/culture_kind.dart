enum CultureKind {
  movie('영화'),
  drama('드라마'),
  book('책'),
  game('게임'),
  music('음악'),
  performance('공연'),
  other('기타');

  final String label;

  const CultureKind(this.label);
}
