// ignore_for_file: must_be_immutable

part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class AddOrder extends OrderEvent {
  OrderModel? orderModel;
  AddOrder(this.orderModel);
}

class DeleteOrder extends OrderEvent {
  OrderModel? orderModel;
  DeleteOrder(this.orderModel);
}
