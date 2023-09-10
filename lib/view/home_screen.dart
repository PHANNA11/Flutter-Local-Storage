import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_storage/database/product_connection.dart';
import 'package:flutter_storage/model/product_model.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({super.key});

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  List<ProductModel> listProduct = [];
  getDataProduct() async {
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
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: listProduct.length,
        itemBuilder: (context, index) =>
            buildProductCard(pro: listProduct[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ProductDatabase().insertProduct(ProductModel(
              id: DateTime.now().microsecondsSinceEpoch,
              name: 'Macbook pro M1 16',
              price: 2369.00));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildProductCard({ProductModel? pro}) => Padding(
        padding: const EdgeInsets.all(8.0),
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
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://www.notebookcheck.net/fileadmin/_processed_/c/3/csm_AKA8518_984be0479c.jpg'))),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      pro!.name.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${pro.price}',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
