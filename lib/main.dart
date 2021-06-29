import "dart:math";
import "dart:convert";
import "package:http/http.dart" as http;

// design patterns
import "patterns/strategy.dart" as strategy;
import "patterns/observer.dart" as observer;

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
	
	HTTP.close();
}
