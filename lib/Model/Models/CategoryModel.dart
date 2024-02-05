class CategoryModel {

  String? categoryName;
  String? categoryDescription;
  String? categoryImage;

  CategoryModel({this.categoryName, this.categoryDescription, this.categoryImage});



  CategoryModel.fromJason(Map<String,dynamic>json){
    categoryName= json["categoryName"];
    categoryDescription= json["categoryDescription"];
    categoryImage= json["categoryImage"];
  }
}