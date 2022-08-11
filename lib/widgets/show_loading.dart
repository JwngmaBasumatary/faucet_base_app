import 'package:flutter/material.dart';

Widget showLoadingDialog() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Container(
          height: 200,
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SizedBox(
                height: 30,
              ),
              CircularProgressIndicator(
                color: Colors.red,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Please Wait...",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
