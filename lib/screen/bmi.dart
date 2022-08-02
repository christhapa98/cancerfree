import 'package:cancer_free/widgets/buttonsWidgets/button_widget.dart';
import 'package:flutter/material.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({Key? key}) : super(key: key);

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  int age = 17;
  int weight = 50;

  int height = 180;
  double maxHeight = 220;
  double minHeight = 120;

  ageIncrement() {
    setState(() {
      age++;
    });
  }

  ageDecrement() {
    setState(() {
      age--;
    });
  }

  weightIncrement() {
    setState(() {
      weight++;
    });
  }

  weightDecrement() {
    setState(() {
      weight--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      AppBar(
          title: const Text("BMI "),
          elevation: 0,
          backgroundColor: Colors.transparent),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: const Center(child:  Text('MALE')))),
        Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(child: Text('FEMALE'))))
      ]),
      Expanded(
          flex: 1,
          child: Container(
              margin: const EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height * 0.25,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('HEIGHT'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("$height"),
                    ),
                    Slider(
                        value: height.toDouble(),
                        min: minHeight,
                        max: maxHeight,
                        activeColor: Colors.orangeAccent,
                        inactiveColor: Colors.black,
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        },
                        semanticFormatterCallback: (double newValue) {
                          return '$newValue.round()';
                        })
                  ]))),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('WEIGHT'),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("$weight")),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                                onTap: weightDecrement,
                                child: Container(
                                    height: 40.0,
                                    width: 40.0,
                                    margin: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.orangeAccent),
                                    child: const Center(child: Text("-")))),
                            Container(
                                height: 40.0,
                                width: 40.0,
                                margin: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.orangeAccent),
                                child: InkWell(
                                    onTap: weightIncrement,
                                    child: const Center(child: Text("+"))))
                          ])
                    ]))),
        Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('AGE'),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("$age")),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                                onTap: ageDecrement,
                                child: Container(
                                    height: 40.0,
                                    width: 40.0,
                                    margin: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.orangeAccent),
                                    child: const Center(child: Text("-")))),
                            Container(
                                height: 40.0,
                                width: 40.0,
                                margin: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.orangeAccent),
                                child: InkWell(
                                    onTap: ageIncrement,
                                    child: const Center(child: Text("+"))))
                          ])
                    ])))
      ]),
      ButtonWidget(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResultPage(
                        height: height,
                        weight: weight,
                      ))),
          title: 'CALCULATE BMI')
    ]));
  }
}

class ResultPage extends StatelessWidget {
  final int height;
  final int weight;

  // ignore: use_key_in_widget_constructors
  const ResultPage({required this.height, required this.weight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        backgroundColor: Colors.transparent,
      ),
      body: Result(height, weight),
    );
  }
}

class Result extends StatefulWidget {
  final int height;
  final int weight;

  // ignore: use_key_in_widget_constructors
  const Result(this.height, this.weight);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Expanded(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(headline),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '${bmiResult(widget.height, widget.weight)}',
                      ),
                    ),
                    Column(children: const <Widget>[
                      Text('Normal BMI range:'),
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("18.5 - 25 kg/m"))
                    ]),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(comment))
                  ]))),
      InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
              margin: const EdgeInsets.only(top: 10.0),
              height: MediaQuery.of(context).size.height * 0.1,
              child: const Center(child: Text('RE-CALCULATE'))))
    ]));
  }
}

var comment = '';
var headline = '';
bmiResult(h, w) {
  double bmi = (w / (h * h)) * 10000;

  if (bmi < 18.5) {
    comment = "You are under Weight";
    headline = "UNDERWEIGHT";
  } else if (bmi >= 18.5 && bmi < 25) {
    comment = "You are at a healthy weight.";
    headline = "NORMAL";
  } else if (bmi > 25 && bmi <= 29.99) {
    comment = "You are at overweight.";
    headline = "OVERWEIGHT";
  } else {
    comment = "You are obese.";
    headline = "OBESE";
  }

  return bmi.round();
}
