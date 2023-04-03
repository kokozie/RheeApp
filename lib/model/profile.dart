class ProfileModel {
  String? id;
  String name;
  int age;
  String email;
  int phone;
  String address;
  String hobbies;

  ProfileModel({
    this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    required this.address,
    required this.hobbies,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      'address': address,
      'hobbies': hobbies,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      hobbies: map['hobbies'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      'address': address,
      'hobbies': hobbies,
    };
  }
  ProfileModel copyWith({
    String? id,
    String? name,
    int? age,
    String? email,
    int? phone,
    String? address,
    String? hobbies,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      hobbies: hobbies ?? this.hobbies,
    );
  }
}
