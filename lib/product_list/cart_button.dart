import 'package:flutter/material.dart';
import 'package:flutter_state_management_no_packages/cart/cart_screen.dart';
import 'package:flutter_state_management_no_packages/main.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = CartContainer.of(context);

    return TextButton(
        onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            ),
        child: Row(
          children: [
            const Icon(Icons.shopping_cart),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListenableBuilder(
                listenable: cartService,
                builder: (context, child) =>
                    Text('Cart: ${cartService.products.length}'),
              ),
            )
          ],
        ));
  }
}
