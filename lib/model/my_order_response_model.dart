class MyOrderResponseModel {
  final int id;
  final String meal1;
  final String meal2;
  final String orderDate;
  final bool canBeEdited;
  final String status;

  MyOrderResponseModel({
    required this.id,
    required this.meal1,
    required this.meal2,
    required this.orderDate,
    required this.canBeEdited,
    required this.status,
  });

  factory MyOrderResponseModel.fromJson(Map<String, dynamic> json) {
    return MyOrderResponseModel(
      id: json['id'] as int,
      meal1: json['meal1'] as String,
      meal2: json['meal2'] as String,
      orderDate: json['order_date'] as String,
      canBeEdited: json['can_be_edited'] as bool,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meal1': meal1,
      'meal2': meal2,
      'order_date': orderDate,
      'can_be_edited': canBeEdited,
      'status': status,
    };
  }
}