import 'package:flutter/cupertino.dart';
import 'package:fuel/res/controller/bloc_exports.dart';

class OrderPricing extends StatelessWidget {
  String ordertype;
  OrderPricing({Key? key, required this.ordertype}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Liter Price',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              ordertype == 'diesel'
                  ? const Text(
                      '1\$',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    )
                  : ordertype == 'petrol'
                      ? const Text(
                          '2\$',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        )
                      : const Text(
                          '4.2\$',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Dilevry Fee',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Text(
                '5\$',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'TVA',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Text(
                '10 \%',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              )
            ],
          ),
        ),
      ],
    );
  }
}
