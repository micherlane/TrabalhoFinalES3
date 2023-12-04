import 'package:cadastro_pessoa_app/controller/update_person_controller.dart';
import 'package:cadastro_pessoa_app/model/pessoa.dart';
import 'package:flutter/material.dart';

class UpdatePersonView extends StatefulWidget {
  const UpdatePersonView({super.key});

  @override
  State<UpdatePersonView> createState() => _UpdatePersonViewState();
}

class _UpdatePersonViewState extends State<UpdatePersonView> {
  final _formkey = GlobalKey<FormState>();
  final UpdatePersonController updatePersonController =
      UpdatePersonController();
  late Person person;

  String? validateNameField(String? value) {
    if (value == null || value.isEmpty) {
      return "Digite um valor";
    }
    return null;
  }

  String? validatePasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite uma senha.';
    }
    if (value.length < 6) {
      return 'A senha precisa ter no mínimo 6 caracteres';
    }
    return null;
  }

  void updatePerson(Person person) {
    Person personUpdated = updatePersonController.updatePerson(person.id);
    Navigator.pop(context, personUpdated);
  }

  @override
  Widget build(BuildContext context) {
    person = ModalRoute.of(context)!.settings.arguments as Person;
    updatePersonController.nameController.text = person.name;
    updatePersonController.passwordController.text = person.password;

    return Scaffold(
      appBar: AppBar(
        title: const Text("EDITAR CADASTRO"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: updatePersonController.nameController,
                  decoration: const InputDecoration(
                    label: Text('Digite o nome'),
                  ),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  validator: validateNameField,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  controller: updatePersonController.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    label: Text('Digite a senha'),
                  ),
                  obscureText: true,
                  onEditingComplete: () => FocusScope.of(context).unfocus(),
                  validator: validatePasswordField,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        updatePerson(person);
                      }
                    },
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
