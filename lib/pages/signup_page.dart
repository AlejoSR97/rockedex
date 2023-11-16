import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rockedex/models/user.dart';
import 'package:rockedex/providers/user_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late UserProvider userProvider;
  int seleccionado = 0;
  List<String> equipos = ['rojo', 'azul', 'amarillo'];

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

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
        image: AssetImage('assets/images/bg-2.jpg'),
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
        campoNickname(),
        const SizedBox(height: 25),
        selectorEquipo(context),
        const SizedBox(height: 25),
        botonRegistrar(context),
        const SizedBox(height: 25),
        botonIngresar(context),
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
          borderRadius: BorderRadius.circular(10),
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
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
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

  Widget campoNickname() {
    return TextFormField(
      controller: nicknameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: 'Nickname',
        filled: true,
        fillColor: Colors.grey[200],
        suffixIcon: Container(
          margin: const EdgeInsets.only(right: 10),
          width: double.minPositive,
          alignment: Alignment.center,
          child: FaIcon(
            FontAwesomeIcons.tag,
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

  Widget selectorEquipo(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Equipo',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[500],
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            child: FaIcon(
              seleccionado == 1
                  ? FontAwesomeIcons.solidCircleCheck
                  : FontAwesomeIcons.circle,
              color: Colors.red,
            ),
          ),
          onTap: () {
            setState(() {
              seleccionado = 1;
            });
          },
        ),
        GestureDetector(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 40,
            height: 40,
            alignment: Alignment.center,
            child: FaIcon(
              seleccionado == 2
                  ? FontAwesomeIcons.solidCircleCheck
                  : FontAwesomeIcons.circle,
              color: Colors.blue,
            ),
          ),
          onTap: () {
            setState(() {
              seleccionado = 2;
            });
          },
        ),
        GestureDetector(
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            child: FaIcon(
              seleccionado == 3
                  ? FontAwesomeIcons.solidCircleCheck
                  : FontAwesomeIcons.circle,
              color: Colors.amber,
            ),
          ),
          onTap: () {
            setState(() {
              seleccionado = 3;
            });
          },
        ),
      ],
    );
  }

  Widget botonRegistrar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 40,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        child: const Text(
          'REGISTRARSE',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          if (userController.text.isNotEmpty &&
              passwordController.text.isNotEmpty &&
              nicknameController.text.isNotEmpty &&
              seleccionado > 0) {
            User user = User(
              name: userController.text,
              password: passwordController.text,
              nickname: nicknameController.text,
              team: equipos[seleccionado - 1],
            );

            userProvider.register(user).then((value) {
              if (value) {
                Navigator.pushReplacementNamed(context, 'home');
              }
            });
          }
        },
      ),
    );
  }

  Widget botonIngresar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 40,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        child: Text(
          'Ya tengo cuenta',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.grey[500],
          ),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'login');
        },
      ),
    );
  }
}
