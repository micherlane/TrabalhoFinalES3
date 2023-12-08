import 'package:cadastro_pessoa_app/controller/remove_person_controller.dart';
import 'package:cadastro_pessoa_app/model/pessoa.dart';
import 'package:flutter/material.dart';

class DetailsPersonView extends StatefulWidget {
  const DetailsPersonView({super.key});

  @override
  State<DetailsPersonView> createState() => _DetailsPersonViewState();
}

class _DetailsPersonViewState extends State<DetailsPersonView> {
  final RemovePersonController _removePersonController =
      RemovePersonController();
  late Person person;

  Widget _getContainerTitle(String title) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _getContainerInfomation(String information) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(255, 121, 135, 1)),
      ),
      height: 60,
      child: Text(information,
          style: TextStyle(fontSize: 24, color: Colors.grey.shade700)),
    );
  }

  void _alertToolbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color.fromRGBO(255, 121, 135, 1),
      content: Text(message),
      duration: const Duration(milliseconds: 1000),
    ));
  }

  void _removePerson() {
    _removePersonController.removePerson(person);
    _alertToolbar('Contato removido com sucesso!');
    Navigator.pop(context);
  }

  void _updateFields(Person personUpdated) {
    setState(() {
      person.name = personUpdated.name;
      person.password = personUpdated.password;
    });
  }

  void _navigateUpdatePerson() async {
    final personUpdated = await Navigator.pushNamed(
        context, 'update-person-view',
        arguments: person) as Person;
    _updateFields(personUpdated);
  }

  @override
  Widget build(BuildContext context) {
    person = ModalRoute.of(context)!.settings.arguments as Person;

    return Scaffold(
        appBar: AppBar(
          title: const Text('DETALHES'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _navigateUpdatePerson,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: _removePerson,
              icon: const Icon(Icons.delete),
            )
          ],
        ),
        body: Column(
          children: [
            _getContainerTitle('Nome'),
            _getContainerInfomation(person.name),
            _getContainerTitle('Senha'),
            _getContainerInfomation(person.password)
          ],
        ));
  }
}
