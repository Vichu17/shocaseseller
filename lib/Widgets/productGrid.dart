import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/productsProvider.dart';
import 'package:shocase/Widgets/productItem.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;

  ProductsGrid(this.showFav);
  // const ProductsGrid({required Key key, required this.loadedProducts,}) : super(key: key);
  //
  // final List<Product> loadedProducts;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final products = showFav ? productData.favoriteItem: productData.items;
    return GridView.builder(
      // physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        // create: (context) => products[i],
        child: ProductItem(
          // products[i].id,
          // products[i].title,
          // products[i].imageUrl,
          // products[i].price.toString(),
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 20,
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        mainAxisSpacing: 20,
      ),
    );
  }
}
