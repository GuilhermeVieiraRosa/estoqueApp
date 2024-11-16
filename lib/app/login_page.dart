/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

// Pacotes
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Paginas
// Componentes
import 'package:flutter_test_aplication/ui/button_component.dart';
import 'package:flutter_test_aplication/ui/textfield_component.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class LoginPage extends StatefulWidget {
  void Function()? onRegisterButtomTap;

  LoginPage({
    super.key,
    required this.onRegisterButtomTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /*********************************************************
  *   Variables
  *********************************************************/

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /*********************************************************
  *   Methods
  *********************************************************/

  /**
  * Sign In Method
  */
  Future<void> signUserIn() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Try Sign In
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // Remove loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Remove loading circle
      Navigator.pop(context);

      // Show Error Message
      showErrorMessage(e.code);
    }
  }

  /**
  * Error Message Method
  */
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            message,
            style: TextStyle(fontSize: 20),
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20), // Arredondamento dos cantos
            side: BorderSide(
              color: Colors.grey, // Cor da borda
              width: 3, // Espessura da borda
            ),
          ),
        );
      },
    );
  }

  /*********************************************************
  *   Build
  *********************************************************/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.account_box,
                  size: 150,
                ),

                // Text
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                      'App Armazem',
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Entrar na conta',
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                // Username Text Field
                SizedBox(
                  height: 20,
                ),
                MyTextfieldComponent(
                  controller: emailController,
                  hintText: 'Usuário',
                  obscureText: false,
                ),

                // Password Text Field
                SizedBox(
                  height: 10,
                ),
                MyTextfieldComponent(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                ),

                // Forgot Password
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text('Esqueceu a senha?'),
                    ),
                  ],
                ),

                // Login Button
                SizedBox(
                  height: 25,
                ),
                MyButtonComponent(
                  onTap: signUserIn,
                  text: 'Logar',
                ),

                // Register Button
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: widget.onRegisterButtomTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Não tem uma conta? '),
                      Text(
                        'Registre-se aqui.',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // A implementar:
                // Remain Connected
                // Google + Apple sign
              ],
            ),
          ),
        ),
      ),
    );
  }
}
