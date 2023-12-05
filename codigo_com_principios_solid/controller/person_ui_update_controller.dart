import '../interfaces/database_service.dart';
import '../model/pessoa.dart';

class PersonUIUpdateController {

  final DatabaseService databaseService;

  PersonUIUpdate(this.databaseService);

  Person updatePerson(Person person){
    Person person = this.databaseService.updatePerson(person);
    return person;
  }
}
  // A classe não mais trabalha diretamente recebendo 
  // as informações da interface, a classe recebe os dados e 
  // repassa para a interface databaseService; 
  // Ou seja, atua como apenas um intermediário entre as classe
  // entre a interface e o banco de dados;

  // Princípio OCP
  // Como a classe depende de uma abstração do serviço do banco de
  // dados, caso novos serviços de banco de dados sejam adicionados,
  // a classe não precisará sofrer modificações se forem adicionados um novo 
  // suporte de banco de dados. Isto é, ela está fechada
  // em termos de modificações mas aberta para extensão.