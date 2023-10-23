import 'dart:math';

import 'package:flutter/material.dart';

class screen extends StatefulWidget {
  const screen({Key? key}) : super(key: key);

  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<screen> {
  String text = '0';
  double numOne = 0;
  double numTwo = 0;
  String result = '';
  String finalResult = '';
  String opr = '';
  double backnum = 0;

  void calc(String txt) {
    if (txt == 'c') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      backnum = 0;
    } else if (backnum != 0 &&
        (txt == '+' ||
            txt == '-' ||
            txt == 'x' ||
            txt == '/' ||
            txt == '=' ||
            txt == '%' ||
            txt == '^')) {
      numOne = backnum;
    } else if (txt == '+' ||
        txt == '-' ||
        txt == 'x' ||
        txt == '/' ||
        txt == '=' ||
        txt == '%' ||
        txt == '^') {
      if (numOne == 0) {
        numOne = double.parse(result);
        backnum = 0;
      } else {
        numTwo = double.parse(result);
      }
      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      } else if (opr == '^') {
        finalResult = power();
      } else if (opr == '%') {
        finalResult = modelus();
      }

      opr = txt;
      result = '';
    } else if (txt == '!') {
      numOne = double.parse(result);
      finalResult = factorial();
    } else {
      result += txt;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    backnum = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    backnum = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    backnum = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    backnum = double.parse(result);
    return doesContainDecimal(result);
  }

  String power() {
    result = (pow(numOne, numTwo)).toString();
    backnum = double.parse(result);
    return doesContainDecimal(result);
  }

  double factorial1(double num) {
    if (num == 1) {
      return 1;
    }
    return num * factorial1(num - 1);
  }

  String factorial() {
    result = factorial1(numOne).toString();
    backnum = double.parse(result);
    return doesContainDecimal(result);
  }

  String modelus() {
    result = (numOne % numTwo).toString();
    backnum = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(String result) {
    if (result.contains('.')) {
      double value = double.parse(result);
      if (value % 1 == 0) {
        return value.toInt().toString();
      }
    }
    return result;
  }

  Widget button(String txt, Color buttoncolor, Color txtcolor) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 70,
        width: 70,
        child: ElevatedButton(
          onPressed: () {
            calc(txt);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: buttoncolor,
          ),
          child: Text(
            txt,
            style: TextStyle(color: txtcolor, fontSize: 40),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Calculator',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 90,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('+', Colors.blue, Colors.white),
                button('-', Colors.blue, Colors.white),
                button('/', Colors.blue, Colors.white),
                button('x', Colors.blue, Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('7', Colors.grey, Colors.white),
                button('8', Colors.grey, Colors.white),
                button('9', Colors.grey, Colors.white),
                button('%', Colors.blue, Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('4', Colors.grey, Colors.white),
                button('5', Colors.grey, Colors.white),
                button('6', Colors.grey, Colors.white),
                button('!', Colors.blue, Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('1', Colors.grey, Colors.white),
                button('2', Colors.grey, Colors.white),
                button('3', Colors.grey, Colors.white),
                button('^', Colors.blue, Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button('0', Colors.grey, Colors.white),
                button('.', Colors.grey, Colors.white),
                button('c', Colors.blue, Colors.white),
                button('=', Colors.black, Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
