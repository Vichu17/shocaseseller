import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shocase/Providers/productsProvider.dart';
import 'package:shocase/subpages/editProductPage.dart';

class UserProductItem extends StatelessWidget {
  // const UserProductItem({Key? key}) : super(key: key);
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(
    this.id,
    this.title,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductPage.routeName, arguments: id);
              },
              icon: Icon(Icons.edit),
              color: Colors.blue,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                 scaffold .showSnackBar(
                    SnackBar(
                      content: Text('Deleting Failed'),
                    ),
                  );
                }
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
