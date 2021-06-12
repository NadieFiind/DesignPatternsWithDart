import "package:main/main.dart";

void main(List<String> arguments) {
	try {
		final arg = arguments[0];
		
		if (arg == "0") {
			runStrategyPattern();
		} else if (arg == "1") {
			runObserverPattern();
		}
	} on RangeError {
		print("No argument supplied.");
	}
}
