class ProductRatingCalculator {
  static ProductRatingCalculator? _instance;

  ProductRatingCalculator._();

  factory ProductRatingCalculator() =>
      _instance ??= ProductRatingCalculator._();

  double getProductRating(double rating) {
    if(rating > 5){
      return (rating / 100) * 5;
    }
    return rating;
  }
}
