/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:estoque_app/models/user_model.dart';
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
// Methods
import 'package:estoque_app/services/business_model.dart';
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

  final currentUser = FirebaseAuth.instance.currentUser;
  final FirestoreServices firestoreServices = FirestoreServices();
  UserData user = UserData();

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
  void initState() {
    super.initState();
    fetchUserData(); // Chama a função ao iniciar
  }

  void fetchUserData() async {
    if (currentUser != null) {
      UserData? userDataNullable =
          await firestoreServices.getUser(currentUser!.email);
      if (userDataNullable != null) {
        user = userDataNullable;
      }
      setState(() {}); // Atualiza a tela quando os dados são carregados
    }
  }

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
                MaterialPageRoute(builder: (context) => CartPage(user: user)),
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
                  user.email,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 18,
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserPage(user: user)));
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
                        builder: (context) => StatisticsPage(user: user)));
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
          return StoragePage(user: user);
        },
      ),

      // Botão Suspenso
      floatingActionButton: user.isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPage(isNew: true)));
              },
              tooltip: 'Ir para AddPage',
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            )
          : null,
    );
  }
}
