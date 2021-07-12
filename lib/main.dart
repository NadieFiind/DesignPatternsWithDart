import "dart:math";
import "dart:convert";
import "package:http/http.dart" as http;

// design patterns
import "patterns/strategy.dart" as strategy;
import "patterns/observer.dart" as observer;
import "patterns/decorator.dart" as decorator;
import "patterns/factory.dart" as factory_;

class HTTP {
	static final http.Client _client = http.Client();
	
	static Future get(String url) async {
		final uri = Uri.parse(url);
		final response = await _client.get(uri);
		return json.decode(response.body);
	}
	
	static Future put(String url, {Map body}) async {
		final response = await _client.put(
			Uri.parse(url),
			headers: {"Content-type": "application/json; charset=UTF-8"},
			body: json.encode(body)
		);
		
		return json.decode(response.body);
	}
	
	static void close() {
		_client.close();
	}
}

Future<void> runStrategyPattern() async {
	final data = await HTTP.get("https://jsonplaceholder.typicode.com/users");
	
	for (Map userData in data) {
		var user;
		
		if (Random().nextBool()) {
			user = strategy.User.fromJSON(userData);
		} else {
      user = strategy.FancyUser.fromJSON(userData);
			
      if (Random().nextBool()) {
        user.isStillFancy = false;
      }
      
      if (Random().nextBool()) {
        user.isStillFancy = true;
      }
		}
		
		user.showInfo();
		print("");
	}
	
	HTTP.close();
}

Future<void> runObserverPattern() async {
	final todo = observer.ToDoList("Observable To Do List");
	final watcher1 = observer.ToDoListWatcher();
	final watcher2 = observer.ToDoListWatcher();
	
	todo.register(watcher1);
	todo.register(watcher2);
	
	await todo.completeItem(69);
	
	HTTP.close();
}

Future<void> runDecoratorPattern() async {
	final db = decorator.Database();
	final logged_db = decorator.LoggedDatabase(decorator.Database());
	final cached_db = decorator.CachedDatabase(decorator.Database());
  final nice_db = decorator.CachedDatabase(
    decorator.LoggedDatabase(decorator.Database())
  );
  
  await db.get("users");
  await db.set("users", {"name": "XD"});
  
  await logged_db.get("posts");
  await logged_db.set("posts", {"title": "..."});
  
  print("");
  
  await cached_db.get("comments");
  await cached_db.set("comments", {"name": "69"});
  cached_db.printCache();
  
  print("");
  
  await nice_db.get("todos");
  await nice_db.set("todos", {"completed": true});
  
	HTTP.close();
}

Future<void> runFactoryPattern() async {
  final data = await HTTP.get("https://jsonplaceholder.typicode.com/users");
	final userFactory = factory_.UserFactory(5, 5);
  
	for (Map userData in data) {
		final user = userFactory.fromJSON(userData);
    
    if (user is factory_.VowelUser) {
      print("A new vowel user has been constructed. (${user.username})");
    } else {
      print("A new consonant user has been constructed. (${user.username})");
    }
	}
	
	HTTP.close();
}
