// an array of classes

import std.stdio;
import std.typecons;
import std.variant;

struct Result
{
	string itemName;
	int quantity;
	bool needIt;
	
} // struct Result


class GroceryItem
{
	private:
	bool _needIt;
	int _quantity;
	string _itemName;
	
	public:
	this(string itemName, int quantity, bool needIt)
	{
		_itemName = itemName;
		_quantity = quantity;
		_needIt = needIt;
		
	} // this()
	
	
	Variant getVariant()
	{
		return(cast(Variant)tuple(_itemName, _quantity, _needIt)); // use with a Variant return type

	} // getVariant()


	Tuple!(string, int, bool) getTuple()
	{
		return(tuple(_itemName, _quantity, _needIt)); // use with a Tuple!(string, int, bool) return type
		
	} // getTuple()


	Result getStruct()
	{
		Result result = {_itemName, _quantity, _needIt};
		
		return(result);

	} // getStruct()


	void set(bool needIt)
	{
		_needIt = needIt;
		
	} // set()
	
} // class GroceryItem


void main(string[] args)
{
	GroceryItem[] groceryList;
	
	GroceryItem item1 = new GroceryItem("Paper Towels", 1, true);
	groceryList ~= item1;
	GroceryItem item2 = new GroceryItem("Bread", 2, true);
	groceryList ~= item2;
	GroceryItem item3 = new GroceryItem("Butter", 1, false);
	groceryList ~= item3;
	GroceryItem item4 = new GroceryItem("Milk", 1, true);
	groceryList ~= item4;
	GroceryItem item5 = new GroceryItem("Potato Chips", 3, false);
	groceryList ~= item5;
	GroceryItem item6 = new GroceryItem("Pickles", 4, true);
	groceryList ~= item6;
	
	writeln("variants:");
	
	foreach(groceryItem; groceryList)
	{
		writeln(groceryItem.getVariant());
	}

	writeln("tuples:");
	
	foreach(groceryItem; groceryList)
	{
		writeln(groceryItem.getTuple());
	}

	writeln("structs:");
	
	foreach(groceryItem; groceryList)
	{
		writeln(groceryItem.getStruct());
	}

} // main()
