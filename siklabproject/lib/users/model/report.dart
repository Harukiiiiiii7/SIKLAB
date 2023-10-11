class Item {
  final String addressRep;
  final String timeStamp;

  Item({required this.addressRep, required this.timeStamp});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      addressRep: json['addressRep'] as String,
      timeStamp: json['timeStamp'] as String,
    );
  }
}
