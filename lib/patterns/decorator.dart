/*
- Decorator Pattern -

This pattern might be hard to understand at first,
but once you get used to it, it's actually pretty simple.

The purpose of a decorator class is to extend or add a new functionality to an object
without changing anything to its structure.
This can be achieve by "decorating" or wrapping an object in a decorator.
Decorators can be stacked into many wrapping layers without creating any conflicts.
In order for this to happen, decorators must be the same type of the object
that they're decorating so that they can also be decorated by the other decorators
that also decorating the same object type.

Here I have a plain `Database` class that has some simple HTTP request methods.
I also have an abstract `DatabaseDecorator` class that decorates the `Database` class.
The typical implementation of decorator pattern is by implementing a
decorator abstract class to create multiple decorators for the same object.
But my implementation here is just extending the decorator class instead of implementing it.
It still works as expected so I guess it's fine.
*/

import "../main.dart";

class Database {
  final String _url = "https://jsonplaceholder.typicode.com/";
  
  Future get(String endpoint) async {
    return await HTTP.get("$_url$endpoint");
  }
  
  Future set(String endpoint, Map body) async {
    return await HTTP.put("$_url$endpoint", body: body);
  }
}

/// A decorator for `Database` objects.
abstract class DatabaseDecorator implements Database {
  final Database database;
  DatabaseDecorator(this.database);
  
  @override
  String get _url => database._url;
}

/// A decorator for `Database` objects that adds logging to its methods.
class LoggedDatabase extends DatabaseDecorator {
  LoggedDatabase(Database database): super(database);
  
  @override
  Future get(String endpoint) async {
    print("Getting data from endpoint `$endpoint`...");
    return await database.get(endpoint);
  }
  
  @override
  Future set(String endpoint, Map body) async {
    print("Setting data from endpoint `$endpoint`...");
    return await database.set(endpoint, body);
  }
}

/// A decorator for `Database` objects that adds caching to its network requests.
class CachedDatabase extends DatabaseDecorator {
  final Map<String, dynamic> _cache = {};
  
  CachedDatabase(Database database): super(database);
  
  @override
  Future get(String endpoint) async {
    _cache[endpoint] = await database.get(endpoint);
    return _cache[endpoint];
  }
  
  @override
  Future set(String endpoint, Map body) async {
    _cache[endpoint] = body;
    return await database.set(endpoint, body);
  }
  
  void printCache() {
    print(_cache);
  }
}
