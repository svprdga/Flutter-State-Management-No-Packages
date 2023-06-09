import 'package:flutter/material.dart';
import 'package:flutter_state_management_no_packages/main.dart';
import 'package:flutter_state_management_no_packages/product_list/cart_button.dart';
import 'package:intl/intl.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = ProductContainer.of(context);
    final cartService = CartContainer.of(context);

    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product list'),
        actions: const [
          CartButton(),
        ],
      ),
      body: ListenableBuilder(
        listenable: cartService,
        builder: (context, child) => ListView.separated(
          itemBuilder: (context, index) {
            final product = productService.products[index];
            final isAlreadyInCart = cartService.products.contains(product);

            return ListTile(
              title: Text(product.name),
              subtitle: Text(
                product.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black38,
                    ),
              ),
              leading: Icon(
                Icons.shopping_cart,
                color: isAlreadyInCart ? Colors.green : Colors.transparent,
              ),
              trailing: Text(
                formatter.format(product.price),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
              ),
              onTap: isAlreadyInCart
                  ? null
                  : () => cartService.addProduct(product),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: productService.products.length,
        ),
      ),
    );
  }
}
