import 'package:cadastro_pessoa_app/model/pessoa.dart';
import 'package:cadastro_pessoa_app/service/pessoa_bd.dart';
import 'package:flutter/material.dart';

class UpdatePersonController{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final PersonDatabase database = PersonDatabase();

  Person updatePerson(int id){
    Person person = Person(id, nameController.text, passwordController.text);
    database.update(person);
    return person;
  }
}