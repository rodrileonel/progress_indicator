# Progress Indicator

CircularProgress

## Features  
  
 - circular progress indicator.
 - bar progress indicator.

## Usage

    import 'package:progress_indicator/progress_indicator.dart';

### CircularProgressIndicator

    CircularProgress(
        percentage: 90.0,
        color: Colors.amber,
        backColor: Colors.grey,
        gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
        showPercentage: true,
        textStyle:TextStyle(color: Colors.orange,fontSize: 70),
        stroke: 20,
        round: true,
    ),

### BarProgressIndicator

    BarProgress(
        percentage: 30.0,
        backColor: Colors.grey,
        gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
        showPercentage: true,
        textStyle:TextStyle(color: Colors.orange,fontSize: 70),
        stroke: 40,
        round: true,
    ),
    