import 'package:cadastro_pessoa_app/model/pessoa.dart';
import 'package:cadastro_pessoa_app/service/pessoa_bd.dart';
import 'package:flutter/material.dart';

class PersonListView extends StatefulWidget {
  const PersonListView({super.key});

  @override
  State<PersonListView> createState() => _PersonListViewState();
}

class _PersonListViewState extends State<PersonListView> {
  PersonDatabase db = PersonDatabase();
  late Future<List<Person>> listPerson;

  @override
  void initState() {
    super.initState();
    listPerson = db.getPersons();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void refresh() {
    setState(() {
      listPerson = db.getPersons();
    });
  }

  Widget _getCardWidget(BuildContext context, Person person) {
    return Container(
      margin: const EdgeInsets.only(top: 4, left: 4, right: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(8)
      ),
      child: ListTile(
        leading: Icon(
          Icons.person_2_sharp,
          size: 50,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          person.name,
          style: TextStyle(fontSize: 25, color: Colors.grey.shade700),
        ),
        onTap: () {
          _navigationDetailsView(person);
        },
      ),
    );
  }

  void _navigationAddPersonView() {
    Navigator.pushNamed(context, 'add-person-view').then((value) => refresh());
  }

  void _navigationDetailsView(Person person) {
    Navigator.pushNamed(context, 'details-person-view', arguments: person)
        .then((value) => refresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PESSOAS CADASTRADAS'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: listPerson,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (snapshot.hasData) {
            return snapshot.data != null && snapshot.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      Person? person = snapshot.data![index];
                      return _getCardWidget(context, person!);
                    },
                  )
                : const Center(child: Text('Não há contatos para mostrar.'));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 121, 135, 1),
              borderRadius: BorderRadius.circular(25)),
          child: IconButton(
            onPressed: _navigationAddPersonView,
            color: Colors.white,
            iconSize: 40,
            icon: const Icon(Icons.person_add_rounded),
          )),
    );
  }
}
