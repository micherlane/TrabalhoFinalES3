class Person {
  late int id;
  late String name;
  late String password;

  Person(this.id, this.name, this.password);

  Map<String, dynamic> getPersonData() {
    return {"id": id, "name": name, "password": password};
  }

  Person.fromMapObject(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    password = map['password'];
  }
}
