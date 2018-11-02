# Scripts used in appdaemon. 

Due to the sensitive information in some of them, they are not in the main Home Assistant repo, but some are here with sensitive information redacted.

To find your AutoRemote URL, open the app, nativate the the link shown. Type something into the `message`box, and the full URL will be shown in the box on the right side. Copy this, and use for sending from Home Assistant to Tasker.

Where I have written `SECRET_AUTOREMOTE_URL_MESSAGE` it should be a long URL starting with `https://autoremotejoaomgcd.appspot.com/sendmessage?key=` and ending with `&message=` (the `message` part is also found in my example script).
