class GetCustomerInfo {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String role;
  final bool isActive;
  final String address;
  final String area;
  final String driverName;
  final String subscriptionStartDate;
  final String subscriptionExpiryDate;
  final int subscriptionStatus;
  final List<String> bagsAssigned;

  GetCustomerInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.role,
    required this.isActive,
    required this.address,
    required this.area,
    required this.driverName,
    required this.subscriptionStartDate,
    required this.subscriptionExpiryDate,
    required this.subscriptionStatus,
    required this.bagsAssigned,
  });

  factory GetCustomerInfo.fromJson(Map<String, dynamic> json) {
    return GetCustomerInfo(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      isActive: json['is_active'] as bool,
      address: json['address'] as String,
      area: json['area'] as String,
      driverName: json['driverName'] as String,
      subscriptionStartDate: json['subscription_start_date'] as String,
      subscriptionExpiryDate: json['subscription_expiry_date'] as String,
      subscriptionStatus: json['subscription_status'] as int,
      bagsAssigned: List<String>.from(json['bags_assigned'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'role': role,
      'is_active': isActive,
      'address': address,
      'area': area,
      'driverName': driverName,
      'subscription_start_date': subscriptionStartDate,
      'subscription_expiry_date': subscriptionExpiryDate,
      'subscription_status': subscriptionStatus,
      'bags_assigned': bagsAssigned,
    };
  }
}
