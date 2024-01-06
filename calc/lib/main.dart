import 'package:calc/themes/dark_theme.dart';
import 'package:calc/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

String symbolDisplayed = "";
String result = "";
String ans = "";
String pastdisplayed = "";
bool alarm = false;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(isDarkMode),
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: (isDarkMode ? ThemeMode.dark : ThemeMode.light),
    );
  }
}

class MyHomePage extends StatefulWidget {
  bool isDarkMode;
  MyHomePage(this.isDarkMode);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    dynamic size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Calculator",
            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.isDarkMode = !widget.isDarkMode;
                  });
                },
                icon: Icon(
                    (widget.isDarkMode) ? Icons.dark_mode : Icons.light_mode),
              )
            ],
          ),
          body: Container(
              color: Theme.of(context).colorScheme.background,
              child: Column(children: [
                //for displaying processes
                Expanded(
                  child: Stack(children: [
                    Positioned(
                      right: 0,
                      top: 1 / 9 * screenHeight,
                      child: Container(
                        child: pastdisplayed == "" && result == ""
                            ? Container(
                                height: 1 / 15 * screenHeight,
                                width: 6 / 7 * screenWidth,
                                child: FittedBox(
                                  child: Text(
                                    symbolDisplayed,
                                  ),
                                ),
                              )
                            : Container(
                                height: (1 / 5) * screenHeight,
                                width: 6 / 7 * screenWidth,
                                color: Colors.amber,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 1 / 15 * screenHeight,
                                      width: 6 / 7 * screenWidth,
                                      child: FittedBox(
                                        child: Text(
                                          pastdisplayed,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight / 150,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: screenWidth / 100),
                                      height: 1 / 10 * screenHeight,
                                      width: 2 / 3 * screenWidth,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Text(
                                          result,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ]),
                ),
                //for first part of buttons
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth / 30,
                      vertical: screenHeight / 100),
                  child: Container(
                      height: 3 / 5 * screenHeight,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [ac(), del(), num("*"), num("/")],
                            ),
                          ),
                          //for second part of buttons
                          Expanded(
                            flex: 5,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      //for number
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  num("9"),
                                                  num("8"),
                                                  num("7"),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  num("6"),
                                                  num("5"),
                                                  num("4"),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  num("3"),
                                                  num("2"),
                                                  num("1"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //for zero and dot
                                      Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [zero(), dot()],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                //for + , = and -
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        subtrator_symble(),
                                        adder(),
                                        equal(),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      )),
                )
              ]))),
    );
  }

  Expanded num(String symbols) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Color.fromARGB(255, 48, 49, 54),
            boxShadow: [
              BoxShadow(
                // Color.fromARGB(255, 48, 49, 54),
                blurRadius: 25,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              onTap: () {
                press(symbols);
              },
              child: Container(
                  child: Center(
                      child: Text(
                symbols,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(242, 41, 169, 255),
                ),
              ))),
            ),
          ),
        ),
      ),
    );
  }

  void press(String symbols) {
    if ((symbols == "+" ||
            symbols == "-" ||
            symbols == "/" ||
            symbols == "*") &&
        symbolDisplayed.isEmpty) {
      return;
    } else if (symbolDisplayed.length < 17) {
      if (result.isNotEmpty) {
        result = "";
        pastdisplayed = "";
      }
      return setState(() {
        if (symbolDisplayed.isNotEmpty) {
          var sympol = symbolDisplayed.substring(symbolDisplayed.length - 1);
          if ((sympol == "+" ||
                  sympol == "/" ||
                  sympol == "*" ||
                  sympol == "-") &&
              (symbols == "-" ||
                  symbols == "*" ||
                  symbols == "/" ||
                  symbols == "+")) {
            return;
          }
        }
        symbolDisplayed += symbols;
      });
    }
  }

  Expanded del() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Color.fromARGB(255, 48, 49, 54),
            boxShadow: [
              BoxShadow(
                // Color.fromARGB(255, 48, 49, 54),
                blurRadius: 25,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              onTap: () {
                setState(() {
                  if (symbolDisplayed.isEmpty) {
                    return;
                  }
                  symbolDisplayed =
                      symbolDisplayed.substring(0, symbolDisplayed.length - 1);
                });
              },
              child: Container(
                  child: const Center(
                      child: Text(
                "<<",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(242, 41, 169, 255),
                ),
              ))),
            ),
          ),
        ),
      ),
    );
  }

  Expanded equal() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Color.fromARGB(255, 48, 49, 54),
            boxShadow: [
              BoxShadow(
                // Color.fromARGB(255, 48, 49, 54),
                blurRadius: 25,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              onTap: () {
                if (symbolDisplayed == "") {
                  return;
                }
                Expression exp = Parser().parse(symbolDisplayed);
                double doubleResult =
                    exp.evaluate(EvaluationType.REAL, ContextModel());
                result.isEmpty
                    ? setState(() {
                        result = " = $doubleResult";
                        pastdisplayed = symbolDisplayed;
                        symbolDisplayed = "";
                      })
                    : alarm = true;
              },
              child: Container(
                  child: const Center(
                      child: Text(
                "=",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(242, 41, 169, 255),
                ),
              ))),
            ),
          ),
        ),
      ),
    );
  }

  Expanded adder() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Color.fromARGB(255, 48, 49, 54),
            boxShadow: [
              BoxShadow(
                // Color.fromARGB(255, 48, 49, 54),
                blurRadius: 25,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              onTap: () {
                press("+");
              },
              child: Container(
                  child: const Center(
                      child: Text(
                "+",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 92, 178)),
              ))),
            ),
          ),
        ),
      ),
    );
  }

  Expanded subtrator_symble() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Color.fromARGB(255, 48, 49, 54),
            boxShadow: [
              BoxShadow(
                // Color.fromARGB(255, 48, 49, 54),
                blurRadius: 25,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              onTap: () {
                press("-");
              },
              child: Container(
                  child: const Center(
                      child: Text(
                "-",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(251, 25, 144, 255),
                ),
              ))),
            ),
          ),
        ),
      ),
    );
  }

  Expanded dot() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Color.fromARGB(255, 48, 49, 54),
            boxShadow: [
              BoxShadow(
                // Color.fromARGB(255, 48, 49, 54),
                blurRadius: 25,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              onTap: () {
                press(".");
              },
              child: Container(
                  child: const Center(
                      child: Text(
                ".",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(242, 41, 169, 255),
                ),
              ))),
            ),
          ),
        ),
      ),
    );
  }

  Expanded zero() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Color.fromARGB(255, 48, 49, 54),
            boxShadow: [
              BoxShadow(
                // Color.fromARGB(255, 48, 49, 54),
                blurRadius: 25,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              onTap: () {
                press("0");
              },
              child: Container(
                  child: const Center(
                      child: Text(
                "0",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(242, 41, 169, 255),
                ),
              ))),
            ),
          ),
        ),
      ),
    );
  }

  Expanded ac() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Color.fromARGB(255, 48, 49, 54),
            boxShadow: [
              BoxShadow(
                // Color.fromARGB(255, 48, 49, 54),
                blurRadius: 25,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              onTap: () {
                setState(() {
                  symbolDisplayed = "";
                  // ans = result;
                  result = "";
                });
              },
              child: Container(
                  child: const Center(
                      child: Text(
                "Ac",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(242, 41, 169, 255),
                ),
              ))),
            ),
          ),
        ),
      ),
    );
  }
}
