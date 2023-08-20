import 'dart:collection';

class CalculatorParse {
  final List<String> terminals = ['id', '/', '*', '+', '-'];
  final List<String> nonTerminals = ['S', 'S\'', 'A', 'A\'', 'B', 'B\'', 'C', 'C\'', 'D'];
  final HashMap<String, HashMap<String, List<String>>> parseTable = HashMap.of({
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

  final List<List<String>> expression;

  CalculatorParse({required this.expression});
}
