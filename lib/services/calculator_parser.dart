import 'dart:collection';

import 'package:tuple/tuple.dart';

class CalculatorParse {
  static final List<String> terminals = ['id', '/', '*', '+', '-'];
  static final List<String> nonTerminals = ['S', 'S\'', 'A', 'A\'', 'B', 'B\'', 'C', 'C\'', 'D'];
  static final HashMap<String, HashMap<String, List<String>>> parseTable = HashMap.of({
    "S": HashMap.of({
      "id": ["A", "S'"],
      "(": ["A", "S'"],
    }),
    "S'": HashMap.of({
      "-": ["-", "A", "S'"],
      ")": ["_"],
      "\$": ["_"],
    }),
    "A": HashMap.of({
      "id": ["B", "A'"],
      "(": ["B", "A'"],
    }),
    "A'": HashMap.of({
      "-": ["_"],
      "+": ["+", "B", "A'"],
      ")": ["_"],
      "\$": ["_"],
    }),
    "B": HashMap.of({
      "id": ["C", "B'"],
      "(": ["C", "B'"],
    }),
    "B'": HashMap.of({
      "-": ["_"],
      "+": ["_"],
      "*": ["*", "C", "B'"],
      ")": ["_"],
      "\$": ["_"],
    }),
    "C": HashMap.of({
      "id": ["D", "C'"],
      "(": ["D", "C'"],
    }),
    "C'": HashMap.of({
      "-": ["_"],
      "+": ["_"],
      "*": ["_"],
      "/": ["/", "D", "C'"],
      ")": ["_"],
      "\$": ["_"],
    }),
    "D": HashMap.of({
      "id": ["id"],
      "(": ["(", "S", ")"],
    }),
  });

  // final List<Tuple2<String, double>> expression;

  // CalculatorParse({required this.expression});

  static double parse({ required List<Tuple2<String, double>> expression }) {
    double result = 0;

    List<Tuple2<String, double>> stack = [
      const Tuple2(
          "\$",
          double.nan,
      ),
      const Tuple2(
          "S",
          double.nan,
      ),
    ];

    int lookAheadIdx = 0;
    String stackTop = stack.removeLast().item1;
    String lookAhead = expression[lookAheadIdx].item1;
    double lookAheadValue = expression[lookAheadIdx].item2;

    while (stackTop != "\$" && lookAhead != "\$") {
      if (stackTop == lookAhead) {
        lookAheadIdx++;
      } else {
        var actions = parseTable[stackTop]![lookAhead]!.reversed.toList();

        for (int i = 0; i < actions.length; i++) {
          stack.add(Tuple2(actions[i], lookAheadValue));
        }
      }

      stackTop = stack.removeLast().item1;
      lookAhead = expression[lookAheadIdx].item1;
      lookAheadValue = expression[lookAheadIdx].item2;
    }

    return result;
  }
}
