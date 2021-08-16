import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/productsProvider.dart';
import 'package:shocase/Widgets/userProductItem.dart';
import 'package:shocase/subpages/editProductPage.dart';

class UserProductPage extends StatelessWidget {
  // const UserProductPage({Key? key}) : super(key: key);
  static const routName = '/user-product';

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .addFetchSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductPage.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProduct(context),
                    child: Consumer<ProductsProvider>(
                      builder:(context,productData,_)=> Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productData.items.length,
                          itemBuilder: (_, i) => Column(
                            children: [
                              UserProductItem(
                                productData.items[i].id,
                                productData.items[i].title,
                                productData.items[i].imageUrl,
                              ),
                              Divider()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
