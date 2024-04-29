class StoreModel {
  final String id;
  final String storeName;
  final double latitude;
  final double longitude;
  final int? distance;

  StoreModel(
      {required this.id,
      required this.storeName,
      required this.latitude,
      required this.longitude,
      this.distance});
  factory StoreModel.fromMap(Map<String, dynamic> json) => StoreModel(
      id: json['id'],
      storeName: json['storeName'],
      latitude: json['latitude'],
      longitude: json['longitude']);
}
