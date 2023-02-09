#!/usr/bin/env python

import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

def find_notification(line: str, name) -> str:
    before=line.partition(f"{name}=[")[2]
    return before.partition("]")[0]

class NotificationWindow(Gtk.Window):
    def __init__(self) -> None:
        super().__init__(title="Notifications")

        self.set_border_width(10)
        self.set_default_size(640, 300)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_resizable(False)
        self.stick()

        frame = Gtk.Frame(label="Notifications")
        box = Gtk.FlowBox(
            max_children_per_line=1,
            row_spacing=0,
            column_spacing=0,
            selection_mode=Gtk.SelectionMode.NONE,
            homogeneous=True
        )
        box.set_homogeneous(True)

        with open("/var/log/notification-center.log", "r") as f:
            for line in reversed(f.readlines()):
                source = find_notification(line, "source")
                summary = find_notification(line, "summary")
                body = find_notification(line, "body")
                label = Gtk.Label(label=f"{source} - {summary}\n{body}")
                label.set_line_wrap(True)
                label.set_size_request(250, -1)
                label.set_max_width_chars(40)
                label.set_xalign(0)
                box.insert(
                    widget=label,
                    position=0,
                )

        self.add(frame)
        frame.add(box)

notification_window = NotificationWindow()
notification_window.connect("destroy", Gtk.main_quit)
notification_window.show_all()
Gtk.main()
