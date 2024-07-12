class StoreModel {
  final String storeName;
  final String location;
  final String contactInfo;
  final String gstId;
  StoreModel(
      {required this.storeName,
      required this.location,
      required this.contactInfo,
      required this.gstId,
      });
  Map<String, dynamic> toMap() {
    return {
      'storeName': storeName,
      'location': location,
      'contactInfo': contactInfo,
      'gstId': gstId,
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> data) {
    return StoreModel(
      storeName: data['storeName'] ?? '',
      location: data['location'] ?? '',
      contactInfo: data['contactInfo'] ?? '',
      gstId: data['gstId'] ?? '',
    );
  }
}
