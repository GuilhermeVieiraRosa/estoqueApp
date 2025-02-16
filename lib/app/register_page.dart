/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

// Pacotes
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:estoque_app/themes/theme_provider.dart';
import 'package:estoque_app/services/business_model.dart';
// Paginas
// Componentes
import 'package:estoque_app/ui/button_component.dart';
import 'package:estoque_app/ui/textfield_component.dart';
import 'package:provider/provider.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class RegisterPage extends StatefulWidget {
  void Function()? onLoginButtomTap;

  RegisterPage({
    super.key,
    required this.onLoginButtomTap,
  });

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

  final FirestoreServices firestoreServices = FirestoreServices();

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
        return const Center(
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

      // Register in database
      firestoreServices.newUser(emailController.text);

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
            style: const TextStyle(fontSize: 20),
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20), // Arredondamento dos cantos
            side: const BorderSide(
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Central Icon and Theme Icon
                Stack(
                  children: [
                    // Central Icon
                    Center(
                      child: Icon(
                        Icons.account_box,
                        size: 180,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    // Theme Toggle Button
                    Positioned(
                      top: 15,
                      right: 15,
                      child: GestureDetector(
                        onTap: () => Provider.of<ThemeProvider>(
                          context,
                          listen: false,
                        ).toggleTheme(),
                        child: Icon(
                          Icons.sunny,
                          size: 40,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                    ),
                  ],
                ),

                // Text
                const SizedBox(height: 5),
                Column(
                  children: [
                    Text(
                      'App GW',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Registrar conta',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                // Username Text Field
                const SizedBox(height: 10),
                MyTextfieldComponent(
                  controller: emailController,
                  hintText: 'Usuário',
                  obscureText: true,
                ),

                // Password Text Field
                const SizedBox(height: 10),
                MyTextfieldComponent(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                ),

                // Password Text Field
                const SizedBox(height: 10),
                MyTextfieldComponent(
                  controller: confirmPasswordController,
                  hintText: 'Confirmar Senha',
                  obscureText: true,
                ),

                // Register Button
                const SizedBox(height: 25),
                MyButtonComponent(
                  onTap: registerUserIn,
                  text: 'Registrar',
                ),

                // Login Button
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: widget.onLoginButtomTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Já tem uma conta? ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const Text(
                        'Entre aqui.',
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
