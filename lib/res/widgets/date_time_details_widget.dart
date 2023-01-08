import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/screen_size.dart';
import '../controller/bloc_exports.dart';

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final df = new DateFormat('dd MMM');
    return Container(
      margin: const EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Column(
                children: [
                  const Text(
                    'Time',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return Container(
                          child: Text(
                        '${state.orderModel!.orderTime!.hour} : ${state.orderModel!.orderTime!.minute}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ));
                    },
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
            const VerticalDivider(
              thickness: 3,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Column(
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return Container(
                        child: Text(
                          df.format(state.orderModel!.orderDate!),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
