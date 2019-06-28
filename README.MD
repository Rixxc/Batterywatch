# Batterywatch

Just a simple script to check the battery level, which also works with multiple batteries.

### CRON

The cronjob could look something like this:

```bash
*/1 * * * * export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus; export DISPLAY=:0; /opt/batterywatch/batterywatch.sh
```