import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Timer"),
            ),
            body: Center(
              child: MyHomePage(),
            )));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;

  //倒计时数值
  var _enable = true;
  var _time = 0;

  //倒计时方法
  void startCountdown(int count) {
    if (!_enable) return;
    setState(() {
      _enable = false;
      _time = count;
    });
    //倒计时时间
    _timer = Timer.periodic(Duration(seconds: 1), (Timer it) {
      print(it.tick);
      setState(() {
        if (it.tick == count) {
          _enable = true;
          it.cancel();
        }
        _time = count - it.tick;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // ignore: unnecessary_statements
            _enable ? startCountdown(10) : null;
          },
          child: Text(
            _time == 0 ? "获取验证码" : "${_time}s后重新获取",
            style: TextStyle(fontSize: 25, color: Colors.blueAccent),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _time = 0;
                      _enable = true;
                      if (_timer != null && _timer?.isActive==true) {
                        _timer?.cancel();
                      }
                    });
                  },
                  child: Text(
                    "结束",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }
}
