import '../model/pessoa.dart';

abstract class DatabaseService {
  Future<int> createPerson(String name, String password);
  Future<int> updatePerson(Person person);
  Future<int> deletePerson(int id);
  Future<List<Person>> getPersons();
}
// Princípio do Aberto/Fechado
// Ao invés de trabalhar diretamente com uma implementação 
// concreta, está sendo utilizado uma interface (abstract class do dart)
// para definir as operações principais. 