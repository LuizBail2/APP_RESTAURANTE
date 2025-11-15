class Restaurant {
  final String id;
  final String name;
  final String address;
  final String city;
  final String citySearch;
  final double rating;
  final List<MenuItem> menu;
  final String openingHours;
  final String closingHours;
  final String weekendOpening;
  final String weekendClosing;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.citySearch,
    required this.rating,
    required this.menu,
    required this.openingHours,
    required this.closingHours,
    required this.weekendOpening,
    required this.weekendClosing,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map, String documentId) {
    return Restaurant(
      id: documentId,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      citySearch: map['city_search'] ?? '',
      rating: (map['rating'] != null) ? (map['rating'] as num).toDouble() : 0.0,
      menu: map['menu'] != null
          ? (map['menu'] as List)
              .map((item) => MenuItem.fromMap(Map<String, dynamic>.from(item)))
              .toList()
          : [],
      openingHours: map['opening_hours'] ?? '',
      closingHours: map['closing_hours'] ?? '',
      weekendOpening: map['weekend_opening'] ?? '',
      weekendClosing: map['weekend_closing'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'city': city,
      'city_search': citySearch,
      'rating': rating,
      'menu': menu.map((item) => item.toMap()).toList(),
      'opening_hours': openingHours,
      'closing_hours': closingHours,
      'weekend_opening': weekendOpening,
      'weekend_closing': weekendClosing,
    };
  }
}

class MenuItem {
  final String name;


  MenuItem({
    required this.name,
    
  });

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      name: map['name'] ?? '',
  
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
