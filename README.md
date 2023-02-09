# Notification Center

## Getting Started

1. Setup log file owned by yourself
```bash
sudo touch /var/log/notification-center.log
sudo chown $(whoami):$(whoami) /var/log/notification-center.log
```

2. Install tiramisu (https://github.com/Sweets/tiramisu)
3. Install conky (https://github.com/brndnmtthws/conky) used for displaying the pop-ups

## Running the server

In whatever way fits your use case you will need to run two processes.

The `start-notify-center` binary and the `notify-listener` binary.

This could be done in your xinitrc or some other autostart script you are using.

## Previous notifications

Since all the notifications are stored in a log file, we are able to track all previous notifications.

There is a basic GTK applications available in the UI folder. This can be run like so:

```bash
python ./ui/notification-history.py
```

In my case I use this to create a Polybar module which displays if I have notifications that I missed.

```ini
[module/notifications]
type = custom/script
exec = cat /var/log/notification-center.log | wc -l
format-prefix = "NOT "
format-prefix-foreground = ${colors.primary}
label = "%output%"
click-left = python ~/dev/scripts/notify-center/ui/notification-history.py
click-right = truncate -s 0 /var/log/notification-center.log
interval = 5
```
