class BannerModel{

  String? foodName;
  String? foodPrice;
  String? urlImage;

  BannerModel({this.urlImage, this.foodName, this.foodPrice});


  BannerModel.fromJason(Map<String,dynamic>json){
    foodName= json["foodName"];
    foodPrice= json["FoodPrice"];
    urlImage= json["FoodImage"];
  }

}