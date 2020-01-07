module DetectedOS;

import std.stdio;

class S_DetectedOS
{
	private:
	string _os_type;
	static bool instantiated_;
	__gshared S_DetectedOS instance_;

	this()
	{
		version(Windows)
		{
			_os_type = "Windows";
		}
		else version(OSX)
		{
			_os_type = "OSX";
		}
		else version(Posix)
		{
			_os_type = "Posix";
		}

	} // this()


	public:
	static S_DetectedOS get()
	{
		if(!instantiated_)
		{
			synchronized(S_DetectedOS.classinfo)
			{
				if(!instance_)
				{
					instance_ = new S_DetectedOS();
				}

				instantiated_ = true;
			}
		}
		
		return(instance_);
		
	} // DetectedOS()
	
	
	string getOS()
	{
		writeln("returning: ", _os_type);
		return(_os_type);
		
	} // getOS()

} // class S_DetectedOS
