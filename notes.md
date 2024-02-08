# notes
## What gui elements change?
* minimized windows appear in the desktop window menu, and stay on on dock.
* and no big icon. 
* menu interfaces with the global menu bar if you are using one, else it displays in app.
* same theme as the desktop.

## how is this different than gnustep/plugins-themes-Gtk?
the plugin has some shortcomings:
* still have big icon, but it only gets displayed when the application is minimized
* menu NSMacintoshInterfaceStyle sits on top of top bar when the app has the focus , the theme still doesn't match.


## what if?
Given:

the gtk theme holds a proxy gtk_window, with all control types instantiated. Then when it get's a request to
draw an nsobject, it gets the theme info from the corresponding control on the proxy and uses that to draw.

Then this internal proxy object could be further used to:
create a GtkAppIcon
create a GtkMenu 
then we can disable the NSAppIcon and don't display an NSMenu

the menu will either display in the app client window or publish to the global menu interface, like any Gtk application.


```c
GtkWidget *box;
GtkWidget *box1;
GtkWidget *box2;

box = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0); //change it to HORIZONTAL if need
box1 = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, 0);
box2 = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, 0);

gtk_box_pack_start(GTK_BOX(box),box1, TRUE, TRUE, 0);
gtk_box_pack_start(GTK_BOX(box),box2, TRUE, TRUE, 0);

gtk_widget_show(box1);
gtk_widget_show(box2);
gtk_widget_show(box);
```

```c
hbox = HBox()
window.add(hbox)
hbox.pack_start(widget1)
hbox.pack_start(widget2)
window.show_all()
```