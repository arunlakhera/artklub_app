import 'package:flutter/material.dart';

class AppWidgets{

  // Logo Widget
  getLogoWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow.shade100,
                  spreadRadius: 40,
                  blurRadius: 40,
                  offset: Offset(10, 10), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/artklub_logo.png',
              width: 100,
              height: 100,

            ),
          ),
          Text(
            'Give Wings to',
            style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.5),
                shadows: [
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 1.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ]
            ),
          ),
          Text(
            'Your Imagination',
            style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                color: Colors.black.withOpacity(0.5),
                shadows: [
                  Shadow(
                    offset: Offset(0.0, 0.0),
                    blurRadius: 1.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }
}