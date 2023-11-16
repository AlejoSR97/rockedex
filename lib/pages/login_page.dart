import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rockedex/providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(
      context,
      listen: true,
    );

    return Scaffold(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        imagenFondo(context),
        colorFondo(context),
        contenedorTarjeta(context),
      ],
    );
  }

  Widget imagenFondo(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Image(
        fit: BoxFit.cover,
        image: AssetImage('assets/images/bg-1.jpg'),
      ),
    );
  }

  Widget colorFondo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white70,
    );
  }

  Widget contenedorTarjeta(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: contenidoTarjeta(context),
    );
  }

  Widget contenidoTarjeta(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        imagenLogo(context),
        const SizedBox(height: 25),
        campoUsuario(),
        const SizedBox(height: 25),
        campoContrasena(),
        const SizedBox(height: 25),
        botonIngresar(context),
        const SizedBox(height: 25),
        botonRegistrar(context),
      ],
    );
  }

  Widget imagenLogo(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: const Image(
        fit: BoxFit.contain,
        image: AssetImage('assets/images/logo.jpeg'),
      ),
    );
  }

  Widget campoUsuario() {
    return TextFormField(
      controller: userController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        hintText: 'Usuario',
        filled: true,
        fillColor: Colors.grey[200],
        suffixIcon: Container(
          margin: const EdgeInsets.only(right: 10),
          width: double.minPositive,
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.solidUser,
            color: Colors.grey[400],
          ),
        ),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 17,
          color: Colors.grey,
        ),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 17,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget campoContrasena() {
    return TextFormField(
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        hintText: 'Contraseña',
        filled: true,
        fillColor: Colors.grey[200],
        suffixIcon: Container(
          margin: const EdgeInsets.only(right: 10),
          width: double.minPositive,
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.lock,
            color: Colors.grey[400],
          ),
        ),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 17,
          color: Colors.grey,
        ),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 17,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget botonIngresar(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 40,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        child: const Text(
          'INGRESAR',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          if (userController.text.isNotEmpty &&
              passwordController.text.isNotEmpty) {
            userProvider
                .authUser(
              userController.text,
              passwordController.text,
            )
                .then((value) {
              if (value) {
                Navigator.pushReplacementNamed(context, 'home');
              }
            });
          }
        },
      ),
    );
  }

  Widget botonRegistrar(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 40,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        child: Text(
          'No tengo cuenta',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.grey[500],
          ),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'signup');
        },
      ),
    );
  }
}
