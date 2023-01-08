// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:fuel/res/constants/screen_size.dart';
import 'package:fuel/res/controller/bloc_exports.dart';
import 'package:fuel/res/widgets/app_bar_widget.dart';
import 'package:fuel/res/widgets/date_time_details_widget.dart';
import 'package:fuel/res/widgets/order_pricing.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../widgets/fuel_quantity_details_widget.dart';

class OrderTicketPage extends StatefulWidget {
  const OrderTicketPage({Key? key}) : super(key: key);

  @override
  State<OrderTicketPage> createState() => _OrderTicketPageState();
}

class _OrderTicketPageState extends State<OrderTicketPage> {
  final pdf = pw.Document();
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final df = new DateFormat('dd MMM');
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.subscribeToTopic("admin");
    loadFCM();
    _getPdf();
    _listenFCM();
    sendPushMessage();
    getToken();
    listenFCM();
  }

  String token = '';
  void loadFCM() async {
    if (!kIsWeb) {
      channel = AndroidNotificationChannel(
        playSound: true,
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: const AppBarWidget(),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  )),
              const Text(
                'Order Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Container(
                width: width * 0.15,
              )
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 2.5,
          indent: width * 0.05,
          endIndent: width * 0.05,
        ),
        FuelQuantityWidget(),
        Divider(
          color: Colors.grey,
          thickness: 2.5,
          indent: width * 0.05,
          endIndent: width * 0.05,
        ),
        DateTimeWidget(),
        Divider(
          color: Colors.grey,
          thickness: 2.5,
          indent: width * 0.05,
          endIndent: width * 0.05,
        ),
        BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return OrderPricing(ordertype: state.orderModel!.orderType!);
          },
        ),
        Divider(
          color: Colors.grey,
          thickness: 2.5,
          indent: width * 0.05,
          endIndent: width * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'total',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return Text(
                    '${double.parse(state.orderModel!.orderTotal!) + 5}\$',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  );
                },
              )
            ],
          ),
        ),
        BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return Container(
              height: 80,
              width: width * 0.95,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: OSMFlutter(
                controller: MapController(
                  initMapWithUserPosition: false,
                  initPosition: GeoPoint(
                      latitude: state.orderModel!.laltitude!,
                      longitude: state.orderModel!.longitude!),
                  areaLimit: BoundingBox(
                    east: 10.4922941,
                    north: 47.8084648,
                    south: 45.817995,
                    west: 5.9559113,
                  ),
                ),
                trackMyPosition: true,
                initZoom: 12,
                minZoomLevel: 8,
                maxZoomLevel: 14,
                stepZoom: 1.0,
                userLocationMarker: UserLocationMaker(
                  personMarker: MarkerIcon(
                    icon: Icon(
                      Icons.location_history_rounded,
                      color: Colors.black,
                      size: 48,
                    ),
                  ),
                  directionArrowMarker: MarkerIcon(
                    iconWidget: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/loc.png'),
                    ),
                  ),
                ),
                roadConfiguration: RoadConfiguration(
                  startIcon: MarkerIcon(
                    iconWidget: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/loc.png'),
                    ),
                  ),
                  roadColor: Colors.yellowAccent,
                ),
                markerOption: MarkerOption(
                    defaultMarker: MarkerIcon(
                  iconWidget: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/loc.png'),
                  ),
                )),
              ),
            );
          },
        ),
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
                onPressed: () async {
                  sendPushMessage();

                  final output = await getTemporaryDirectory();
                  final file = File("${output.path}/order.pdf");
                  Uint8List savedPDf = await pdf.save();
                  await file.writeAsBytes(savedPDf);
                  log(pdf.document.encryption.toString());
                },
                child: Text(
                  'Send Order',
                  style: TextStyle(color: Colors.black),
                )),
          ),
        ),
      ]),
    );
  }

  _getPdf() {
    BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        pdf.addPage(pw.Page(build: ((context) {
          return pw.Column(
            children: [
              pw.Container(
                child: pw.Row(
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.only(left: 40),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Fuel',
                            style: pw.TextStyle(
                                fontSize: 14, fontWeight: pw.FontWeight.normal),
                          ),
                          pw.SizedBox(
                            height: height * 0.02,
                          ),
                          pw.Container(
                              child: pw.Text(
                            state.orderModel!.orderType!,
                            style: pw.TextStyle(fontSize: 25),
                          )),
                          pw.SizedBox(
                            height: height * 0.01,
                          ),
                        ],
                      ),
                    ),
                    pw.VerticalDivider(
                      thickness: 3,
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.only(right: 40),
                      child: pw.Column(children: [
                        pw.Text(
                          'Quantity',
                          style: pw.TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        pw.SizedBox(
                          height: height * 0.02,
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              state.orderModel!.orderQuantity.toString(),
                              style: pw.TextStyle(
                                  fontSize: 25, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              ' Liters',
                              style: pw.TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  ],
                ),
              ),
              pw.Container(
                child: pw.Row(
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.only(left: 40),
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Time',
                            style: pw.TextStyle(
                                fontSize: 14, fontWeight: pw.FontWeight.normal),
                          ),
                          pw.SizedBox(
                            height: height * 0.02,
                          ),
                          pw.Container(
                              child: pw.Text(
                            '${state.orderModel!.orderTime!.hour} : ${state.orderModel!.orderTime!.minute}',
                            style: pw.TextStyle(fontSize: 25),
                          )),
                          pw.SizedBox(
                            height: height * 0.01,
                          ),
                        ],
                      ),
                    ),
                    pw.VerticalDivider(
                      thickness: 3,
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.only(right: 40),
                      child: pw.Column(children: [
                        pw.Text(
                          'Date',
                          style: pw.TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        pw.SizedBox(
                          height: height * 0.02,
                        ),
                        pw.Row(
                          children: [
                            pw.Text(
                              df.format(state.orderModel!.orderDate!),
                              style: pw.TextStyle(
                                  fontSize: 25, fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        )
                      ]),
                    ),
                  ],
                ),
              ),
              pw.Divider(
                thickness: 2.5,
                indent: width * 0.05,
                endIndent: width * 0.05,
              ),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'total',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 20),
                    ),
                    pw.Text(
                      '${double.parse(state.orderModel!.orderTotal!) + 5}\$',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          );
        })));
        return Container();
      },
    );
  }

  void _listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void sendPushMessage() async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key= AAAAuYdQUz4:APA91bHfPK13PCjR2Y3hKIIonZy12SCwPdJ8wA31a17z5VI_wmCYdMRyoQKD7VBNhp1SbAE89xLgjeptXIt6kOiPqm-C5JK0aEC6cbYpGWNvf-sR_92-HWcFAcPTwhGn2GOdjdTB8KcD ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'Test Body',
              'title': 'Test Title 2'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": "topics/admin",
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((newtoken) {
      setState(() {
        token = newtoken!;
        log('token $token');
      });
    });
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }
}
