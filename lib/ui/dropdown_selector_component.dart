/***********************************************************************************************************************
* 
*                                                  Import
* 
***********************************************************************************************************************/
//Pacotes
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estoque_app/services/business_model.dart';
import 'package:flutter/material.dart';

/***********************************************************************************************************************
* 
*                                                  Public
* 
***********************************************************************************************************************/

class MyDropdownSelectorComponent extends StatefulWidget {
  /*********************************************************************************************************************
  *   Variables
  *********************************************************************************************************************/
  final Function(String) onReportSelected;
  final Stream<QuerySnapshot> queryStream;

  MyDropdownSelectorComponent({
    super.key,
    required this.onReportSelected,
    required this.queryStream,
  });

  @override
  State<MyDropdownSelectorComponent> createState() =>
      _MyDropdownSelectorComponentState();
}

class _MyDropdownSelectorComponentState
    extends State<MyDropdownSelectorComponent> {
  /*********************************************************************************************************************
  *   Variables
  *********************************************************************************************************************/
  String? selectedReport;
  FirestoreServices firestoreServices = FirestoreServices();
  /*********************************************************************************************************************
  *   Build
  *********************************************************************************************************************/
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.queryStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        // Coleta os nomes dos produtos como opções de relatório
        List<String> reportOptions =
            snapshot.data!.docs.map((doc) => doc['name'].toString()).toList();

        // Adiciona uma opção padrão
        reportOptions.insert(0, 'Nenhum');

        // Verifica se selectedReport ainda é válido
        if (selectedReport != null && !reportOptions.contains(selectedReport)) {
          selectedReport = null;
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: selectedReport,
            hint: const Text('Selecione um relatório'),
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                selectedReport = newValue;
              });
              widget.onReportSelected(newValue!);
            },
            items: reportOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
