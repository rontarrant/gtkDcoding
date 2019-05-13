import std.stdio;

void main()
{
	DSingleton singleton, singleton2, singleton3;
	
	writeln("\nInstantiating...\n");
	
	singleton = singleton.get();
	writeln("First singleton instantiated.\n");
	singleton2 = singleton.get();
	writeln("Second singleton instantiated.\n");
	singleton3 = singleton.get();
	writeln("Third singleton instantiated.\n\n");
			
	writeln("All instantiation is now done and we have:");
	
	writeln("1st singleton: ", singleton, " @ ", &singleton);
	writeln("2nd singleton: ", singleton2, " @ ", &singleton2);
	writeln("3rd singleton: ", singleton3, " @ ", &singleton3);
	
} // main()


class DSingleton
{
	private:
	// Cache instantiation flag in thread-local bool
	// Thread local
	static bool instantiated_;

	// Thread global
	__gshared DSingleton instance_;

	this()
	{
		
	} // this()

	public:
	
	static DSingleton get()
	{
		if(!instantiated_)
		{
			synchronized(DSingleton.classinfo)
			{
				if(!instance_)
				{
					instance_ = new DSingleton();
					write("Creating the singleton and");
				}

				instantiated_ = true;
			}
		}
		else
		{
			write("Singleton already exists, so just");
		}

		writeln(" returning an instance.");
		
		return(instance_);
		
	} // DSingleton()

} // class DSingleton
