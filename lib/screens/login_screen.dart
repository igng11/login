import 'dart:ui';

import 'package:etsy_uy/providers/login_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:etsy_uy/UI/imput_decoration.dart';
import 'package:etsy_uy/widgets/auth_background.dart';
import 'package:etsy_uy/widgets/card_container.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
const LoginScreen ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 300),

            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text('Login', style: TextStyle(fontSize: 25, color: Colors.orangeAccent)),
                  const SizedBox(height: 10),
                  ChangeNotifierProvider(create: ( _ )=> LoginFormProvider(),
                  child: const _LoginForm(),),
                ],
              ),
              ),
              const SizedBox(height: 50),
              const Text('Crear nueva cuenta', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 36, 105, 139), decoration: TextDecoration.underline)),
          ],
        ),
      ),
     ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
            hintText: 'usuario@dominio.com',
            labelText: 'Email',
            prefixicon: Icons.alternate_email_rounded),
            onChanged: (value) => loginForm.email = value, 
            validator: (value) {
            String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp  = RegExp(pattern);
            return regExp.hasMatch(value ?? '') 
            ? null
            : 'Debe ingresar un correo electrónico válido';
            },
          ),
          const SizedBox(height: 50),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
            hintText: '******',
            labelText: 'Password',
            prefixicon: Icons.lock_person_outlined,
            ),
            onChanged: (value) => loginForm.password = value,  
            validator: (value) {
            return (value != null && value.length >= 6) ? null
            : 'La contraseña debe tener al menos 6 caracteres';
            },
          ),
          const SizedBox(height: 30),

          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: const Color.fromARGB(255, 255, 255, 255),
            elevation: 0,
            color:const Color.fromARGB(255, 36, 105, 139),
            // ignore: sort_child_properties_last
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
              child: Text(
                loginForm.isLoading
                ? 'Espera'
                : 'Ingresar', style: const TextStyle(color: Colors.white, fontSize: 16)),),
            
            onPressed: loginForm.isLoading ? null : () async {

              FocusScope.of(context).unfocus();

              if (!loginForm.isValidForm()) return;

              loginForm.isLoading = true;

              Navigator.pushReplacementNamed(context, 'inicio');

              await Future.delayed(const Duration(seconds: 3));

            }),
        ],
      ),
    );
  }
}