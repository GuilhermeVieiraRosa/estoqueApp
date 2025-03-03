import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estoque_app/models/delivery_model.dart';
import 'package:estoque_app/models/product_model.dart';
import 'package:estoque_app/models/sale_model.dart';
import 'package:estoque_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:estoque_app/services/business_model.dart';
import 'package:estoque_app/ui/dropdown_selector_component.dart';

class StatisticsPage extends StatefulWidget {
  final Function()? onTap;
  UserData user;

  StatisticsPage({
    super.key,
    this.onTap,
    UserData? user,
  }) : user = user ?? UserData(userId: '', name: '', email: '', isAdmin: true);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final FirestoreServices firestoreServices = FirestoreServices();

  String _selectedOption = 'Nenhum';

  String productId = '';
  String userId = '';
  List<double> total = [];

  bool _isLoading = true;

  final List<String> _options = [
    'Nenhum',
    'Vendas de Produtos',
    'Usuários',
    'Estoque'
  ];

  Future<String> getTime(String saleId) async {
    return await firestoreServices.getSalesTimeStamp(saleId) ?? '';
  }

  Future<Product> getProductName(String productId) async {
    var product = await firestoreServices.getProduct(productId);
    return product!;
  }

  Future<double> getTotal(int index) async {
    if (index >= total.length) {
      while (index >= total.length) {
        total.add(0.0);
      }
      return 0.0;
    }

    return total[index];
  }

  void increaseTotal(double value, int index) {
    if (index >= total.length) {
      while (index >= total.length) {
        total.add(0.0);
      }
    }

    total[index] += value;
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  // Função assíncrona chamada dentro do initState
  Future<void> _initialize() async {
    if (!widget.user.isAdmin) {
      await setUserSelected(); // Aguarda a resolução da função
    }
    setState(() {
      _isLoading = false;
    });
  }

  // Seta relatório como Usuário e userName
  Future<void> setUserSelected() async {
    _selectedOption = 'Usuários';
    userId = await firestoreServices.getUserIdByName(widget.user.name) ?? '';
  }

  Future<void> _onProductSelected(String selected) async {
    try {
      productId = await firestoreServices.getProductIdByName(selected) ?? '';

      setState(() {
        print("Relatório selecionado: $selected, Id: $productId");
      });
    } catch (e) {
      print("Erro ao carregar vendas: $e");
    }
  }

  Future<void> _onUserSelected(String selected) async {
    try {
      userId = await firestoreServices.getUserIdByName(selected) ?? '';

      setState(() {
        print("Usuário selecionado: $selected, Id: $userId");
      });
    } catch (e) {
      print("Erro ao carregar vendas: $e");
    }
  }

  Widget _getSelectedWidget() {
    switch (_selectedOption) {
      case 'Vendas de Produtos':
        return Column(
          children: [
            const SizedBox(height: 12),
            MyDropdownSelectorComponent(
              queryStream: firestoreServices.getProductStream(),
              onReportSelected: _onProductSelected,
            ),
            const SizedBox(height: 12),
            const Center(child: Text('Tela de Produtos')),

            // Gráfico de Vendas por Produto
            // Caso a Stream de Vendas esteja pronta
            StreamBuilder(
              stream: firestoreServices.getDeliveryStreamByProductId(productId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('Nenhum dado disponível');
                } else {
                  // Coleta lista de dados
                  List deliveryList = snapshot.data!.docs;

                  // Mostra todos os dado como lista
                  return Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: deliveryList.length,
                      itemBuilder: (context, index1) {
                        // Coleta dado individualmente
                        DocumentSnapshot deliverySnapshot =
                            deliveryList[index1];
                        Map<String, dynamic> deliveryData =
                            deliverySnapshot.data() as Map<String, dynamic>;

                        var saleId = deliveryData['saleId'];
                        var quantity = deliveryData['quantity'];

                        return FutureBuilder(
                          future: getTime(saleId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            } else {
                              return Row(
                                children: [
                                  Text('Venda N°: $saleId'),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                      'data: ${(snapshot.data.toString() ?? ' ')}'),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text('qtty: $quantity'),
                                ],
                              );
                            }
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        );
      case 'Usuários':
        return Column(
          children: [
            const SizedBox(height: 12),
            widget.user.isAdmin
                ? MyDropdownSelectorComponent(
                    queryStream: firestoreServices.getUserStreamByName(),
                    onReportSelected: _onUserSelected,
                  )
                : Container(),
            const SizedBox(height: 12),
            const Center(child: Text('Tela de Usuários')),

            // Gráfico de Vendas por Usuário
            // Caso a Stream de Vendas esteja pronta
            StreamBuilder(
              stream: firestoreServices.getSaleStreamByUserId(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('Nenhum dado disponível');
                } else {
                  // Coleta lista de dados
                  List saleList = snapshot.data!.docs;

                  // Mostra todos os dado como lista
                  return Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: saleList.length,
                      itemBuilder: (context, index1) {
                        // Coleta dado individualmente
                        DocumentSnapshot saleSnapshot = saleList[index1];
                        Map<String, dynamic> saleData =
                            saleSnapshot.data() as Map<String, dynamic>;

                        var sale = Sale(
                          saleId: saleData['saleId'],
                          date: saleData['date'].toDate(),
                          userId: saleData['userId'],
                        );

                        return Column(
                          children: [
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Text('Venda N°: ${sale.saleId}'),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text('data: ${(sale.date.toString() ?? ' ')}'),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Spacer(),
                                FutureBuilder(
                                  future: getTotal(index1),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    } else {
                                      return Text(
                                          'R\$ ${snapshot.data!.toStringAsFixed(2)}');
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 12.0,
                            ),

                            // Mostra Informações detalhadas da Compra
                            StreamBuilder(
                              stream: firestoreServices
                                  .getDeliveryStreamBySaleId(sale.saleId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                if (snapshot.hasError) {
                                  return Text('Erro: ${snapshot.error}');
                                }
                                if (!snapshot.hasData) {
                                  return const Text('Nenhum dado disponível');
                                } else {
                                  // Coleta lista de dados
                                  List deliveryList = snapshot.data!.docs;

                                  // Mostra todos os dado como lista
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: deliveryList.length,
                                    itemBuilder: (context, index2) {
                                      // Coleta dado individualmente
                                      DocumentSnapshot deliverySnapshot =
                                          deliveryList[index2];
                                      Map<String, dynamic> deliveryData =
                                          deliverySnapshot.data()
                                              as Map<String, dynamic>;

                                      var delivery = Delivery(
                                        saleId: deliveryData['saleId'],
                                        deliveryId: deliveryData['deliveryId'],
                                        productId: deliveryData['productId'],
                                        quantity: deliveryData['quantity'],
                                      );

                                      return FutureBuilder(
                                        future:
                                            getProductName(delivery.productId),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                snapshot.error.toString());
                                          } else {
                                            var subTotal = ((double.tryParse(
                                                        snapshot.data!.price
                                                            .replaceAll(
                                                                ',', '.')) ??
                                                    0.0) *
                                                (double.tryParse(
                                                        delivery.quantity) ??
                                                    0.0));
                                            increaseTotal(subTotal, index1);
                                            return Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Text(
                                                      'id: ${delivery.productId}'),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Text(snapshot.data!.name),
                                                  Spacer(),
                                                  Text(
                                                      'qtty: ${delivery.quantity}'),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Text(
                                                      'R\$ ${snapshot.data!.price}'),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Text(
                                                      'R\$ ${subTotal.toStringAsFixed(2)}'),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                ],
                                              ),
                                            ]);
                                          }
                                        },
                                      );
                                    },
                                  );
                                }
                              },
                            )
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        );
      case 'Estoque':
        return Column(
          children: [
            const SizedBox(height: 12),
            const Center(child: Text('Tela de Estoque')),

            // Gráfico de Estoque
            StreamBuilder(
              stream: firestoreServices.getProductStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('Nenhum dado disponível');
                } else {
                  // Coleta lista de dados
                  List productList = snapshot.data!.docs;

                  // Mostra todos os dado como lista
                  return Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: productList.length,
                      itemBuilder: (context, index1) {
                        // Coleta dado individualmente
                        DocumentSnapshot productSnapshot = productList[index1];
                        Map<String, dynamic> productData =
                            productSnapshot.data() as Map<String, dynamic>;

                        var product = Product(
                          productId: productData['productId'],
                          name: productData['name'],
                          quantity: productData['quantity'],
                          administratorId: '',
                          description: '',
                          imagePath: '',
                          price: '',
                        );

                        return Column(
                          children: [
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                SizedBox(width: 20.0),
                                Text('N°: ${product.productId}'),
                                SizedBox(width: 20.0),
                                Text(product.name),
                                SizedBox(width: 20.0),
                                Spacer(),
                                Text('qtty: ${product.quantity}'),
                                SizedBox(width: 20.0),
                              ],
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        );
      default:
        return const Center(child: Text('Nenhuma opção selecionada'));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Relatórios'),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          titleTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.w900,
            fontSize: 26,
          ),
        ),
        body: widget.user.isAdmin
            ? Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedOption = newValue!;
                        });
                      },
                      items: _options
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: _getSelectedWidget(),
                  ),
                ],
              )
            : _getSelectedWidget());
  }
}
