class QrScanModel {
  int code;
  String message;
  QrScanDataModel data;

  QrScanModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory QrScanModel.fromJson(Map<String, dynamic> json) {
    return QrScanModel(
      code: json['code'] as int,
      message: json['message'] as String,
      data: QrScanDataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class QrScanDataModel {
  String customerName;
  int bagId;
  String newState;

  QrScanDataModel({
    required this.customerName,
    required this.bagId,
    required this.newState,
  });

  factory QrScanDataModel.fromJson(Map<String, dynamic> json) {
    return QrScanDataModel(
      customerName: json['customer_name'] as String,
      bagId: json['bag_id'] as int,
      newState: json['new_state'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_name': customerName,
      'bag_id': bagId,
      'new_state': newState,
    };
  }
}
