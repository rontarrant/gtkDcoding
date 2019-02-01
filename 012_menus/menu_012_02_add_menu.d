// rewrite to demo adding an actual menu

import gtk.MainWindow;
import gtk.Box;
import gtk.Main;
import gtk.Menu;
import gtk.MenuBar;
import gtk.MenuItem;
import gtk.Widget;
import gdk.Event;

void main(string[] args)
{
    Main.init(args);
    MainWindow win = new MainWindow("MenuBar Example");
    win.setDefaultSize(250, 200);
  
    MenuBar menuBar = new MenuBar();  
    menuBar.append(new FileMenuItem());
 
    Box box = new Box(Orientation.VERTICAL, 10);
    box.packStart(menuBar, false, false, 0);
 
    win.add(box);
    win.showAll();
    Main.run();
}

class FileMenuItem : MenuItem
{
    Menu fileMenu;
    MenuItem exitMenuItem;
   
    this()
    {
        super("File");
        fileMenu = new Menu();
       
        exitMenuItem = new MenuItem("Exit");
        exitMenuItem.addOnButtonRelease(&exit);
        fileMenu.append(exitMenuItem);
       
        setSubmenu(fileMenu);
    }
   
    bool exit(Event event, Widget widget)
    {
        Main.quit();
        return true;
    }
}
