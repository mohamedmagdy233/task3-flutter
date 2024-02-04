import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_1/models/products_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title ?? "--"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add product to cart logic
        },
        child: const Icon(Icons.add_shopping_cart),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(),
            items: (widget.product.images ?? [])
                .map(
                  (item) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(item),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          ListTile(
            title: Text("Brand: ${widget.product.brand}"),
            subtitle: Text("In Stock: ${widget.product.stock}"),
          ),
          ListTile(
            title: Text("Category: ${widget.product.category}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Price: \$${widget.product.price}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("${widget.product.rating}"),
                const Icon(Icons.star),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.description ?? "--"),
          ),
          ListTile(
            title: const Text("Discount:"),
            subtitle: widget.product.discountPercentage != null
                ? Text("${widget.product.discountPercentage}% off")
                : const Text("No discount available"),
          ),
          ListTile(
            title: const Text("Quantity:"),
            trailing: DropdownButton<int>(
              value: selectedQuantity,
              onChanged: (value) {
                setState(() {
                  selectedQuantity = value!;
                });
              },
              items: List.generate(10, (index) => index + 1)
                  .map<DropdownMenuItem<int>>(
                    (value) => DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
