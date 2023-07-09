import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentCalculationSTR = "0";
  num currentCalculation = 0; //I am using nums as I need to switch back and
  //forth between decimals and integers.
  num prevCalc = 0; //Same thing here
  bool calcState =
      false; // This determines the calculation state, I forget the function
  bool buttonPressed = false;
  String clear = "AC";
  String prevFunction = "";

  void _doSomething() {}

  void _ac() {
    //Adjusts the AC button to clear and vice versa as inputs are entered
    setState(() {
      if (clear == "C") {
        prevCalc = 0;
        currentCalculationSTR = "0";
        currentCalculation = 0;
        clear = "AC";
      } else {
        prevCalc = 0;
        currentCalculationSTR = "0";
        currentCalculation = 0;
      }
    });
  }

  void _addNumber(String num) {
    // adds a number to the current value
    setState(() {
      buttonPressed = false;
      clear = "C";
      if (calcState) {
        currentCalculationSTR = "";
        currentCalculationSTR += num;
        try {
          currentCalculation = int.parse(currentCalculationSTR);
        } catch (e) {
          currentCalculation = double.parse(currentCalculationSTR);
        }
        calcState = false;
      } else {
        if (currentCalculationSTR == "0") {
          currentCalculationSTR = "";
        }
        currentCalculationSTR += num;
        try {
          currentCalculation = int.parse(currentCalculationSTR);
        } catch (e) {
          currentCalculation = double.parse(currentCalculationSTR);
        }
      }
    });
  }

  void _addDecimal() {
    //adds a decimal to the display but not the actual value yet.
    setState(() {
      currentCalculationSTR += ".";
    });
  }

  void _performCalc(String desiredFunction) {
    /*An issue with calculation occurs when you use the app as the it often
    *confuses the previous and current calculations when you enter a value 
    *and press button it performs a calculation when you do not want to
    *perform one.*/
    setState(() {
      if (desiredFunction == "+") {
        //addition function that adds the previous to the current calc
        buttonPressed = true;
        if (prevCalc == 0) {
          prevCalc = currentCalculation;
        } else {
          prevCalc += currentCalculation;
          currentCalculationSTR = prevCalc.toString();
          currentCalculation = prevCalc;
        }
        calcState = true;
        prevFunction = "+";
      } else if (desiredFunction == "-") {
        //subtraction function that adds the previous to the current calc
        buttonPressed = true;
        if (prevCalc == 0) {
          prevCalc = currentCalculation;
        } else {
          prevCalc -= currentCalculation;
          currentCalculationSTR = prevCalc.toString();
          currentCalculation = prevCalc;
        }
        calcState = true;
        prevFunction = "-";
      } else if (desiredFunction == "x") {
        //multiplication function that multiplies the previous to the current calc
        buttonPressed = true;
        if (prevCalc == 0) {
          prevCalc = currentCalculation;
        } else {
          if (currentCalculation == 0 && prevCalc != 0) {
            return;
          } else {
            prevCalc *= currentCalculation;
            currentCalculationSTR = prevCalc.toString();
            currentCalculation = prevCalc;
          }
        }
        calcState = true;
        prevFunction = "x";
      } else if (desiredFunction == "÷") {
        //division isn't handled properly needs to be fixed
        buttonPressed = true;
        if (prevCalc == 0) {
          prevCalc = currentCalculation;
        } else {
          if (currentCalculation == 0) {
            currentCalculationSTR = "Error";
          } else {
            prevCalc /= currentCalculation;
            currentCalculationSTR = prevCalc.toString();
            currentCalculation = prevCalc;
          }
        }
        calcState = true;
        prevFunction = "÷";
      } else if (desiredFunction == "=") {
        //equals to fucntion this does the does function that was previously
        //done
        buttonPressed = true; // useless right now might need it to know if a
        //function was previously pressed
        if (prevFunction == "+") {
          prevCalc += currentCalculation;
          currentCalculationSTR = prevCalc.toString();
          currentCalculation = 0;
          calcState = true;
          prevFunction = "+";
        } else if (prevFunction == "-") {
          prevCalc -= currentCalculation;
          currentCalculationSTR = prevCalc.toString();
          currentCalculation = 0;
          calcState = true;
          prevFunction = "-";
        } else if (prevFunction == "x") {
          prevCalc *= currentCalculation;
          currentCalculationSTR = prevCalc.toString();
          currentCalculation = 0;
          calcState = true;
          prevFunction = "x";
        } else if (prevFunction == "÷") {
          if (currentCalculation == 0) {
            currentCalculationSTR = "Error";
          } else {
            prevCalc /= currentCalculation;
            currentCalculationSTR = prevCalc.toString();
            currentCalculation = 0;
            calcState = true;
            prevFunction = "÷";
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height; //screen height
    final desiredTop = screenHeight * 0.27; //70 percent of the screen
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text(
            'Calculator',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              //position the top container above the bottom one so they
              //align properly
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                  //top container to house results display
                  width: MediaQuery.of(context).size.width,
                  height: screenHeight * 0.3,
                  color: const Color.fromARGB(255, 35, 37, 45),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 30),
                        child: Text(
                          //need to change the text to be responsive so that
                          //will probablt include removing the const in the
                          //align so as to be able to update the result
                          //varible for the text.

                          //Add one or two more text bars to represent the
                          //previous calculation that was done, this may need
                          //some animation work.
                          currentCalculationSTR,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ))),
            ),
            Positioned(
                //fix the height and positions so as to not cause overflows,
                //that is stop using manual inputs for the positions and try to
                // change it to relative positions.
                left: 0,
                right: 0,
                top: desiredTop, //250 works for this,
                child: Container(
                  //Lower contianer to house calculator buttons
                  //use elevated buttons to make them more noticeable
                  //try to play around to get the make the buttons respective
                  //of each other and the container
                  width: MediaQuery.of(context).size.width,
                  height: screenHeight / 0.7,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 42, 45, 53),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      //row 1 begin
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: _ac,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text(
                                  clear,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 110, 234, 188),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                //add function to +/-
                                onPressed: _doSomething,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '+/-',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 110, 234, 188),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                //add function to %
                                onPressed: _doSomething,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '%',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 110, 234, 188),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _performCalc("÷");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '÷',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 190, 110, 110),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //row 1 end

                      //row 2 begin
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addNumber("7");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '7',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addNumber("8");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '8',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addNumber("9");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '9',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _performCalc("x");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  'x',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 190, 110, 110),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //row 2 end

                      //row 3 begin
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addNumber("4");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '4',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addNumber("5");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '5',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addNumber("6");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '6',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _performCalc("-");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '-',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 190, 110, 110),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //row 3 end

                      //row 4 begin
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addNumber("1");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '1',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addNumber("2");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '2',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addNumber("3");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '3',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _performCalc("+");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '+',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 190, 110, 110),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //row 4 end

                      //row 5 begin
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              //add function to the undo
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: _doSomething,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Icon(
                                  Icons.undo,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addNumber("0");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '0',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _addDecimal();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '.',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 40),
                              child: ElevatedButton(
                                onPressed: () {
                                  _performCalc("=");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 40, 43, 51),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        16), // Adjust border radius as needed
                                  ),
                                  minimumSize: const Size(60, 60),
                                  padding: EdgeInsets.zero,
                                ),
                                child: const Text(
                                  '=',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 190, 110, 110),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //row 5 end
                    ],
                  ),
                ))
          ],
        ));
  }
}
