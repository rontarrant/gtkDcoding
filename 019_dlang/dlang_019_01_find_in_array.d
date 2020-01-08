// find a value in an array

import std.stdio;
import std.algorithm;

void main(string[] args)
{
	int[] intArray = [1, 5, 46, 3, 22, 10, 7];
	string[] stringArray = ["buzz", "fill", "hope", "negatory", "bobberdoodle"];
	long intIndex, stringIndex;
	int findVar = 22;
	
	intIndex = intArray.countUntil(22);
	writeln("intIndex: ", intIndex);
	intIndex = intArray.countUntil(findVar);
	writeln("intIndex: ", intIndex);
	
	stringIndex = stringArray.countUntil("negatory");
	writeln("stringIndex: ", stringIndex);
	
} // main()
