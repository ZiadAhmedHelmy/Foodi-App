class BasketFoodModel{
  String? foodName;
  String? foodImage;
  int? foodCount;
  String? Calories;
  double?Price;

  BasketFoodModel({this.foodName, this.foodImage, this.foodCount, this.Price , this.Calories});

  Map<String, dynamic> toJson() {
    return {
      "Price":Price,
      "foodCount":foodCount,
      "foodName":foodName,
    };
  }

}