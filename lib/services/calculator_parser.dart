

import 'dart:developer';

class CalculatorParser {
  final String expression;
  late List<int> runes;
  int lookAheadIndex = 0;

  CalculatorParser({required this.expression}) {
    runes = expression.runes.toList();
  }

  double s() {
   double x = a();
   double y = sPrime();

   return x - y;
  }

  double sPrime() {
    if (expression[lookAheadIndex] == "-") {
      lookAheadIndex++;

      double x = a();
      double y = sPrime();

      return x - y;
    }

    return 0;
  }

  double a() {
    double x = b();
    double y = aPrime();

    return x + y;
  }

  double aPrime() {
    if (expression[lookAheadIndex] == "+") {
      lookAheadIndex++;

      double x = b();
      double y = aPrime();

      return x + y;
    }

    return 0;
  }

  double b() {
    double x = c();
    double y = bPrime();

    return x * y;
  }

  double bPrime() {
    if (expression[lookAheadIndex] == "*") {
      lookAheadIndex++;

      double x = c();
      double y = bPrime();

      return x * y;
    }

    return 1;
  }

  double c() {
    double x = d();
    double y = cPrime();

    return x / y;
  }

  double cPrime() {
    if (expression[lookAheadIndex] == "/") {
      lookAheadIndex++;

      double x = d();
      double y = cPrime();

      return x / y;
    }

    return 1;
  }

  double d() {
    if (expression[lookAheadIndex] == "(") {
      lookAheadIndex++;
      double x = s();

      if (expression[lookAheadIndex] == ")") {
        lookAheadIndex++;
        return x;
      } else {
        throw Exception("Unbalanced brackets");
      }
    }

    StringBuffer operand = StringBuffer("");

    while (expression[lookAheadIndex] == "." || int.tryParse(expression[lookAheadIndex]) != null) {
      operand.write(expression[lookAheadIndex]);
      lookAheadIndex++;
    }

    log(operand.toString());

    return double.parse(operand.toString());
  }

  double parse() {
    return s();
  }
}
