/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:flutter/material.dart';
//Paginas
//Componentes

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class UserPage extends StatelessWidget {
  /*********************************************************
  *   Variables
  *********************************************************/

  const UserPage({super.key});

  /*********************************************************
  *   Methods
  *********************************************************/

  /*********************************************************
  *   Build
  *********************************************************/

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
        child: Text(
          'Página User!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    ]);
  }
}
