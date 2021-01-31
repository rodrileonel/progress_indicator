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
          child: Column(
            children: [
              Container(
                width: 150,
                height: 150,
                child: CircularProgress(
                  percentage: 90.0,
                  color: Colors.amber,
                  backColor: Colors.grey,
                  gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
                  showPercentage: true,
                  textStyle:TextStyle(color: Colors.orange,fontSize: 20),
                  stroke: 20,
                  round: true,
                ),
              ),
              Container(
                width: 150,
                height: 150,
                child: BarProgress(
                  percentage: 70.0,
                  backColor: Colors.grey,
                  gradient: LinearGradient(colors: [Colors.orange, Colors.red]),
                  showPercentage: true,
                  textStyle:TextStyle(color: Colors.orange,fontSize: 20),
                  stroke: 40,
                  round: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}