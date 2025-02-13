import 'package:flutter/material.dart';
import 'package:shopping_cart/CartItem.dart';
import 'package:shopping_cart/item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shopping Cart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = <Item>[
    Item(name: 'iPhone 15', price: 38000),
    Item(name: 'MacBook Pro', price: 25000),
    Item(name: 'iPad Pro', price: 30000),
  ];

  int total = 0;

  void clearCart() {
    setState(() {
      for (var item in items) {
        item.amount = 0;
      }
      calculateTotal();
    });
    print("Cart cleared");
  }

  void calculateTotal() {
    setState(() {
      total = 0;
      for (var item in items) {
        total += (item.price * item.amount).toInt();
      }
    });
    print("Total updated: $total");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Cart',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                TextButton.icon(
                  onPressed: clearCart,
                  label: const Text('Clear Cart'),
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
            for (Item item in items)
              CartItem(
                items: item,
                onQuantityChanged: calculateTotal,
              ),
            const Expanded(
              child: SizedBox.shrink(),
            ),
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.grey[200],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:'),
                  Text(
                    '$total ฿',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
