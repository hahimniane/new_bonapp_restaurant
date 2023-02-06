import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'From_Sulaiman/screens/home_screen.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';



class BarCharExample extends StatelessWidget {


  BarCharExample();
  final List<double> sales = [
    25000.0,
    30000.0,
    28000.0,
    35000.0,
    32000.0,
  ];

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: List.generate(
          sales.length,
              (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                fromY: sales[i],
                color: Colors.blue,
                width: 16,
                toY: sales[i+5],
              ),
            ],
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
      ),
    );
  }
}




