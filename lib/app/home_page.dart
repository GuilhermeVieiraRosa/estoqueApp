/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:estoque_app/app/add_page.dart';
import 'package:estoque_app/app/cart_page.dart';
import 'package:estoque_app/app/config_page.dart';
import 'package:estoque_app/app/statistics_page.dart';
import 'package:estoque_app/app/storage_page.dart';
import 'package:estoque_app/app/user_page.dart';
//Paginas
//Componentes

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*********************************************************
  *   Variables
  *********************************************************/

  final user = FirebaseAuth.instance.currentUser;

  /*********************************************************
  *   Methods
  *********************************************************/

  /**
  * Sign User Out Method
  */
  Future<void> signUserOut() async {
    FirebaseAuth.instance.signOut();
  }

  /*********************************************************
  *   Build
  *********************************************************/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: const Text('App GW'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.w900,
          fontSize: 26,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.inversePrimary,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        ],
      ),

      // Drawer
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            // Logo e Title
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Text(
                  "${user!.email}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 22,
                  ),
                ),
              ),
            ),

            // Divider
            const Divider(),

            // User Page
            ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                'Usuário',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserPage()));
              },
            ),

            // Statistics Page
            ListTile(
              leading: Icon(
                Icons.text_snippet,
                size: 30,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                'Relatórios',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StatisticsPage()));
              },
            ),

            // Config Page
            ListTile(
              leading: Icon(
                Icons.settings,
                size: 30,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                'Configurações',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfigPage()));
              },
            ),

            //Logoff
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 30,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                'Sair',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20,
                ),
              ),
              onTap: signUserOut,
            ),
          ],
        ),
      ),

      // Body
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return StoragePage();
        },
      ),

      // Botão Suspenso
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPage(isNew: true)));
        },
        tooltip: 'Ir para AddPage',
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
