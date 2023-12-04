import 'package:cadastro_pessoa_app/service/pessoa_bd.dart';
import 'package:flutter/material.dart';

class AddPersonController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final PersonDatabase db = PersonDatabase();

  salvar() async {
    String name = nameController.text;
    String password = passwordController.text;

    await db.createPerson(name, password);
  }
}
