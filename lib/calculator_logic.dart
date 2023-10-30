import 'package:calculator/calculator_ui.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String currentInput = '';
  String result = '';

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        try {
          result = _calculateExpression(currentInput);
        } catch (e) {
          result = 'Error';
        }
      } else if (buttonText == 'C') {
        currentInput = '';
        result = '';
      } else {
        currentInput += buttonText;
      }
    });
  }

  String _calculateExpression(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);
      return evalResult.toStringAsFixed(2);
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              decoration: const BoxDecoration(
                color: Colors.black, // Set the background color to orange
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  currentInput,
                  style: const TextStyle(
                      fontSize: 44.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JosefinSans-Italic-VariableFont_wght.ttf'),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the text color to white
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              padding: const EdgeInsets.all(8.0), // Add padding around the grid
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final buttonValues = [
                    '7',
                    '8',
                    '9',
                    '/',
                    '4',
                    '5',
                    '6',
                    '*',
                    '1',
                    '2',
                    '3',
                    '-',
                    '0',
                    'C',
                    '=',
                    '+',
                  ];
                  String buttonText = buttonValues[index];

                  Color buttonColor = buttonText == '+' ||
                          buttonText == '-' ||
                          buttonText == '/' ||
                          buttonText == '*'
                      ? Colors.orange
                      : Colors.grey;

                  if (buttonText == 'C') {
                    buttonColor = Colors.red;
                  }
                  if (buttonText == '=') {
                    buttonColor = Colors.green;
                  }

                  return Container(
                    margin: const EdgeInsets.all(15.0),
                    child: CalculatorButton(
                      text: buttonText,
                      onPressed: () {
                        onButtonPressed(buttonText);
                      },
                      backgroundColor: buttonColor,
                    ),
                  );
                },
                itemCount: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
