#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import urllib2
import json

API_URL = "http://api.openweathermap.org/data/2.5/weather?q="

def kelvin_to_fahrenheit(temp):
    return (temp - 273.15) * 1.8 + 32

def weather_to_string(weather):
    temp = kelvin_to_fahrenheit(float(weather['main']['temp']))
    return u'\n%s: %.2f \xb0F (%s)' % (weather['name'], temp, weather['weather'][0]['description'])

def main():
    for location in sys.argv[1:]:
        weather_resp = urllib2.urlopen(API_URL + location)
        weather_data = json.loads(weather_resp.read())
        print weather_to_string(weather_data).encode('utf-8')

main()
