enum BucketListCategory {
  all('전체'),
  travel('여행'),
  daily('일상'),
  hobby('취미'),
  culture('문화'),
  food('맛집');

  final String label;

  const BucketListCategory(this.label);
}
