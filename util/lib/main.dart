import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Interest Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;
  int _amount = 0;
  double _interestRate = 0;
  int daysPartOfDuration = 0;
  int monthsPartOfDuration = 0;
  int yearsPartOfDuration = 0;
  DateTime _fromDate = DateTime.now();
  TextEditingController fromDateControl = TextEditingController();
  TextEditingController toDateControl = TextEditingController();
  DateTime _toDate = DateTime.now();
  String duration = 'days';
  String interest = '0';
  String total = '9';

  String lblduration = '';
  String lblinterest = '';
  String lbltotal = '';
  String lblamount = '';

  String lblDurationPerMonth = '';
  String lblInterestPerMonth = '';
  String lblTotalPerMonth = '';
  String lblAmountPerMonth = '';

  late TabController _tabController;

  Future<DateTime?> _selectDate(DateTime? dt) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: (dt != null ? dt : DateTime.now()),
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    // if (newDate != null) {
    //   setState(() {
    //     newDate.toString();
    //   });
    // }
    return newDate;
  }

  void _setFromDate() async {
    DateTime? dt = await _selectDate(_fromDate);
    if (dt != null) {
      _fromDate = dt;
      fromDateControl.text = _fromDate.toString();
    }
  }

  void _setToDate() async {
    DateTime? dt = await _selectDate(_toDate);
    if (dt != null) {
      _toDate = dt;
      toDateControl.text = _toDate.toString();
    }
  }

  void calculate() {
//  tday = parseInt(document.getElementById("tday").value);
//  tmonth = parseInt(document.getElementById("tmonth").value);
//  tyear = parseInt(document.getElementById("tyear").value);

//  fday = parseInt(document.getElementById("fday").value);
//  fmonth = parseInt(document.getElementById("fmonth").value);
//  fyear = parseInt(document.getElementById("fyear").value);

//   interestRate = parseFloat(document.getElementById("interest").value);
//   amount = parseInt(document.getElementById("amount").value);
log('callculate time');
    if (_toDate.year < _fromDate.year) {
      // alert
      // document.getElementById("message").innerHTML="Date not Valid";

      return;
    }
    log('callculate time');
    calculateTimeDuaration();
    log('clculate interest');
    var interest = calculateInterest();

    var total = _amount + interest;
    lblduration =
        (yearsPartOfDuration != 0 ? "$yearsPartOfDuration Years " : '') +
            (monthsPartOfDuration != 0 ? "$monthsPartOfDuration Months " : '') +
            (daysPartOfDuration != 0 ? "$daysPartOfDuration Days " : '');

    lblamount = _amount.toString();
    lbltotal = total.toString();
    lblinterest = interest.toString();
  }

  void calculateTimeDuaration() {
    var monthsOfToDate = _toDate.month;
    var yearsofToDate = _toDate.year;

    if (_toDate.day < _fromDate.day) {
      daysPartOfDuration = (_toDate.day + 30) - _fromDate.day;
      monthsOfToDate--;
    } else {
      daysPartOfDuration = _toDate.day - _fromDate.day;
    }

    if (monthsOfToDate < _fromDate.month) {
      monthsPartOfDuration = (monthsOfToDate + 12) - _fromDate.month;
      yearsofToDate--;
    } else {
      monthsPartOfDuration = monthsOfToDate - _fromDate.month;
    }

    yearsPartOfDuration = yearsofToDate - _fromDate.year;
  }

  double calculateInterest() {
    var rPerAmt = (_amount / 100) * (_interestRate / 30);

    return ((yearsPartOfDuration * 12 * 30) +
            (monthsPartOfDuration * 30) +
            daysPartOfDuration) *
        rPerAmt;
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.calculate_outlined),
            ),
            Tab(icon: Icon(Icons.sticky_note_2)),
            Tab(
              icon: Icon(Icons.brightness_5_sharp),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                maxLength: 20,
                onTap: _setFromDate,
                controller: fromDateControl,
                decoration: InputDecoration(
                  labelText: 'From Date',
                  labelStyle: TextStyle(
                    color: Color(0xFF6200EE),
                  ),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.check_circle,
                  ),
                ),
              ),
              TextFormField(
                controller: toDateControl,
                maxLength: 20,
                onTap: _setToDate,
                decoration: InputDecoration(
                  labelText: 'To Date',
                  labelStyle: TextStyle(
                    color: Color(0xFF6200EE),
                  ),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.check_circle,
                  ),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  child: TextFormField(
                    initialValue: '',
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(
                          color: Color(0xFF6200EE),
                        ),
                        suffixIcon: Icon(
                          Icons.check_circle,
                        ),
                        border: OutlineInputBorder()),
                   onChanged: (value) => _amount = int.parse(value), 
                  ),
                ),
                Expanded(
                    child: TextFormField(
                  initialValue: '',
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  decoration: InputDecoration(
                      labelText: 'Rate',
                      labelStyle: TextStyle(
                        color: Color(0xFF6200EE),
                      ),
                      suffixIcon: Icon(
                        Icons.check_circle,
                      ),
                      border: OutlineInputBorder()),
                  onChanged: (value) => _interestRate = double.parse(value), 
                ))
              ]),
              Row(
                children: <Widget>[
                  Expanded(child: Text("Time ")),
                  Expanded(
                    child: Text(lblduration),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text("Amount "),
                  ),
                  Expanded(
                    child: Text(lblamount),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text("Interest"),
                  ),
                  Expanded(
                    child: Text(lblinterest),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text("Total "),
                  ),
                  Expanded(
                    child: Text(lbltotal),
                  )
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: calculate,
                            child: Text('Calculate'),
                          )),
                    ),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // Respond to button press
                              },
                              icon: Icon(Icons.add, size: 18),
                              label: Text("Reset"),
                            )))
                  ])
            ],
          ),
          Center(
            child: Text("It's rainy here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
