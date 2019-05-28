module singleton.S_AccelGroup;

import std.stdio;

import gtk.AccelGroup;

class S_AccelGroup : AccelGroup
{
	private:
	// Cache instantiation flag in thread-local bool
	static bool instantiated_;

	// Thread global
	__gshared S_AccelGroup instance_;

	this()
	{
		super();

	} // this()

	public:
	
	static S_AccelGroup get()
	{
		write("getting...");
		
		if(!instantiated_)
		{
			synchronized(S_AccelGroup.classinfo)
			{
				if(!instance_)
				{
					instance_ = new S_AccelGroup();
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

} // class S_AccelGroup
