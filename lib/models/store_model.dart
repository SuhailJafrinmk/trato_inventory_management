class StoreModel {
  final String storeName;
  final String location;
  final String contactInfo;
  final String gstId;
  final String currency;
  StoreModel(
      {required this.storeName,
      required this.location,
      required this.contactInfo,
      required this.gstId,
      required this.currency});
  Map<String, dynamic> toMap() {
    return {
      'storeName': storeName,
      'location': location,
      'contactInfo': contactInfo,
      'gstId': gstId,
      'currency': currency,
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> data) {
    return StoreModel(
      storeName: data['storeName'] ?? '',
      location: data['location'] ?? '',
      contactInfo: data['contactInfo'] ?? '',
      gstId: data['gstId'] ?? '',
      currency: data['currency'] ?? '',
    );
  }
}
