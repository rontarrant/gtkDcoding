// detect OS

import std.system;
import std.stdio;

import singleton.S_DetectedOS;

void main()
{
	S_DetectedOS s_detectedOS;
	
	s_detectedOS = s_detectedOS.get();
	s_detectedOS.getOS();
	
} // main()
