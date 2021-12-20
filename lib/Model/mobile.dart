class Mobile {
  final String name;
  final String description;
  final String brand;
  final String thumbImageURL;
  final int catid;
  final String price;
  final double rating;

  Mobile(
      {required this.name,
      required this.description,
      required this.brand,
      required this.thumbImageURL,
      required this.catid,
      required this.price,
      required this.rating});

  factory Mobile.fromMap(Map<String, dynamic> json) => Mobile(
        name: json["name"],
        description: json["description"],
        brand: json["brand"],
        thumbImageURL: json["thumbImageURL"],
        catid: json["catid"],
        price: json["price"],
        rating: json["rating"],
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'brand': brand,
      'thumbImageURL': thumbImageURL,
      'catid': catid,
      'price': price,
      'rating': rating,
    };
  }
}

class Favmobile {
  final int id;
  final String Name;
  final String Description;
  final String Brand;
  final String thumbImageURL;
  final int Catid;
  final String Price;
  final String rating;

  Favmobile({
    required this.id,
    required this.Name,
    required this.Description,
    required this.Brand,
    required this.thumbImageURL,
    required this.Catid,
    required this.Price,
    required this.rating,
  });

  Map<String, dynamic> tomap() {
    return {
      'id': id,
      'Name': Name,
      'Description': Description,
      'Brand': Brand,
      'thumbImageURL': thumbImageURL,
      'Catid': Catid,
      'Price': Price,
      'rating': rating,
    };
  }
}
