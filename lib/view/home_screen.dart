import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_storage/database/product_connection.dart';
import 'package:flutter_storage/model/product_model.dart';
import 'package:flutter_storage/view/add_and_update_product.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({super.key});

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  List<ProductModel> listProduct = [];
  Future<void> getDataProduct() async {
    // await Future.delayed(const Duration(seconds: 2));
    await ProductDatabase().getProducts().then((value) {
      setState(() {
        listProduct = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CupertinoSearchTextField(
          onChanged: (value) async {
            await ProductDatabase()
                .searchProducts(search: value)
                .then((result) {
              setState(() {
                listProduct = result;
              });
            });
          },
        ),
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        strokeWidth: 4,
        onRefresh: getDataProduct,
        child: ListView.builder(
          itemCount: listProduct.length,
          itemBuilder: (context, index) =>
              buildProductCard(pro: listProduct[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProductForm()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildProductCard({ProductModel? pro}) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          CircleAvatar(
            maxRadius: 40,
            child: SlidableAction(
              borderRadius: BorderRadius.circular(50),
              onPressed: (value) async {
                await ProductDatabase()
                    .deleteProduct(productId: pro!.id)
                    .then((value) => getDataProduct());
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              maxRadius: 40,
              child: SlidableAction(
                borderRadius: BorderRadius.circular(50),
                onPressed: (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductForm(product: pro),
                      ));
                },
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icons.edit_note,
              ),
            ),
          )
        ]),
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: FileImage(File(pro!.image)))),
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pro.name.toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${pro.price}',
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),
                      Text(
                        '\$${pro.description}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ));
}
