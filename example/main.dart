import 'package:flutter/material.dart';
import 'package:progress_indicator/progress_indicator.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Indicator App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Progress indicator'),
        ),
        body: Center(
          child: Container(
            width: 150,
            height: 150,
            child: CircularProgress(
              percentage: 50,
              color: Colors.amber,
              backColor: Colors.blueGrey,
            ),
          ),
        ),
      ),
    );
  }
}