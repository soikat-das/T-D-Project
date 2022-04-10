import 'dart:math';

import 'package:flutter/material.dart';
import 'package:soikat/calc.dart';
import 'package:soikat/resultScreen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  num? sys,
      d,
      s1,
      s2,
      s3,
      subConductors,
      spacing,
      strands,
      diameter,
      length,
      mode,
      res,
      freq,
      volt,
      load,
      pf;

  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateOnlyCustomIndicatorText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;
  ButtonState stateTextWithIconMinWidthState = ButtonState.idle;

  Widget buildTextWithIconWithMinState() {
    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle: IconedButton(
          text: "Calculate",
          icon: Icon(
            Icons.send,
            color: Colors.white,
          ),
          color: Colors.deepPurple,
        ),
        ButtonState.loading: IconedButton(
          text: "Loading",
          color: Colors.deepPurple.shade700,
        ),
        ButtonState.fail: IconedButton(
          text: "Failed",
          icon: Icon(
            Icons.cancel,
            color: Colors.white,
          ),
          color: Colors.red.shade300,
        ),
        ButtonState.success: IconedButton(
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400,
        )
      },
      onPressed: onPressedIconWithMinWidthStateText,
      state: stateTextWithIconMinWidthState,
      minWidthStates: [ButtonState.loading, ButtonState.success],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isFinished = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('T&D Project'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "System Type",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                DropdownButtonFormField2<String>(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  isExpanded: true,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hint: sys == null
                      ? Text('System Type')
                      : (sys == 1
                          ? Text("Symmetrical")
                          : Text("Unsymmetrical")),
                  items: [
                    DropdownMenuItem(
                      child: Text('Symmetrical'),
                      value: "1",
                    ),
                    DropdownMenuItem(
                      child: Text('Unsymmetrical'),
                      value: "2",
                    )
                  ],
                  onChanged: (index) {
                    setState(() {
                      sys = num.parse(index!);
                    });
                  },
                ),
                if (sys == 1) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Spacing between the phase conductors",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextField(
                    onChanged: (val) {
                      if (val.isEmpty) return;
                      d = num.parse(val);
                    },
                    decoration: InputDecoration(
                      hintText: "in m",
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Spacing between the phase conductors",
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ] else if (sys == 2) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Spacing between the phase conductor 1 and 2",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextField(
                    onChanged: (val) {
                      if (val.isEmpty) return;
                      s1 = num.parse(val);
                    },
                    decoration: InputDecoration(
                      hintText: "in m",
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Spacing between the phase conductor 1 and 2",
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Spacing between the phase conductor 2 and 3",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextField(
                    onChanged: (val) {
                      if (val.isEmpty) return;
                      s2 = num.parse(val);
                    },
                    decoration: InputDecoration(
                      hintText: "in m",
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Spacing between the phase conductor 1 and 2",
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Spacing between the phase conductor 3 and 1",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextField(
                    onChanged: (val) {
                      if (val.isEmpty) return;
                      s3 = num.parse(val);
                    },
                    decoration: InputDecoration(
                      hintText: "in m",
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Spacing between the phase conductor 3 and 1",
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Number of sub-conductors per bundle",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                DropdownButtonFormField2<String>(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  isExpanded: true,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hint: subConductors == null
                      ? Text('Number of sub-conductors per bundle')
                      : Text(subConductors.toString()),
                  items: [
                    DropdownMenuItem(
                      child: Text('2'),
                      value: "2",
                    ),
                    DropdownMenuItem(
                      child: Text('3'),
                      value: "3",
                    ),
                    DropdownMenuItem(
                      child: Text('4'),
                      value: "4",
                    ),
                    DropdownMenuItem(
                      child: Text('6'),
                      value: "6",
                    ),
                  ],
                  onChanged: (index) {
                    setState(() {
                      subConductors = num.parse(index!);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Spacing between the sub-conductors",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    if (val.isEmpty) return;
                    spacing = num.parse(val);
                  },
                  decoration: InputDecoration(
                    hintText: "in cm",
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Spacing between the sub-conductors",
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Number of strands in each sub conductor",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    if (val.isEmpty) return;
                    strands = num.parse(val);
                  },
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Number of strands in each sub conductor",
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Diameter of each strand",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    if (val.isEmpty) return;
                    diameter = num.parse(val);
                  },
                  decoration: InputDecoration(
                    hintText: "in mm",
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Diameter of each strand",
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Length of the line",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    if (val.isEmpty) return;
                    length = num.parse(val);
                  },
                  decoration: InputDecoration(
                    hintText: "in km",
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Length of the line",
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Model of the line",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                DropdownButtonFormField2<String>(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  isExpanded: true,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hint: mode == null
                      ? Text('Model of the line')
                      : (mode == 1
                          ? Text("Short")
                          : (mode == 2 ? Text('Nominal Pi') : Text("Long"))),
                  items: [
                    DropdownMenuItem(
                      child: Text('Short'),
                      value: "1",
                    ),
                    DropdownMenuItem(
                      child: Text('Nominal Pi'),
                      value: "2",
                    ),
                    DropdownMenuItem(
                      child: Text('Long'),
                      value: "3",
                    ),
                  ],
                  onChanged: (index) {
                    setState(() {
                      mode = num.parse(index!);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Resistance of the line per km",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    if (val.isEmpty) return;
                    res = num.parse(val);
                  },
                  decoration: InputDecoration(
                    hintText: "in Ohm",
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Resistance of the line per km",
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Power Frequency",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    if (val.isEmpty) return;
                    freq = num.parse(val);
                  },
                  decoration: InputDecoration(
                    hintText: "in Hz",
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Power Frequency",
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Nominal System Voltage",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    if (val.isEmpty) return;
                    volt = num.parse(val);
                  },
                  decoration: InputDecoration(
                    hintText: "in kV",
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Nominal System Voltage",
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Receiving End Load",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    if (val.isEmpty) return;
                    load = num.parse(val);
                  },
                  decoration: InputDecoration(
                    hintText: "in MW",
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Receiving End Load",
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Power Factor of Receiving End Load",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    if (val.isEmpty) return;
                    pf = num.parse(val);
                  },
                  decoration: InputDecoration(
                    //hintText: "",
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Power Factor of Receiving End Load",
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: buildTextWithIconWithMinState(),
                ),
                SizedBox(
                  height: 100,
                ),

                // SwipingButton(
                //   text: "Start",
                //   onSwipeCallback: () {
                //     print("Called back");
                //   },
                //   height: 50,
                //   swipeButtonColor: Colors.green,

                // ),
                // SwipeableButtonView(
                //   buttonText: 'Slide To Calculate',
                //   buttonWidget: Container(
                //     child: Icon(
                //       Icons.arrow_forward_ios_rounded,
                //       color: Colors.grey,
                //     ),
                //   ),
                //   activeColor: Color(0xFF009C41),
                //   isFinished: isFinished,
                //   onWaitingProcess: () {
                //     Future.delayed(Duration(seconds: 2), () {
                //       setState(() {
                //         isFinished = true;
                //       });
                //     });
                //   },
                //   onFinish: () async {
                //     // Map<String, dynamic>? result = calc(
                //     //     sys,
                //     //     d,
                //     //     s1,
                //     //     s2,
                //     //     s3,
                //     //     subConductors,
                //     //     spacing,
                //     //     strands,
                //     //     diameter,
                //     //     length,
                //     //     mode,
                //     //     res,
                //     //     freq,
                //     //     volt,
                //     //     load,
                //     //     pf);

                //     // print(result);

                //     //await Navigator.push()

                //     // Navigator.of(context).push(
                //     //   MaterialPageRoute(
                //     //     builder: (context) => ResultScreen(result: result),
                //     //   ),
                //     // );

                //     await Navigator.push(
                //         context,
                //         PageTransition(
                //           type: PageTransitionType.fade,
                //           child: ResultScreen(),
                //         ));

                //     //TODO: For reverse ripple effect animation
                //     setState(() {
                //       isFinished = false;
                //     });
                //   },
                // ),
                // TextButton(
                //   onPressed: () {
                //     Map<String, dynamic>? result = calc(
                //         sys,
                //         d,
                //         s1,
                //         s2,
                //         s3,
                //         subConductors,
                //         spacing,
                //         strands,
                //         diameter,
                //         length,
                //         mode,
                //         res,
                //         freq,
                //         volt,
                //         load,
                //         pf);

                //     print(result);

                //     // Navigator.of(context).push(
                //     //   MaterialPageRoute(
                //     //     builder: (context) => ResultScreen(result: result),
                //     //   ),
                //     // );
                //   },
                //   child: Text("Submit"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressedCustomButton() {
    setState(() {
      switch (stateOnlyText) {
        case ButtonState.idle:
          stateOnlyText = ButtonState.loading;
          break;
        case ButtonState.loading:
          stateOnlyText = ButtonState.fail;
          break;
        case ButtonState.success:
          stateOnlyText = ButtonState.idle;
          break;
        case ButtonState.fail:
          stateOnlyText = ButtonState.success;
          break;
      }
    });
  }

  void onPressedCustomIndicatorButton() {
    setState(() {
      switch (stateOnlyCustomIndicatorText) {
        case ButtonState.idle:
          stateOnlyCustomIndicatorText = ButtonState.loading;
          break;
        case ButtonState.loading:
          stateOnlyCustomIndicatorText = ButtonState.fail;
          break;
        case ButtonState.success:
          stateOnlyCustomIndicatorText = ButtonState.idle;
          break;
        case ButtonState.fail:
          stateOnlyCustomIndicatorText = ButtonState.success;
          break;
      }
    });
  }

  void onPressedIconWithText() async {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            stateTextWithIcon = Random.secure().nextBool()
                ? ButtonState.success
                : ButtonState.fail;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }

  void onPressedIconWithMinWidthStateText() {
    switch (stateTextWithIconMinWidthState) {
      case ButtonState.idle:
        stateTextWithIconMinWidthState = ButtonState.loading;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            stateTextWithIconMinWidthState = ButtonState.success;
          });
          Future.delayed(Duration(seconds: 1), () {
            Map<String, dynamic>? result = calc(
                sys,
                d,
                s1,
                s2,
                s3,
                subConductors,
                spacing,
                strands,
                diameter,
                length,
                mode,
                res,
                freq,
                volt,
                load,
                pf);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(
                  result: result,
                ),
              ),
            );
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIconMinWidthState = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIconMinWidthState = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIconMinWidthState = stateTextWithIconMinWidthState;
    });
  }
}
