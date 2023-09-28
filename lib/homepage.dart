import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String input = '';
  String output = '';
  bool hideInput = false;
  double outputSize = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: _getAppBar(),
      body: _getMainBody(),
    );
  }

  // APP BAR
  PreferredSizeWidget _getAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        'C a l c u l a t o r ',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  // MAIN BODY
  Widget _getMainBody() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 15),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.deepPurple[200],
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        hideInput ? '' : input,
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 35, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Text(
                        output,
                        style: TextStyle(
                            fontSize: outputSize, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepPurple,
                    Colors.deepPurpleAccent,
                    Colors.deepPurple,
                    Colors.deepPurpleAccent,
                    Colors.deepPurple,
                    Colors.deepPurpleAccent,
                    Colors.deepPurple,
                    Colors.deepPurpleAccent,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _getRow('ac', 'ce', '%', '/'),
                  _getRow('7', '8', '9', '*'),
                  _getRow('4', '5', '6', '-'),
                  _getRow('1', '2', '3', '+'),
                  _getRow('00', '0', '.', '='),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onButtonClick(value) {
    if (value == 'ac') {
      input = '';
      output = '';
    } else if (value == 'ce') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      Parser parser = Parser();
      Expression expression = parser.parse(input);
      ContextModel contextModel = ContextModel();
      double eval = expression.evaluate(EvaluationType.REAL, contextModel);
      output = eval.toString();
      if (output.endsWith('.0')) {
        output = output.substring(0, output.length - 2);
      }
      input = output;
      hideInput = true;
      outputSize = 50;
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 30;
    }
    setState(() {});
  }

  // GET Row oF items
  Widget _getRow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            onButtonClick(text1);
          },
          child: CustomButton(
            color: _getActionColor(text1),
            textcolor: _getTextColor(text1),
            buttonText: text1,
          ),
        ),
        InkWell(
          onTap: () {
            onButtonClick(text2);
          },
          child: CustomButton(
            color: _getActionColor(text2),
            textcolor: _getTextColor(text2),
            buttonText: text2,
          ),
        ),
        InkWell(
          onTap: () {
            onButtonClick(text3);
          },
          child: CustomButton(
            color: _getActionColor(text3),
            textcolor: _getTextColor(text3),
            buttonText: text3,
          ),
        ),
        InkWell(
          onTap: () {
            onButtonClick(text4);
          },
          child: CustomButton(
            color: _getActionColor(text4),
            textcolor: _getTextColor(text4),
            buttonText: text4,
          ),
        )
      ],
    );
  }

  bool isOparator(String content) {
    List<String> oparator = ['ac', 'ce', '%', '/', '*', '-', '+', '='];
    for (String item in oparator) {
      if (item == content) return true;
    }
    return false;
  }

  Color _getActionColor(String content) {
    if (isOparator(content)) return Colors.white24;
    return Colors.white12;
  }

  Color _getTextColor(String content) {
    if (isOparator(content)) return Colors.black;
    return Colors.white;
  }
}
