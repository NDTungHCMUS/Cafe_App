import 'package:flutter/material.dart';

class DetailInfo {
  DetailInfo({required this.name ,required this.type, required this.nums, required this.shot, required this.select, required this.size, required this.ice, required this.price}) ;

  String name;
  int type; // 0, 1, 2, 3
  int nums; 
  int shot; // 0: single, 1: double
  int select; // 0: cup, 1: glass
  int size; // 0: small, 1: big, 2: so big
  int ice; // 0, 1, 2
  int price;

  DetailInfo copyWith({
    String? name, 
    int? nums,
    int? type,
    int? shot,
    int? select,
    int? ice,
    int? size,
    int? price,
  }) {
    return DetailInfo(
      name: name ?? this.name,
      nums: nums ?? this.nums,
      type: type ?? this.type,
      shot: shot ?? this.shot,
      select: select ?? this.select,
      ice: ice ?? this.ice,
      size: size ?? this.size,
      price: price ?? this.price,
    );
  }

  bool hasAnyDifference(DetailInfo other) {
    // Kiểm tra từng thuộc tính và trả về true nếu tìm thấy ít nhất một thuộc tính khác nhau
    return 
        this.type != other.type ||
        this.shot != other.shot ||
        this.select != other.select ||
        this.ice != other.ice ||
        this.size != other.size ||
        this.name != other.name;
  }

  int similarToItemInList(List<DetailInfo> listDetailInfo) {
    for (int i = 0; i < listDetailInfo.length; i++){
      if (this.hasAnyDifference(listDetailInfo[i]) == false){
        return i;
      }
    }
    return -1;
  }

}