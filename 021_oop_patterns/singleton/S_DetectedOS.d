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
		version(Win32)
		{
			_os_type = "Win32";
		}
		else version(Win64)
		{
			_os_type = "Win64";
		}
		else version(linux)
		{
			_os_type = "Linux";
		}
		else version(Android)
		{
			_os_type = "Android";
		}
		version(OSX)
		{
			_os_type = "Mac OSX";
		}
		else version(FreeBSD)
		{
			_os_type = "FreeBSD";
		}
		else version(NetBSD)
		{
			_os_type = "NetBSD";
		}
		else version(DragonFlyBSD)
		{
			_os_type = "DragonFlyBSD";
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
	
	
	void writeOS()
	{
		writeln("OS is: ", _os_type);
		
	} // writeOS()

} // class S_DetectedOS
