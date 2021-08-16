import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/auth.dart';
import 'package:shocase/Providers/cart.dart';
import 'package:shocase/Providers/product.dart';
import 'package:shocase/assets.dart';
import 'package:shocase/subpages/productDetailPage.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final productitem = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailPage.routeName,
              arguments: productitem.id,
            );
          },
          child: Image.network(
            productitem.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (context, productitem, _) => IconButton(
              icon: Icon(
                  productitem.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.blue),
              onPressed: () {
                productitem.toggleFavoriteStatus(authData.token.toString(),authData.userId.toString());
              },
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            productitem.title,
            style: TextStyle(color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.blue,
            ),
            onPressed: () {
              cart.addItem(
                  productitem.id, productitem.price, productitem.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Selected Item Added to Your Cart',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(label: 'UNDO',onPressed: (){
                    cart.removeSingleItem(productitem.id);
                  },),
                ),
              );
            },
          ),
          subtitle: Text(
            '\₹ ${productitem.price}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}
