import "dart:math";
import "dart:convert";
import "package:http/http.dart" as http;
import "patterns/strategy.dart" as strategy;

class HTTP {
	static final http.Client _client = http.Client();
	
	static Future get(String url) async {
		final uri = Uri.parse(url);
		final response = await _client.get(uri);
		return json.decode(response.body);
	}
	
	static void close() {
		_client.close();
	}
}

Future<void> runStrategyPattern() async {
	final data = await HTTP.get("https://jsonplaceholder.typicode.com/users");
	
	for (Map userData in data) {
		strategy.User user;
		
		if (Random().nextBool()) {
			user = strategy.User.fromJSON(userData);
		} else {
			user = strategy.FancyUser.fromJSON(userData);
		}
		
		user.showInfo();
		print("");
	}
}
