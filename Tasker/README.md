# Tasker files that integrate with my home assistant.


### alarm_clock_on_hass_boot
Receives a message via "autoremote" fro Home Assistant on restart, to check for alarm. See command in 

### hass_alarm.xml:
Task that sends nex alarm time to Home Assisant. It has the `set %TEMPORARY to %arcomm` because it didn't trigger upon "request" from Home Assistant without. The profile that triggers sends variables, and nothing happened when I didn't use any of them.
