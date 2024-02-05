class FoodModel{

  String? foodImage;
  String? foodName;
  String? calories;
  int? price;
  String? foodRate;

  FoodModel(
      {this.foodImage,
      this.foodName,
      this.calories,
      this.price,
      this.foodRate});



  FoodModel.fromJason(Map<String,dynamic>json){
       foodName= json["foodName"];
       foodImage= json["foodImage"];
       calories= json["Calories"];
       price= json["Price"];
       foodRate= json["foodRate"];
  }
}