/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:estoque_app/models/user_model.dart';
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
  UserData user;

  UserPage({
    super.key,
    UserData? user,
  }) : user = user ?? UserData(userId: '', name: '', email: '', isAdmin: true);

  /*********************************************************
  *   Methods
  *********************************************************/

  /*********************************************************
  *   Build
  *********************************************************/

  @override
  Widget build(BuildContext context) {
    print(user.isAdmin);
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text('Usuário'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.w900,
          fontSize: 26,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ID: ${user.userId}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            'Nome: ${user.name}',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'Email: ${user.email}',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'Admin: ${user.isAdmin ? "Sim" : "Não"}',
            style: const TextStyle(fontSize: 16, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
