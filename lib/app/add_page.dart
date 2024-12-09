/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/

//Pacotes
import 'package:estoque_app/app/storage_page.dart';
import 'package:estoque_app/ui/button_component.dart';
import 'package:estoque_app/ui/textfield_component.dart';
import 'package:flutter/material.dart';
//Paginas
//Componentes
//Modelos
import 'package:estoque_app/models/product_model.dart';
//Metodos
import 'package:estoque_app/services/firestore.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class AddPage extends StatefulWidget {
  AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  /*********************************************************
  *   Variables
  *********************************************************/

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final FirestoreServices firestoreServices = FirestoreServices();

  /*********************************************************
  *   Methods
  *********************************************************/

  void addNewProduct() {
    // Validação básica
    if (idController.text.isEmpty ||
        nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty ||
        quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Criação do produto
    Product product = Product(
      productId: idController.text,
      name: nameController.text,
      description: descriptionController.text,
      imagePath: '', // Atualize com lógica de upload, se necessário
      price: priceController.text,
      quantity: quantityController.text,
      administratorId: '', // Atualize com o ID do administrador, se necessário
    );

    // Simulação de salvamento (substitua pela lógica de backend)
    firestoreServices.addProduct(product);

    // Limpar os campos após salvar
    idController.clear();
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    quantityController.clear();

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => StoragePage()));
  }

  /*********************************************************
  *   Build
  *********************************************************/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Produto'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.w900,
          fontSize: 26,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              // IMAGEM (Placeholder)
              Column(
                children: [
                  Text(
                    'Imagem do produto:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 20,
                    ),
                  ),
                  const Icon(
                    Icons.image,
                    size: 100,
                  ),
                ],
              ),

              // Campos de entrada
              MyTextfieldComponentVariant(
                controller: idController,
                text: 'ID do produto',
                hintText: 'ID',
                obscureText: false,
              ),
              MyTextfieldComponentVariant(
                controller: nameController,
                text: 'Nome do produto',
                hintText: 'Nome',
                obscureText: false,
              ),
              MyTextfieldComponentVariant(
                controller: descriptionController,
                text: 'Descrição do produto',
                hintText: 'Descrição',
                obscureText: false,
              ),
              Row(
                children: [
                  Expanded(
                    child: MyTextfieldComponentVariant(
                      controller: priceController,
                      text: 'Preço',
                      hintText: 'xx,xx',
                      obscureText: false,
                    ),
                  ),
                  Expanded(
                    child: MyTextfieldComponentVariant(
                      controller: quantityController,
                      text: 'Quantidade',
                      hintText: 'xx',
                      obscureText: false,
                    ),
                  ),
                ],
              ),

              // Botão de salvar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: MyButtonComponent(
                  onTap: () => {addNewProduct()},
                  text: 'Salvar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
