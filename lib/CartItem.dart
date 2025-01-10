import 'package:flutter/material.dart';
import 'package:shopping_cart/item.dart';

class CartItem extends StatefulWidget {
  final Item items;
  final VoidCallback onQuantityChanged;

  const CartItem({
    super.key,
    required this.items,
    required this.onQuantityChanged,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.items.amount;
  }

  void updateQuantity(int value) {
    setState(() {
      quantity = value;
      widget.items.amount = value;
    });
    widget.onQuantityChanged();
  }

@override
Widget build(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.items.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            'Price: ${widget.items.price}',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
      Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              if (widget.items.amount > 0) {
                setState(() {
                  widget.items.amount--;
                });
                widget.onQuantityChanged(); // แจ้ง parent เมื่อเปลี่ยนจำนวนสินค้า
              }
            },
          ),
          Text(
            '${widget.items.amount}', // อ่านค่าจาก widget.items.amount
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                widget.items.amount++;
              });
              widget.onQuantityChanged(); // แจ้ง parent เมื่อเปลี่ยนจำนวนสินค้า
            },
          ),
        ],
      ),
    ],
  );
}
}