// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

OrderModel userModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String userModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel(
      {this.orderType,
      this.orderDate,
      this.orderTime,
      this.orderTotal,
      this.orderQuantity,
      this.orderAdress,
      this.laltitude,
      this.longitude});

  String? orderType;
  DateTime? orderDate;
  TimeOfDay? orderTime;
  String? orderTotal;
  String? orderQuantity;
  String? orderAdress;
  double? longitude, laltitude;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderType: json["order_type"],
        orderDate: json["order_date"],
        orderTime: json["order-time "],
        orderTotal: json["order_total "],
        orderQuantity: json["order_quantity"],
        orderAdress: json["order_adress"],
      );

  Map<String, dynamic> toJson() => {
        "order_type": orderType,
        "order_date": orderDate,
        "order-time ": orderTime,
        "order_total ": orderTotal,
        "order_quantity": orderQuantity,
        "order_adress": orderAdress,
      };
}
