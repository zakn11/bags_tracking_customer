class MyInfoDataModel {
    int id;
    String name;
    String phone;
    String? employeeNumber;
    dynamic image;
    String role;

    MyInfoDataModel({
        required this.id,
        required this.name,
        required this.phone,
        required this.employeeNumber,
        required this.image,
        required this.role,
    });

  factory MyInfoDataModel.fromJson(Map<String, dynamic> json) {
    return MyInfoDataModel(
      id: json['id'],
      role: json['role'],
      name: json['name'],
      phone: json['phone'],
      employeeNumber: json['employee_number'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'name': name,
      'phone': phone,
      'employee_number': employeeNumber,
      'image': image,
    };
  }
}
