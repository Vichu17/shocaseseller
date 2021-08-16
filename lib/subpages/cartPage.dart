import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/cart.dart' show Cart;
import 'package:shocase/Providers/orders.dart';
import 'package:shocase/Widgets/cartItem.dart';

import 'ordersPage.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart';

  // int int_page =2;
  // GlobalKey _bottomNavigationBar = GlobalKey();
  // const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0e2149),
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Chip(
                    label: Text('\₹${cart.totalAmount.toStringAsFixed(2)}'),
                  ),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, i) => CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.cart.totalAmount <=0 || _isLoading) ? null :() async{
        setState(() {
          _isLoading = true;
        });
        // Navigator.of(context).pushReplacementNamed(OrdersPage.routeName);
        await Provider.of<Orders>(context, listen: false).addOrder(
          widget.cart.items.values.toList(),
          widget.cart.totalAmount,
        );
        setState(() {
          _isLoading = false;
        });
        widget.cart.clear();
      },
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
    );
  }
}
