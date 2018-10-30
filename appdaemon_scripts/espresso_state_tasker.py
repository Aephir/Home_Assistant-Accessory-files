import appdaemon.plugins.hass.hassapi as hass
import requests

class NotifyTasker(hass.Hass):

  def initialize(self):
    self.listen_state(self.espresso_on,self.args["entityID"], new="on")
    self.listen_state(self.espresso_off,self.args["entityID"], new="off")

  def espresso_on (self, entity, attribute, old, new, kwargs):
    requests.get('SECRET_AUTOREMOTE_URL_MESSAGE=espresso_machine_state_is=:=on')

  def espresso_off (self, entity, attribute, old, new, kwargs):
    requests.get('SECRET_AUTOREMOTE_URL_MESSAGE=espresso_machine_state_is=:=off')
