module singleton.SingletonAccelGroup;

import std.stdio;

import gtk.AccelGroup;

class SingletonAccelGroup : AccelGroup
{
	private:
	// Cache instantiation flag in thread-local bool
	static bool instantiated_;

	// Thread global
	__gshared SingletonAccelGroup instance_;

	this()
	{
		super();

	} // this()

	public:
	
	static SingletonAccelGroup get()
	{
		write("getting...");
		
		if(!instantiated_)
		{
			synchronized(SingletonAccelGroup.classinfo)
			{
				if(!instance_)
				{
					instance_ = new SingletonAccelGroup();
					writeln("creating");
				}

				instantiated_ = true;
			}
		}
		else
		{
			writeln("not created");
		}

		return(instance_);
		
	} // get()

} // class SingletonAccelGroup
