// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:fuel/res/model/order_model.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState()) {
    on<AddOrder>((event, emit) {
      final state = this.state;
      emit(OrderState(orderModel: event.orderModel));
    });
    on<DeleteOrder>((event, emit) {});
  }
}
