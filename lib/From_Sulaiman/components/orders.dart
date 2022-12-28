import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../components/delivered_orders.dart';
import '../components/pending_orders.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    final _kTapPages = <Widget>[
      PenOrders(),
      const DelOrders(),
    ];
    final _kTabs = <Tab>[
      Tab(
        icon: const Icon(Icons.timelapse),
        text: S.of(context).pendingOrderString,
      ),
      Tab(
        icon: Icon(Icons.car_rental),
        text: S.of(context).deliveredOrderString,
      )
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: TabBar(
          indicatorColor: Colors.deepOrangeAccent,
          labelColor: Colors.deepOrangeAccent,
          tabs: _kTabs,
        ),
        body: Center(
          child: TabBarView(
            children: _kTapPages,
          ),
        ),
      ),
    );
  }
}
