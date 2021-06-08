/*
- Strategy Pattern -

Instead of defining the functionality of the `User.showInfo` method,
it is instead delegating the functionality of the `showInfo` method of any
implementations of the `ShowInfoStrategy` interface.

So in case we want the child classes of the `User` to have a different
functionality for the `showInfo` method,
we would not need to override the `showInfo` method.
We could just instead assign the `User.showInfoStrategy`
to have a different "strategy" for the `showInfo` method.

The advantages of the strategy pattern over the purely inheritance approach, 
is that we will avoid repetitive code in case there are two child classes
of the `User` parent class that have an exactly the same `showInfo` method.
That just duplicated the code and das not good.
And the other cool thing about this is that we can change the value of the
`User.showInfoStrategy` at runtime so that means we can alter the behavior of
the classes while the program is still running.
*/

abstract class ShowInfoStrategy {
	void showInfo(User user);
}

class MinimalShowInfo implements ShowInfoStrategy {
	@override
  void showInfo(User user) {
		print("ID: ${user.id}\nName: ${user.name}");
	}
}

class FancyShowInfo implements ShowInfoStrategy {
	@override
  void showInfo(User user) {
		print("----- {${user.id}} -----\n${user.name} : ${user.username}\n<<< ${user.email} >>>");
	}
}

class User {
	int id;
	String name;
	String username;
	String email;
	ShowInfoStrategy showInfoStrategy;
	
	User.fromJSON(Map data) {
		id = data["id"];
		name = data["name"];
		username = data["username"];
		email = data["email"];
		showInfoStrategy = MinimalShowInfo();
	}
	
	void showInfo() {
		showInfoStrategy.showInfo(this);
	}
}

class FancyUser extends User {
	FancyUser.fromJSON(Map data) : super.fromJSON(data) {
		showInfoStrategy = FancyShowInfo();
	}
}
