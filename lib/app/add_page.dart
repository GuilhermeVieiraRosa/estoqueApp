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
import 'package:estoque_app/services/business_model.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class AddPage extends StatefulWidget {
  /*********************************************************
  *   Variables
  *********************************************************/

  final Product product;
  final bool isNew;

  AddPage({
    super.key,
    required this.isNew,
    Product? product, // Opcional, pode ser passado ou não
  }) : product = product ??
            Product(
              // Inicializa com um valor padrão se necessário
              productId: '',
              name: '',
              description: '',
              imagePath: '',
              price: '',
              quantity: '',
              administratorId: '',
            );

  /*********************************************************
  *   State
  *********************************************************/
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  /*********************************************************
  *   Variables
  *********************************************************/

  final TextEditingController imagePathController = TextEditingController();
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
    if (imagePathController.text.isEmpty ||
        idController.text.isEmpty ||
        nameController.text.isEmpty ||
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
    var product = Product(
      productId: idController.text,
      name: nameController.text,
      description: descriptionController.text,
      imagePath: imagePathController.text,
      price: priceController.text,
      quantity: quantityController.text,
      administratorId: '', // Atualize com o ID do administrador, se necessário
    );

    // Simulação de salvamento (substitua pela lógica de backend)
    firestoreServices.addProduct(product);

    // Limpar os campos após salvar
    imagePathController.clear();
    idController.clear();
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    quantityController.clear();

    Navigator.pop(context);
  }

  /*********************************************************
  *   Build
  *********************************************************/

  @override
  Widget build(BuildContext context) {
    // Verifica se está adicionando ou atualizando um produto
    if (!widget.isNew) {
      idController.text = widget.product.productId;
      nameController.text = widget.product.name;
      descriptionController.text = widget.product.description;
      imagePathController.text = widget.product.imagePath;
      priceController.text = widget.product.price;
      quantityController.text = widget.product.quantity;
    }
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
              // Campos de entrada
              MyTextfieldComponentVariant(
                controller: imagePathController,
                text: 'URL da Imagem do produto',
                hintText: 'Endereço da imagem',
                obscureText: false,
              ),
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
                hintText: 'Descrição (Opcional)',
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
