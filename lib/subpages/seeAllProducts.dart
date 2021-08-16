import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/cart.dart';
import 'package:shocase/Providers/product.dart';
import 'package:shocase/Providers/productsProvider.dart';
import 'package:shocase/Widgets/badge.dart';
import 'package:shocase/Widgets/productGrid.dart';
import 'package:shocase/Widgets/productItem.dart';
import 'package:shocase/Widgets/productOverviewPage.dart';
import 'package:shocase/Widgets/side_drawer.dart';
import 'package:shocase/subpages/cartPage.dart';

enum FilterOption {
  Favorites,
  All,
}

class SeeAllProducts extends StatefulWidget {
  // const SeeAllProducts({Key? key}) : super(key: key);
  static String routeName = '/seeallproduct';

  @override
  _SeeAllProductsState createState() => _SeeAllProductsState();
}

class _SeeAllProductsState extends State<SeeAllProducts> {
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
    // final productContainer = Provider.of<ProductsProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0e2149),
        title: Text('View All Items'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.Favorites) {
                  _showOnlyFavorites = true;
                  // productContainer.showFavoritesOnly();
                } else {
                  _showOnlyFavorites = false;
                  // productContainer.showAll();
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Your Favorites'),
                value: FilterOption.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOption.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
              child: ch!,
              value: cartData.itemCount.toString(),
              color: Colors.blue,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
          ),
        ],
      ),
      // drawer: SideDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
