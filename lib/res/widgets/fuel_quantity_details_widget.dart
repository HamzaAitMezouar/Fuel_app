import 'package:flutter/material.dart';

import '../constants/screen_size.dart';
import '../controller/bloc_exports.dart';

class FuelQuantityWidget extends StatelessWidget {
  const FuelQuantityWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    'Fuel',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return Container(
                          child: Text(
                        state.orderModel!.orderType!,
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
                    'Quantity',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Text(
                            state.orderModel!.orderQuantity.toString(),
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            ' Liters',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ],
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
