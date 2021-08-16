import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/product.dart';
import 'package:shocase/Providers/productsProvider.dart';
import 'package:shocase/Widgets/productItem.dart';

class ProductsOverviewPage extends StatefulWidget {

  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<ProductsProvider>(context).addFetchSetProducts();
    // });
    // Provider.of<ProductsProvider>(context).addFetchSetProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ProductsProvider>(context).addFetchSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final products = productData.items;
    return Scaffold(
      body: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        // itemCount: 4,
        itemCount: products.length>4 ? 4 : products.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: products[i],
          // create: (context) => products[i],
          child: ProductItem(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20,
          crossAxisCount: 2,
          childAspectRatio: 2 / 2,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
