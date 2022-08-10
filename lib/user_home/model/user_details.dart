

class Details {
  String? name;
  double? phone;
  String? image;
  String? id;
  Details({ this.name,  this.image,  this.phone,this.id});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      name: json['name'],
      image: json['image'],
      phone: json['Phone'],
      id: json['id'],
    );
  }

  Map<String,dynamic> toJson()=>{
    'name':name,
    'image':image,
    'Phone':phone,
    'id':id,
  };
  
}
