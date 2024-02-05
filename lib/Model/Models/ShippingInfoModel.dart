class ShippingInfoModel {
  String? title;
  String? address;
  String? phoneNumber;

  ShippingInfoModel(this.title, this.address, this.phoneNumber);


  ShippingInfoModel.fromJason(Map<String,dynamic>json){
     title = json["title"];
     address = json["address"];
     phoneNumber = json["phoneNumber"];
  }

}
