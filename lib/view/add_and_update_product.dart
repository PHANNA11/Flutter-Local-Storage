import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_storage/constant/appsize.dart';
import 'package:flutter_storage/widget/custom_textfield.dart';

import '../database/product_connection.dart';
import '../model/product_model.dart';

class ProductForm extends StatefulWidget {
  ProductForm({super.key, this.product});
  ProductModel? product;

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  TextEditingController pNameController = TextEditingController();
  TextEditingController pPriceController = TextEditingController();
  void clearForm() {
    setState(() {
      pNameController.text = "";
      pPriceController.text = "";
    });
  }

  void initUpdateForm() {
    setState(() {
      pNameController.text = widget.product!.name;
      pPriceController.text = widget.product!.price.toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.product != null) {
      initUpdateForm();
    } else {
      clearForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.product == null ? 'Add Product' : "Edit Product"),
      ),
      body: Form(
        child: Column(
          children: [
            ShopWidget().textfieldWidget(
              hintText: 'Enter product name',
              controller: pNameController,
            ),
            ShopWidget().textfieldWidget(
                keyboardType: TextInputType.number,
                controller: pPriceController,
                hintText: 'Enter product Price\$'),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            if (widget.product == null) {
              if (pNameController.text.isNotEmpty ||
                  pPriceController.text.isNotEmpty) {
                await ProductDatabase()
                    .insertProduct(ProductModel(
                        id: DateTime.now().microsecondsSinceEpoch,
                        name: pNameController.text,
                        price: double.parse(pPriceController.text)))
                    .then((value) {
                  Navigator.pop(context);
                });
              }
            } else {
              if (pNameController.text.isNotEmpty ||
                  pPriceController.text.isNotEmpty) {
                await ProductDatabase()
                    .updateProduct(
                        pro: ProductModel(
                            id: widget.product!.id,
                            name: pNameController.text,
                            price: double.parse(pPriceController.text)))
                    .then((value) {
                  Navigator.pop(context);
                });
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize().s10),
              color: Theme.of(context).primaryColor,
            ),
            height: AppSize().s60,
            child: const Center(
              child: Text(
                'Save',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
