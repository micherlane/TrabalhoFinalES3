import 'package:cadastro_pessoa_app/model/pessoa.dart';
import 'package:cadastro_pessoa_app/service/pessoa_bd.dart';

class RemovePersonController {
  final PersonDatabase db = PersonDatabase();

  removePerson(Person person){
    db.delete(person.id);
  }
}