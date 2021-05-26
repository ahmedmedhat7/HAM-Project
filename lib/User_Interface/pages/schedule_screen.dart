import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/User_Interface/components/build_classes.dart';
import 'package:flutter_auth/User_Interface/components/drawer.dart';
import 'package:flutter_auth/User_Interface/components/week_days.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import 'ScheduleModel.dart';
import 'UserModel.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class ScheduleScreen extends StatefulWidget {
  final UserModel user;

  const ScheduleScreen({Key key, this.user}) : super(key: key);
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final DateFormat dateFormat = DateFormat("hh:mm a");
  @override
  Widget build(BuildContext context) {
    Future<ScheduleModel> buildUser(String id, String current) async {
      final String apiUrl =
          "http://hussam69-001-site1.dtempurl.com/api/ApiHAMController/SesssionsByName";
      final response = await http.post(
        apiUrl,
        body: jsonEncode(<String, String>{"id": id, "current": current}),
        headers: {
          'Content-Type': 'application/json',
          //'Authorization' : 'Bearer $token '
        },
      );

      if (response.statusCode == 200) {
        final String responseString = response.body;
        print(' RESPONSE STATUS =: ${response.statusCode}');
        print('RESPONSE body = ${response.body}');
        return ScheduleModel.fromJson(response.body);
      } else {
        print('Error!');
        print(' RESPONSE STATUS =: ${response.statusCode}');
        print('RESPONSE body = ${response.body}');

        return null;
      }
    }

    Container();
    String satudrday = "Saturday";
    String id = user.id;
    buildUser(id, satudrday);
    List<Session> schedule;
    return Scaffold(
      drawer: MyDrawer(user: user),
      appBar: AppBar(
        title: Text(
          "My Schedule",
          style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: WeekDays(),
          ),
          Container(
            padding: EdgeInsets.all(50.0),
            decoration: BoxDecoration(
              color: Color(0xff1c1427),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80.0),
                topRight: Radius.circular(80.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                BuildClasses(
                  schedule: schedule,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
