/*
- Singleton Pattern -

The `Database` class can only be instantiated once.
Its constructor is private because the creation
of its instance is hidden from the clients.
All the clients know is that they can access the global instance of that class
by using the `Database.instance` getter.

The singleton pattern is useful when exactly one object is needed.
*/

import "../main.dart";

class Database {
  /// The global instance of this class.
  static Database _instance;
  
  /// Get the global instance of this class.
  static Database get instance => _instance ??= Database._();
  
  Database._();
  
  Future<User> getUser(int id) async {
    final Map<String, dynamic> userData = (await HTTP.get(
      "https://jsonplaceholder.typicode.com/users?id=$id"
    ))[0];
    return User.fromJSON(userData);
  }
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  
  User.fromJSON(Map<String, dynamic> data):
    id = data["id"],
    name = data["name"],
    username = data["username"],
    email = data["email"];
  
  @override
  String toString() => "[$id] $username: $email";
}
