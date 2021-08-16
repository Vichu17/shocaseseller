import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/productsProvider.dart';

class ProductDetailPage extends StatelessWidget {
  // const ProductDetailPage({Key? key}) : super(key: key);
  static const routeName = '/productdetail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0e2149),
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\₹${loadedProduct.price}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
                child: Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            )),
          ],
        ),
      ),
    );
  }
}
