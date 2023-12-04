import 'package:cadastro_pessoa_app/view/add_person_view.dart';
import 'package:cadastro_pessoa_app/view/detail_person_view.dart';
import 'package:cadastro_pessoa_app/view/edit_person_view.dart';
import 'package:cadastro_pessoa_app/view/persons_list_view.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: const PersonListView(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromRGBO(255, 121, 135, 1),
      )),
      routes: {
        "add-person-view": (context) => const AddPersonView(),
        "details-person-view": (context) => const DetailsPersonView(),
        "update-person-view": (context) => const UpdatePersonView()
      },
    ),
  );
}
