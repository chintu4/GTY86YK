import 'package:flutter/material.dart';
import "package:toto/global.dart";
import 'package:toto/screen/page1.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int? _selectedValue = 0;
  int? _selectedValue2 = 0;
  int? _selectedValue3 = 0;
  String? value;
  @override
  void initState() {
    super.initState();
    if (!gl.saved) {
      setState(() {
        gl.setButton = null;
        gl.setImage = null;
        gl.setText = null;
        gl.saved = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.only(left: 70.0),
        color: const Color.fromRGBO(232, 245, 233, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RadioListTile(
                    toggleable: true,
                    title: Text('Text Widget'),
                    value: 1,
                    groupValue: _selectedValue,
                    onChanged: (valued) {
                      setState(() {
                        gl.setText = valued;
                        _selectedValue = valued;
                        print('Option 1 selected');
                      });
                    },
                  ),
                  RadioListTile(
                    toggleable: true,
                    title: Text('Image Widget'),
                    value: 2,
                    groupValue: _selectedValue2,
                    onChanged: (valuedd) {
                      setState(() {
                        gl.setImage = valuedd;
                        _selectedValue2 = valuedd;
                        print('Option 2 selected');
                      });
                    },
                  ),
                  RadioListTile(
                    toggleable: true,
                    title: Text('Button Widget'),
                    value: 3,
                    groupValue: _selectedValue3,
                    onChanged: (valueddd) {
                      setState(() {
                        gl.setButton = valueddd;
                        _selectedValue3 = valueddd;
                        print('Option 3 selected');
                      });
                    },
                  ),
                ]),
            TextButton(
              child: Text(" Import Widgets "),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Add_Widget()));
              },
              style: ButtonStyle(
                alignment: Alignment.center,
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => const Color.fromRGBO(165, 214, 167, 1)),
                side:
                    MaterialStateProperty.all(BorderSide(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
