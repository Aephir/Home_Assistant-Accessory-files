import appdaemon.plugins.hass.hassapi as hass
import requests

class NotifyTasker(hass.Hass):

  def initialize(self):
    self.listen_state(self.basement_door_opened,"binary_sensor.door_window_sensor_158d00022b3b66", new="on")
    self.listen_state(self.front_door_opened,"binary_sensor.door_window_sensor_158d00022d0917", new="on")
    self.listen_state(self.conservatory_door_opened,"binary_sensor.door_window_sensor_158d000234dc7b", new="on")

    # self.listen_state(self.espresso_off,self.args["entityID"], new="off")

  def basement_door_opened (self, entity, attribute, old, new, kwargs):
    requests.get('SECRET_AUTOREMOTE_URL_MESSAGEmessage=latest_notification_is=:=Basement')

  def front_door_opened (self, entity, attribute, old, new, kwargs):
    requests.get('SECRET_AUTOREMOTE_URL_MESSAGEmessage=latest_notification_is=:=Front')

  def conservatory_door_opened (self, entity, attribute, old, new, kwargs):
    requests.get('SECRET_AUTOREMOTE_URL_MESSAGEmessage=latest_notification_is=:=Conservatory')
