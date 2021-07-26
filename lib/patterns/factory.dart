/*
- Factory Pattern -

The factory pattern hides the creation logic
of the objects to the client for more abstraction.
It is useful if we want to create an object but we don't exactly know what type it is.
My implementation of it is pretty simple and straightforward.

There's a factory class called `UserFactory`.
It creates the instances of the subclasses of the
`User` abstract class by using the `fromJSON` factory method.
It also controls how many `User` instances can be created.
*/

class UserFactory {
  final int vowelUserLimit;
  final int consonantUserLimit;
  int vowelUsers = 0;
  int consonantUsers = 0;
  
  UserFactory(this.vowelUserLimit, this.consonantUserLimit);
  
  User fromJSON(Map data) {
    if (_isVowel(data["username"][0])) {
      vowelUsers++;
      if (vowelUsers >= vowelUserLimit) throw "Vowel Users Exceeded";
      return VowelUser.fromJSON(data);
    }
    
    consonantUsers++;
    if (consonantUsers >= consonantUserLimit) throw "Consonant Users Exceeded";
    return ConsonantUser.fromJSON(data);
  }
  
  static bool _isVowel(String char) => "aeiouAEIOU".contains(char);
}

abstract class User {
  int id;
  String name;
  String username;
  String email;
  
  User.fromJSON(Map data) {
    id = data["id"];
    name = data["name"];
    username = data["username"];
    email = data["email"];
  }
}

class VowelUser extends User {
  VowelUser.fromJSON(Map data): super.fromJSON(data);
}

class ConsonantUser extends User {
  ConsonantUser.fromJSON(Map data): super.fromJSON(data);
}
