import 'dart:convert';

import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, dynamic>? result;
  ResultScreen({Key? key, this.result}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.result);
    //String txt = json.encode(widget.result);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result',
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.amberAccent,
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Made By:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('1. Soikat Das (107120121)'),
                      Text('2. Shivpriya Mandal (107120113)'),
                      Text('3. Fahmida Himba Fathima (107120039)'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Inductance per phase per km",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.result?['L'].toStringAsFixed(6) + " mH",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Capacitance per phase per km",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.result?['CAP'].toStringAsFixed(6) + " nF",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Inductive reactance of the line",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.result?['XL'].toStringAsFixed(6) + " Ohms",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Capacitive reactance of the line",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.result?['XC'].toStringAsFixed(6) + " Ohms",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Charging current drawn from the sending end substation",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.result?['IC'].toStringAsFixed(6) + " A",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "ABCD parameters of the line are",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.result!['A1'] is List<num>) ...[
                  Text(
                    "        A (" +
                        widget.result!['A1'][0].toStringAsFixed(3) +
                        ", " +
                        widget.result!['A1'][1].toStringAsFixed(3) +
                        ")",
                    style: TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ] else ...[
                  Text(
                    "        A (" +
                        widget.result!['A1'].real.toString() +
                        ", " +
                        widget.result!['A1'].imaginary.toString() +
                        ")",
                    style: TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                Text(
                  "        B (" +
                      widget.result!['B1'][0].toStringAsFixed(3) +
                      ", " +
                      widget.result!['B1'][1].toStringAsFixed(3) +
                      ")",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.result!['C1'] is List<num>) ...[
                  Text(
                    "        C (" +
                        widget.result!['C1'][0].toStringAsFixed(3) +
                        ", " +
                        widget.result!['C1'][1].toStringAsFixed(3) +
                        ")",
                    style: TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ] else ...[
                  Text(
                    "        C (" +
                        widget.result!['C1'].real.toString() +
                        ", " +
                        widget.result!['C1'].imaginary.toString() +
                        ")",
                    style: TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                if (widget.result!['D1'] is List<num>) ...[
                  Text(
                    "        D (" +
                        widget.result!['D1'][0].toStringAsFixed(3) +
                        ", " +
                        widget.result!['D1'][1].toStringAsFixed(3) +
                        ")",
                    style: TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ] else ...[
                  Text(
                    "        D (" +
                        widget.result!['D1'].real.toString() +
                        ", " +
                        widget.result!['D1'].imaginary.toString() +
                        ")",
                    style: TextStyle(
                      fontSize: 20,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                SizedBox(
                  height: 20,
                ),
                Text(
                  "The sending end voltage",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.result?['VS'].toStringAsFixed(6) + " kV",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "The sending end current",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.result?['IS'].toStringAsFixed(6) + " A",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "The voltage regulation",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.result?['V_REG'].toStringAsFixed(6) + "%",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "The power loss in the line",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.result?['P_LOSS'].toStringAsFixed(6) + " MW",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "The transmission efficiency",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.result?['efficiency'].toStringAsFixed(6) + "%",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Sending end circle diagram",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "        Center: (" +
                      widget.result!['send_center'][0].toStringAsFixed(3) +
                      ", " +
                      widget.result!['send_center'][1].toStringAsFixed(3) +
                      ")",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "        Radius: " +
                      widget.result!['send_radius'].toStringAsFixed(3),
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Receiving end circle diagram",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "        Center: (" +
                      widget.result!['receive_center'][0].toStringAsFixed(3) +
                      ", " +
                      widget.result!['receive_center'][1].toStringAsFixed(3) +
                      ")",
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "        Radius: " +
                      widget.result!['receive_radius'].toStringAsFixed(3),
                  style: TextStyle(
                    fontSize: 20,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
