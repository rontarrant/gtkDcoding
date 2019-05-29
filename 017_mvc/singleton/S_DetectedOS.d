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
		version(win32)
		{
			_os_type = "win32";
		}
		else version(win64)
		{
			_os_type = "win64";
		}
		else version(linux)
		{
			_os_type = "linux";
		}
		else version(android)
		{
			_os_type = "Android";
		}
		else version(osx)
		{
			_os_type = "Mac OSX";
		}
		else version(freeBSD)
		{
			_os_type = "FreeBSD";
		}
		else version(netBSD)
		{
			_os_type = "NetBSD";
		}
		else version(dragonFlyBSD)
		{
			_os_type = "DragonFlyBSD";
		}
		else version(otherPosix)
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
		return(_os_type);
		
	} // getOS()

} // class S_DetectedOS
