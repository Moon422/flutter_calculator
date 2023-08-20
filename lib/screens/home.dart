import 'dart:developer';
import 'package:flutter/material.dart';
import '../services/calculator_service.dart';

class Home extends StatefulWidget {
  final String title;

  const Home({super.key, required this.title});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  StringBuffer operationPanel = StringBuffer("");
  StringBuffer expression = StringBuffer("");
  StringBuffer inputPanel = StringBuffer("");

  bool fractionalPart = false;

  final backgroundColor = const Color(0xFF0E2433);
  final buttonColor = const Color(0xFF0B344F);
  final equalButtonColor = const Color(0xFF296D98);
  final textColor = Colors.white;
  final buttonTextSize = 25.0;
  final buttonIconSize = 40.0;
  final operationTextSize = 25.0;
  final resultTextSize = 40.0;

  void clearInputPanel() {
    fractionalPart = false;
    inputPanel.clear();
  }

  void clearOperationPanel() {
    operationPanel.clear();
    expression.clear();
  }

  void clearAllPanel() {
    clearInputPanel();
    clearOperationPanel();
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text(
        "Calculator",
        style: TextStyle(color: textColor),
      ),
      centerTitle: true,
      leading: TextButton(
        onPressed: () {},
        child: Icon(
          Icons.menu,
          color: textColor,
        ),
      ),
      backgroundColor: backgroundColor,
    );

    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final bottomControlHeight = MediaQuery.of(context).viewPadding.bottom;
    final buttonHeight = (screenHeight -
            statusBarHeight -
            bottomControlHeight -
            appbar.preferredSize.height) *
        0.11;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appbar,
      body: Column(
        children: [
          // top half
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // header
                    // display
                    Text(
                      operationPanel.toString(),
                      style: TextStyle(
                        fontSize: operationTextSize,
                        color: textColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      inputPanel.isEmpty ? '0' : inputPanel.toString(),
                      style: TextStyle(
                        fontSize: resultTextSize,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // buttons
          // 1st row
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Icon(
                      Icons.expand_more_rounded,
                      color: textColor,
                      size: buttonIconSize,
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    if (inputPanel.isNotEmpty) {
                      setState(() {
                        clearInputPanel();
                      });
                    }
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "c",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      clearAllPanel();
                    });
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "x",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    if (inputPanel.isNotEmpty) {
                      setState(() {
                        operationPanel.writeAll([inputPanel, " / "]);
                        clearInputPanel();
                      });
                    }
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "/",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 2nd row
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    if (inputPanel.isNotEmpty) {
                      setState(() {
                        operationPanel.writeAll([inputPanel, " ( "]);
                        expression.writeAll([inputPanel, "("]);
                        clearInputPanel();
                      });
                    }
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "(",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    if (inputPanel.isNotEmpty) {
                      setState(() {
                        operationPanel.writeAll([inputPanel, " ) "]);
                        expression.writeAll([inputPanel, ")"]);
                        clearInputPanel();
                      });
                    }
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        ")",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    if (inputPanel.isNotEmpty) {
                      setState(() {
                        operationPanel.writeAll([inputPanel, " % "]);
                        expression.writeAll([inputPanel, "%"]);
                        clearInputPanel();
                      });
                    }
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "%",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    if (inputPanel.isNotEmpty) {
                      setState(() {
                        operationPanel.writeAll([inputPanel, " * "]);
                        expression.writeAll([inputPanel, "*"]);
                        clearInputPanel();
                      });
                    }
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "*",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 3rd row
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      inputPanel.write(1);
                    });
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "1",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      inputPanel.write(2);
                    });
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      inputPanel.write(3);
                    });
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    if (inputPanel.isNotEmpty) {
                      setState(() {
                        operationPanel.writeAll([inputPanel, " - "]);
                        expression.writeAll([inputPanel, "-"]);
                        clearInputPanel();
                      });
                    }
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "-",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 4th row
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      inputPanel.write(4);
                    });
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "4",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      inputPanel.write(5);
                    });
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "5",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      inputPanel.write(6);
                    });
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "6",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    if (inputPanel.isNotEmpty) {
                      setState(() {
                        operationPanel.writeAll([inputPanel, " + "]);
                        expression.writeAll([inputPanel, "+"]);
                        clearInputPanel();
                      });
                    }
                  },
                  child: Container(
                    height: buttonHeight,
                    color: buttonColor,
                    child: Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 5th & 6th row
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Column(
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                inputPanel.write(7);
                              });
                            },
                            child: Container(
                              height: buttonHeight,
                              color: buttonColor,
                              child: Center(
                                child: Text(
                                  "7",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: buttonTextSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                inputPanel.write(8);
                              });
                            },
                            child: Container(
                              height: buttonHeight,
                              color: buttonColor,
                              child: Center(
                                child: Text(
                                  "8",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: buttonTextSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                inputPanel.write(9);
                              });
                            },
                            child: Container(
                              height: buttonHeight,
                              color: buttonColor,
                              child: Center(
                                child: Text(
                                  "9",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: buttonTextSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () {
                              if (inputPanel.isNotEmpty) {
                                setState(() {
                                  inputPanel.write(0);
                                });
                              }
                            },
                            child: Container(
                              height: buttonHeight,
                              color: buttonColor,
                              child: Center(
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: buttonTextSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () {
                              if (inputPanel.isNotEmpty) {
                                setState(() {
                                  inputPanel.write('00');
                                });
                              }
                            },
                            child: Container(
                              height: buttonHeight,
                              color: buttonColor,
                              child: Center(
                                child: Text(
                                  "00",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: buttonTextSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: GestureDetector(
                            onTap: () {
                              if (!fractionalPart) {
                                fractionalPart = true;
                                if (inputPanel.isEmpty) {
                                  inputPanel.write('0.');
                                } else {
                                  inputPanel.write('.');
                                }
                              }
                            },
                            child: Container(
                              height: buttonHeight,
                              color: buttonColor,
                              child: Center(
                                child: Text(
                                  ".",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: buttonTextSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: GestureDetector(
                  onTap: () {
                    if (inputPanel.isNotEmpty) {
                      setState(() {
                        operationPanel.write(inputPanel);
                        expression.writeAll([inputPanel, "\$"]);
                        clearInputPanel();
                        log(expression.toString());
                        inputPanel.write(CalculatorService.scientificCalculate(expression.toString()));
                      });
                    }
                  },
                  child: Container(
                    height: buttonHeight * 2,
                    color: equalButtonColor,
                    child: Center(
                      child: Text(
                        "=",
                        style: TextStyle(
                          color: textColor,
                          fontSize: buttonTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
