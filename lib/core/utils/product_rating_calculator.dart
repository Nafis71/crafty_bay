class ProductRatingCalculator {
  static ProductRatingCalculator? _instance;

  ProductRatingCalculator._();

  factory ProductRatingCalculator() =>
      _instance ??= ProductRatingCalculator._();

  double getProductRating(double rating) {
    return (rating / 100) * 5;
  }
}
