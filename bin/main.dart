import "package:main/main.dart";

void main(List<String> arguments) {
	try {
		switch (int.parse(arguments[0])) {
      case 0:
        runStrategyPattern();
        break;
      case 1:
        runObserverPattern();
        break;
      case 2:
        runDecoratorPattern();
        break;
      case 3:
        runFactoryPattern();
        break;
    }
	} on RangeError {
		print("No argument supplied.");
	}
}
