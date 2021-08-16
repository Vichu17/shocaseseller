import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/orders.dart' show Orders;
import 'package:shocase/Widgets/orderItem.dart';
import 'package:shocase/Widgets/side_drawer.dart';

class OrdersPage extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future _orderFuture;

  Future _obtainOrderFuture(){
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
   _orderFuture = _obtainOrderFuture();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('YOUR ORDERS'),
        backgroundColor: Color(0xFF0e2149),
      ),
      // drawer: SideDrawer(),
      body: FutureBuilder(
          future:
             _orderFuture,
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An Error Occurred'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (context, orderData, child) => ListView.builder(
                    itemBuilder: (context, i) => OrderItem(orderData.orders[i]),
                    itemCount: orderData.orders.length,
                  ),
                );
              }
            }
          }),
    );
  }
}
