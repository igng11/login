import 'package:etsy_uy/models/models.dart';
import 'package:etsy_uy/screens/screens.dart';
import 'package:etsy_uy/services/services.dart';
import 'package:etsy_uy/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
const HomeScreen ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

  final productsService = Provider.of<ProductsService>(context);

  if (productsService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
     ),
     body: ListView.builder(
      itemCount: productsService.products.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          productsService.selectedProduct = productsService.products[index].copy();
          Navigator.pushNamed(context, 'list products');
        } ,
        child: ProductCard(product: productsService.products[index])),
   ),
   floatingActionButton: FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: (){
      productsService.selectedProduct = Product(
        available: false, 
        name: '', 
        price: 0);
      Navigator.pushNamed(context, 'list products');
    },
   ),
   );
  }
}