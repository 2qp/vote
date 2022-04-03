import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class uitest extends StatefulWidget {
  @override
  _uitestState createState() {
    return _uitestState();
  }
}

class _uitestState extends State<uitest> {
  List<Widget> countries = [
    Text("India"),
    const Text("Usa"),
    Text("Uk"),
    Text("Australia"),
    Text("Africa"),
    Text("New zealand"),
    Text("Germany"),
    Text("Italy"),
    Text("Russia"),
    Text("China"),
  ];
  String selectedValue = "";
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {},
          color: CupertinoColors.label,
        ),
        middle: const Text("Profile"),
      ),
      child: Container(
          margin: const EdgeInsets.all(40),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.50,
          //alignment: Alignment.topCenter,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text("Show DatePicker"),
                  onPressed: () {
                    showPicker();
                  },
                ),
                Material(
                  child: Text(
                    selectedValue,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ])),
    );
  }

  void showPicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: MediaQuery.of(context).copyWith().size.height * 0.25,
              color: Colors.white,
              child: CupertinoPicker(
                children: countries,
                onSelectedItemChanged: (value) {
                  String text = countries[value].toString();
                  selectedValue = text.toString();
                  setState(() {});
                },
                itemExtent: 25,
                diameterRatio: 1,
                useMagnifier: true,
                magnification: 1.3,
                looping: true,
              ));
        });
  }
}
