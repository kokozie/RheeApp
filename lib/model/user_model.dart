class ProfileModel {
  final String name;
  final int age;
  final String address;

  ProfileModel({required this.name, required this.age, required this.address});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'address': address,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      age: json['age'],
      address: json['address'],
    );
  }
}
