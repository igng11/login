import 'package:etsy_uy/providers/product_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../UI/imput_decoration.dart';
import 'package:etsy_uy/services/products_service.dart';
import 'package:etsy_uy/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ListProduct extends StatelessWidget {
const ListProduct ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService,),);
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Stack(
                children: [
                  ProductImage(url: productService.selectedProduct.picture),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.grey,))),
                  Positioned(
                    top: 40,
                    right: 32,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt, size: 40, color: Colors.grey,))),
                ],
              ),
                  const _ProductForm(),
      
                  const SizedBox(height: 100)
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: FloatingActionButton(
            child: const Icon(Icons.save_outlined),
            onPressed: () async{
             if (!productForm.isValidForm()) return;

             await productService.saveOrCreateProduct(productForm.product);

             
            }),
        ),
       ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),

              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                hintText: 'Nombre del producto',
                labelText: 'Nombre:'
                ),
              ),

              const SizedBox(height: 30),

              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value){
                if (double.tryParse(value) == null) {
                  product.price = 0; 
                  }else{ product.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                hintText: '\$150',
                labelText: 'Precio:'
                ),
              ),

              const SizedBox(height: 30),

              SwitchListTile.adaptive(
                title: const Text('Disponible'),
                value: product.available, 
                onChanged: productForm.updateAvailability),

              const SizedBox(height: 30),
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
    boxShadow: [ BoxShadow(
      color: Colors.black12,
      offset: Offset(0,5),
      blurRadius: 5,
    )]
  );
}