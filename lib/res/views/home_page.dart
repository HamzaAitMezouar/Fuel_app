// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuel/res/constants/screen_size.dart';
import 'package:fuel/res/controller/bloc/order_bloc.dart';
import 'package:fuel/res/controller/bloc_exports.dart';
import 'package:fuel/res/model/order_model.dart';
import 'package:fuel/res/views/order_ticket.dart';
import 'package:fuel/res/widgets/app_bar_widget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //0 for Diesel
  //1 for Petrol
  // 2 for Oil
  @override
  void initState() {
    super.initState();

    _updatePositioN();
  }

  int choosedOption = 0;
  int quanity = 5;
  double total = 0;
  String orderType = '';
  double longitude = 0.0, laltitude = 0.0;
  final df = new DateFormat('dd MMM');
  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime chosedDate = DateTime.now();
  TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBarWidget(),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: height * 0.08,
                  width: width * 0.33,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          onPrimary: Colors.black,
                          primary: choosedOption == 0
                              ? Colors.yellow
                              : Colors.white),
                      onPressed: () {
                        setState(() {
                          choosedOption = 0;
                        });
                      },
                      child: const Text('Diesel'))),
              Container(
                  height: height * 0.08,
                  width: width * 0.33,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          onPrimary: Colors.black,
                          primary: choosedOption == 1
                              ? Colors.yellow
                              : Colors.white),
                      onPressed: () {
                        setState(() {
                          choosedOption = 1;
                        });
                      },
                      child: const Text('Petrol'))),
              Container(
                  height: height * 0.08,
                  width: width * 0.33,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          onPrimary: Colors.black,
                          primary: choosedOption == 2
                              ? Colors.yellow
                              : Colors.white),
                      onPressed: () {
                        setState(() {
                          choosedOption = 2;
                        });
                      },
                      child: const Text('EngineOil')))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Quantity (Liters)',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: height * 0.03),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.08,
                            width: width * 0.2,
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: ((value) {
                                  setState(() {
                                    quanity = int.parse(value);
                                    log('${quanity.toString()}');
                                  });
                                }),
                                controller: text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: height * 0.03),
                                  hintText: '$quanity Lts',
                                )),
                          ),
                          SizedBox(
                            height: height * 0.08,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        quanity++;
                                      });
                                    },
                                    child: Icon(
                                      Icons.arrow_drop_up,
                                      size: 22,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    if (quanity <= 5) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Minimum Quanitity is 5 liters')));
                                    } else {
                                      setState(() {
                                        quanity--;
                                      });
                                    }
                                  },
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    size: 22,
                                    color: quanity == 5
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 2.5,
                  indent: width * 0.05,
                  endIndent: width * 0.05,
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Date',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: height * 0.03),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.6,
                      height: height * 0.08,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.white,
                              onPrimary: Colors.black),
                          onPressed: () async {
                            DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: chosedDate,
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 30)));
                            if (date == null) return;

                            setState(() {
                              chosedDate = date;
                            });
                            log('chosedDare ==========> $chosedDate');
                          },
                          child: Text(' ${df.format(chosedDate)}')),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 2.5,
                  indent: width * 0.05,
                  endIndent: width * 0.05,
                ),
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Time',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: height * 0.03),
                        )),
                    SizedBox(
                      width: width * 0.6,
                      height: height * 0.08,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.white,
                              onPrimary: Colors.black),
                          onPressed: () async {
                            TimeOfDay? time = await showTimePicker(
                                context: context, initialTime: timeOfDay);
                            if (time == null) return;

                            setState(() {
                              timeOfDay = time;
                            });
                            log('chosed time ==========> $timeOfDay');
                          },
                          child:
                              Text('${timeOfDay.hour} : ${timeOfDay.minute}')),
                    )
                  ],
                )
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: height * 0.07,
              width: width * 0.7,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.amber,
                  ),
                  onPressed: () {
                    //1.2 diesel price // 2 oil price and 4.2 oil price
                    if (choosedOption == 0) {
                      setState(() {
                        total = quanity.toDouble() * 1.2;
                        orderType = "Diesel";
                      });
                    } else if (choosedOption == 1) {
                      setState(() {
                        total = quanity.toDouble() * 2;
                        orderType = "Petrol";
                      });
                    } else {
                      setState(() {
                        total = quanity.toDouble() * 4.2;
                        orderType = 'Engine Oil ';
                      });
                    }
                    log('quantiy $quanity');
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      OrderModel orderModel = OrderModel(
                          orderDate: chosedDate,
                          orderQuantity: quanity.toString(),
                          orderTime: timeOfDay,
                          orderType: orderType,
                          longitude: longitude,
                          laltitude: laltitude,
                          orderTotal: total.toStringAsPrecision(2));
                      log('Order  total ======> ${orderModel.orderTotal}');
                      context.read<OrderBloc>().add(AddOrder(orderModel));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderTicketPage()));
                    });
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  _updatePositioN() async {
    Position position = await _determinePosition();
    List pm =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    log(pm[0].toString());
    setState(() {
      longitude = position.longitude;
      laltitude = position.latitude;
    });
  }
}
