import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'آلة حاسة',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  bool isScientific = false;

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "*") {
      if (operand.isNotEmpty && _output != "0") {
        buttonPressed("=");
      }
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already contains a decimal");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      if (operand.isEmpty) return;
      num2 = double.parse(output);
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
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "Sci") {
      setState(() {
        isScientific = !isScientific;
      });
      return;
    } else if (buttonText == "⌫") {
      // Clear one character
      if (_output.length > 1) {
        _output = _output.substring(0, _output.length - 1);
      } else {
        _output = "0";
      }
    } else if (isScientific) {
      if (buttonText == "√") {
        _output = (math.sqrt(double.parse(output))).toString();
      } else if (buttonText == "x²") {
        _output = (double.parse(output) * double.parse(output)).toString();
      } else if (buttonText == "x³") {
        _output =
            (double.parse(output) * double.parse(output) * double.parse(output))
                .toString();
      } else if (buttonText == "π") {
        _output = math.pi.toString();
      }
    } else {
      if (_output == "0" || _output == "Error") {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }

    setState(() {
      output = _output;
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16.0),
            minimumSize: Size(40, 40), // Set minimum size for buttons
            disabledBackgroundColor: Color.fromARGB(255, 0, 255, 42),
            backgroundColor: Color.fromARGB(255, 0, 255, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
        title:
            Text(isScientific ? 'آلة حاسبة - العلمية' : ' آلة حاسبة جون كرم '),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Text(
                output,
                style: TextStyle(fontSize: 48.0),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("/"),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("*"),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-"),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("."),
                buildButton("0"),
                buildButton("+"),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("C"),
                buildButton("="),
                buildButton(isScientific
                    ? "Sci"
                    : "⌫"), // Button to switch to scientific calculator
              ],
            ),
            SizedBox(height: 10.0),
            if (isScientific)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("√"),
                  buildButton("x²"),
                  buildButton("x³"),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
