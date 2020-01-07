module S_FontList;

import std.stdio;

import pango.PgCairoFontMap;
import pango.PgFontMap;
import pango.PgFontFamily;

class S_FontList
{
	private:
	PgFontMap _pgFontMap;
	PgFontFamily[] _pgFontFamilies;
	static bool instantiated_;
	__gshared S_FontList instance_;

	this()
	{
		_pgFontMap = PgCairoFontMap.getDefault();
		_pgFontMap.listFamilies(_pgFontFamilies); // list goes into the _pgFontFamilies array

	} // this()


	public:
	static S_FontList get()
	{
		if(!instantiated_)
		{
			synchronized(S_FontList.classinfo)
			{
				if(!instance_)
				{
					instance_ = new S_FontList();
				}

				instantiated_ = true;
			}
		}
		
		return(instance_);
		
	} // get()


	PgFontFamily[] getFontFamilyList()
	{
		return(_pgFontFamilies);
		
	} // getFontFamilyList()
	

	void listFonts()
	{
		writeln("A list of all fonts available to Pango on this computer:");

		foreach(PgFontFamily font; _pgFontFamilies)
		{
			writeln(font.getName());
			
		}	
		
	} // listFonts()
	
} // class S_FontList

