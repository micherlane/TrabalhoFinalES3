import 'package:cadastro_pessoa_app/controller/add_person_controller.dart';
import 'package:flutter/material.dart';

class AddPersonView extends StatefulWidget {
  const AddPersonView({super.key});

  @override
  State<AddPersonView> createState() => _AddPersonViewState();
}

class _AddPersonViewState extends State<AddPersonView> {
  final _formkey = GlobalKey<FormState>();
  final _addPersonController = AddPersonController();

  String? _validateNameField(String? value) {
    if (value == null || value.isEmpty) {
      return "Digite um valor";
    }
    return null;
  }

  String? _validatePasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite uma senha.';
    }
    if (value.length < 6) {
      return 'A senha precisa ter no mínimo 6 caracteres';
    }
    return null;
  }

  _alertSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color.fromRGBO(255, 121, 135, 1),
      content: Text(message),
      duration: const Duration(milliseconds: 1000),
    ));
  }

  salvar() {
    if (_formkey.currentState!.validate()) {
      _addPersonController.salvar();
      _alertSnackBar('Cadastro concluído');
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
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(75)),
                  child: const Icon(
                    Icons.person_2_sharp,
                    size: 150,
                    color: Colors.white,
                  ),
                ),
                TextFormField(
                  controller: _addPersonController.nameController,
                  decoration: const InputDecoration(
                    label: Text('Digite o nome'),
                  ),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  validator: _validateNameField,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  controller: _addPersonController.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    label: Text('Digite a senha'),
                  ),
                  obscureText: true,
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  validator: _validatePasswordField,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: salvar,
                    style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll<Size>(
                            Size(double.infinity, 50))),
                    child: const Text('SALVAR'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
