import 'package:etsy_uy/models/models.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;

const ProductCard ({Key? key, required this.product}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(38.0),
      child: Container(
          width: double.infinity,
          height: 400,
          decoration: _cardBorders(),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
                _BackgroundImage(product.picture),
                _ProductDetails(
                  title: product.name,
                  subTitle: product.id!),
                Positioned(
                top: 0,
                right: 0,
                child: _PriceTag(product.price)),
                if ( !product.available )
               const Positioned(
                top: 0,
                left: 0,
                child: _NotAvailable()),
            ],
          ),
   ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [BoxShadow(
      color: Colors.black26,
      offset: Offset(0,0),
      blurRadius: 30,
    )],
  );
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topLeft: Radius.circular(20))
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Not available', style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double? price;
  const _PriceTag( this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('\$$price', style: const TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {

  final String title;
  final String subTitle;

  const _ProductDetails({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 48),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, color: Colors.white),),
            Text(subTitle, style: const TextStyle(fontSize: 14, color: Colors.white),)
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
      color: Colors.orange,
      borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20))
  );
}

class _BackgroundImage extends StatelessWidget {

  final String? url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: 400,
        width: double.infinity,
        color: Colors.white,
        child: url == null
            ? const Image(image: AssetImage('assets/no-image.png'),
            fit: BoxFit.fill)
            : FadeInImage(
        image: NetworkImage(url!),
        placeholder: const AssetImage('assets/jar-loading.gif'), 
        fit: BoxFit.cover
        ),
      ),
    );
  }
}