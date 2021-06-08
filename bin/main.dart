import "package:DesignPatternsWithDart/main.dart";

void main(List<String> arguments) {
	try {
		if (arguments[0] == "0") {
			runStrategyPattern();
		}
	} on RangeError {
		print("No arguments supplied.");
	}
}
