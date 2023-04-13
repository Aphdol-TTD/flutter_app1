import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends  StatelessWidget {
@override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: SpinKitRipple (
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}