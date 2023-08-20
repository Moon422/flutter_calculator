import 'dart:developer';

import 'package:flutter_calculator/services/calculator_parser.dart';

class CalculatorService {
  static double calculate(double left, double right, String operator) {
    log("${left.toString()}, ${right.toString()}, ${operator}");
    switch (operator) {
      case "+":
        return left + right;
      case "-":
        return left - right;
      case "*":
        return left * right;
      case "/":
        return left / right;
    }
    return 0;
  }

  static double simpleCalculate(String expression) {
    double result = double.nan;
    StringBuffer operand = StringBuffer();
    String? operator;

    for (int i = 0; i < expression.length; i++) {
      switch (expression[i]) {
        case '+':
        case '-':
        case '*':
        case '/':
          if (operator == null) {
            result = double.parse(operand.toString());
          } else {
            result = calculate(result, double.parse(operand.toString()), operator);
          }
          operator = expression[i];
          operand.clear();
        default:
          if (expression[i] != " ") {
            operand.write(expression[i]);
          }
      }
      log(result.toString());
    }

    return calculate(result, double.parse(operand.toString()), operator!);
  }

  static double scientificCalculate(String expression) {
    CalculatorParser parser = CalculatorParser(expression: expression);
    return parser.parse();
  }
}