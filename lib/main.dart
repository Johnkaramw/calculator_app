import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'آلة حاسبة',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "";
  String _output = "";
  String _operation = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  bool isScientific = false;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "";
        _operation = "";
        output = "";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "/" ||
          buttonText == "*") {
        if (operand.isNotEmpty && _output.isNotEmpty) {
          buttonPressed("=");
        }
        num1 = double.parse(output.isEmpty ? "0" : output);
        operand = buttonText;
        _operation = output + " " + operand;
        _output = "";
      } else if (buttonText == ".") {
        if (_output.contains(".")) {
          return;
        } else {
          _output += buttonText;
        }
      } else if (buttonText == "=") {
        if (operand.isEmpty) return;
        num2 = double.parse(output.isEmpty ? "0" : output);
        switch (operand) {
          case "+":
            _output = (num1 + num2).toString();
            break;
          case "-":
            _output = (num1 - num2).toString();
            break;
          case "*":
            _output = (num1 * num2).toString();
            break;
          case "/":
            if (num2 == 0) {
              _output = "Error";
            } else {
              _output = (num1 / num2).toString();
            }
            break;
        }
        _operation = _operation + " " + num2.toString() + " = " + _output;
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
      } else if (buttonText == "Sci") {
        isScientific = !isScientific;
      } else if (buttonText == "⌫") {
        if (_output.length > 1) {
          _output = _output.substring(0, _output.length - 1);
        } else {
          _output = "";
          output = "";
        }
      } else if (isScientific) {
        switch (buttonText) {
          case "√":
            _output = (math.sqrt(double.parse(output.isEmpty ? "0" : output)))
                .toString();
            break;
          case "x²":
            _output = (double.parse(output.isEmpty ? "0" : output) *
                    double.parse(output.isEmpty ? "0" : output))
                .toString();
            break;
          case "x³":
            _output = (double.parse(output.isEmpty ? "0" : output) *
                    double.parse(output.isEmpty ? "0" : output) *
                    double.parse(output.isEmpty ? "0" : output))
                .toString();
            break;
          case "π":
            _output = math.pi.toString();
            break;
        }
        _operation = buttonText +
            "(" +
            (output.isEmpty ? "0" : output) +
            ") = " +
            _output;
      } else {
        if (_output == "Error") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
      output = _output;
    });
  }

  Widget buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            minimumSize: Size(60, 60), // Set minimum size for buttons
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isScientific ? 'آلة حاسبة - العلمية' : 'آلة حاسبة  '),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _operation,
                    style: TextStyle(fontSize: 24.0, color: Colors.grey),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    output.isEmpty ? "0" : output,
                    style: TextStyle(fontSize: 48.0),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("7", Colors.grey.shade800),
                buildButton("8", Colors.grey.shade800),
                buildButton("9", Colors.grey.shade800),
                buildButton("/", Colors.orange),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("4", Colors.grey.shade800),
                buildButton("5", Colors.grey.shade800),
                buildButton("6", Colors.grey.shade800),
                buildButton("*", Colors.orange),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("1", Colors.grey.shade800),
                buildButton("2", Colors.grey.shade800),
                buildButton("3", Colors.grey.shade800),
                buildButton("-", Colors.orange),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton(".", Colors.grey.shade800),
                buildButton("0", Colors.grey.shade800),
                buildButton("+", Colors.orange),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("C", Colors.red),
                buildButton("=", Colors.green),
                buildButton("⌫", Colors.blue),
              ],
            ),
            SizedBox(height: 10.0),
            if (isScientific)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("√", Colors.blue.shade900),
                  buildButton("x²", Colors.blue.shade900),
                  buildButton("x³", Colors.blue.shade900),
                  buildButton("π", Colors.blue.shade900),
                ],
              ),
            SizedBox(height: 10.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                isScientific ? "تحويل إلى العادية" : "تحويل إلى العلمية",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              onPressed: () => buttonPressed("Sci"),
            ),
          ],
        ),
      ),
    );
  }
}
