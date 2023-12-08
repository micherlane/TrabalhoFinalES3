import '../controller/person_ui_add_controller.dart';
import 'package:flutter/material.dart';

abstract class FieldValidator {
  String? validate(String? value);
}

abstract class AlertDisplayer {
  void showAlert(String message);
}
// Essas interfaces segregam a funcionalidade de validação de campos e exibição de alertas, 
// permitindo que a classe implemente apenas o que é relevante para ela.

class AddPersonView extends StatefulWidget {
  const AddPersonView({super.key});

  @override
  State<AddPersonView> createState() => _AddPersonViewState();
}

class _AddPersonViewState extends State<AddPersonView>       // A classe em questão foi modificada para poder implementar
    implements FieldValidator, AlertDisplayer {              // as interfaces de validação e alerta. Isso significa que a 
  final _formkey = GlobalKey<FormState>();                  // classe agora deve fornecer uma implementação para os métodos
  final _addPersonController = AddPersonController();       // definidos nessas interfaces.

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {       // Implementação do método "validate", definida da interface "FieldValidator".
      return "Digite um valor";
    }
    return null;
  }

  @override
  void showAlert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color.fromRGBO(255, 121, 135, 1),   // implementação do método "showAlert", definido na interface "AlertDisplay".
      content: Text(message),
      duration: const Duration(milliseconds: 1000),
    ));
  }

  salvar() {
    if (_formkey.currentState!.validate()) {
      _addPersonController.salvar();
      showAlert('Cadastro concluído');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADICIONAR PESSOA"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                // Restante do código...
                ElevatedButton(
                  onPressed: salvar,
                  style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll<Size>(
                          Size(double.infinity, 50))),
                  child: const Text('SALVAR'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

