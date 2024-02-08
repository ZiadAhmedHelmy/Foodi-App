class OrderModel{

  double? orderPrice;
  String? address;
  List<dynamic>?orderDescription;
  String?orderDate;
  String?uid;



  OrderModel.fromJason(Map<String,dynamic>json){
    orderPrice = json["Price"];
    orderDescription = json["foodDiscription"];
    address = json["address"];
    orderDate = json["OrderDate"];
    uid = json["uid"];
  }

   Map<String, dynamic> toJson() => {
    "Price": orderPrice,
    "foodDiscription": orderDescription ?? [], // Ensure it's not null
    "address": address,
     "OrderDate":orderDate,
    "uid": uid,
  };



}