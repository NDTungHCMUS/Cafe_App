import 'package:cafe_app/models/Detail_Info.dart';
class Order {
  Order({required this.detailInfo, required this.month, required this.day, required this.hour, required this.minute, required this.point});
  DetailInfo detailInfo;
  String month;
  int day;
  int hour;
  int minute;
  int point;
  Order copyWith({
    DetailInfo? detailInfo,
    String? month,
    int? day,
    int? hour,
    int? minute,
    int? point,
  }) {
    return Order(
      detailInfo: detailInfo ?? this.detailInfo,
      month: month ?? this.month,
      day: day ?? this.day,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      point: point ?? this.point,
    );
  }
}