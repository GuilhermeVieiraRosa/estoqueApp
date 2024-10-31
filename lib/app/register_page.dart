/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

// Pacotes
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Componentes
import 'package:flutter_test_aplication/ui/button_component.dart';
import 'package:flutter_test_aplication/ui/textfield_component.dart';

// Paginas

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class RegisterPage extends StatefulWidget {
  /*********************************************************
  *   Variables
  *********************************************************/

  void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap,
  });

  /*********************************************************
  *   Create State
  *********************************************************/

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /*********************************************************
  *   Variables
  *********************************************************/

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /*********************************************************
  *   Methods
  *********************************************************/

  /**
  * Register Method
  */
  Future<void> registerUserIn() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Verify is password and confirm password is the same
    if (passwordController.text != confirmPasswordController.text) {
      // Remove loading circle
      Navigator.pop(context);
      // Show Error Message
      showErrorMessage('Senhas não coincidem!');
      return;
    }

    // Try Register In
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

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
                  height: 10,
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
                      'Registrar conta',
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

                // Password Text Field
                SizedBox(
                  height: 10,
                ),
                MyTextfieldComponent(
                  controller: confirmPasswordController,
                  hintText: 'Confirmar Senha',
                  obscureText: true,
                ),

                // Login Button
                SizedBox(
                  height: 25,
                ),
                MyButtonComponent(
                  onTap: registerUserIn,
                  text: 'Registrar',
                ),

                // Register Button
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Já tem uma conta? '),
                      Text(
                        'Entre aqui.',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 100,
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
