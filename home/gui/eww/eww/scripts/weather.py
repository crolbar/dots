import sys
import requests
from subprocess import run

API_KEY = "aba36eff207740e0a5e234935232607"
CITY_NAME = "Silistra"
color = "#ffffff"

url = f"https://api.weatherapi.com/v1/current.json?key={API_KEY}&q={CITY_NAME}"
response = requests.get(url)
data = response.json()

temperature = data["current"]["temp_c"]
status = data["current"]["condition"]["text"]
icon = data["current"]["condition"]["code"]
wind_speed = data["current"]["wind_kph"]
is_day = data["current"]["is_day"]

if icon == 1000: icon = ""; color = "#ffb78a"
elif icon == 1003: icon = ""; color = "#b1e4eb"
elif icon == 1006: icon = ""; color = "#b1e4eb"
elif icon == 1009: icon = ""; color = "#b1e4eb"
elif icon == 1030: icon = ""; color = "#c9c9c9"
elif icon == 1063: icon = ""; color = "#83ace2"
elif icon == 1066: icon = ""; color = "#cad2db"
elif icon == 1069: icon = ""; color = "#83ace2"
elif icon == 1072: icon = ""; color = "#83ace2"
elif icon == 1087: icon = ""; color = "#eff0b3"
elif icon == 1114: icon = ""; color = "#cad2db"
elif icon == 1117: icon = ""; color = "#cad2db"
elif icon == 1135: icon = ""; color = "#c9c9c9"
elif icon == 1147: icon = ""; color = "#c9c9c9"
elif icon == 1150: icon = ""; color = "#83ace2"
elif icon == 1168: icon = ""; color = "#83ace2"
elif icon == 1171: icon = ""; color = "#83ace2"
elif icon == 1180: icon = ""; color = "#83ace2"
elif icon == 1183: icon = ""; color = "#83ace2"
elif icon == 1189: icon = ""; color = "#83ace2"
elif icon == 1192: icon = ""; color = "#83ace2"
elif icon == 1195: icon = ""; color = "#83ace2"
elif icon == 1198: icon = ""; color = "#83ace2"
elif icon == 1201: icon = ""; color = "#83ace2"
elif icon == 1204: icon = ""; color = "#83ace2"
elif icon == 1207: icon = ""; color = "#83ace2"
elif icon == 1210: icon = ""; color = "#b1e4eb"
elif icon == 1213: icon = ""; color = "#cad2db"
elif icon == 1216: icon = ""; color = "#b1e4eb"
elif icon == 1219: icon = ""; color = "#cad2db"
elif icon == 1222: icon = ""; color = "#cad2db"
elif icon == 1225: icon = ""; color = "#cad2db"
elif icon == 1237: icon = ""; color = "#cad2db"
elif icon == 1240: icon = ""; color = "#83ace2"
elif icon == 1243: icon = ""; color = "#83ace2"
elif icon == 1246: icon = ""; color = "#83ace2"
elif icon == 1249: icon = ""; color = "#83ace2"
elif icon == 1252: icon = ""; color = "#83ace2"
elif icon == 1255: icon = ""; color = "#cad2db"
elif icon == 1258: icon = ""; color = "#cad2db"
elif icon == 1261: icon = ""; color = "#cad2db"
elif icon == 1264: icon = ""; color = "#cad2db"
elif icon == 1273: icon = ""; color = "#eff0b3"
elif icon == 1276: icon = ""; color = "#eff0b3"
elif icon == 1279: icon = ""; color = "#eff0b3"
elif icon == 1282: icon = ""; color = "#eff0b3"

if is_day == 0:
    if icon == "": icon = ""; color = "#ffb78a"
    elif icon == "": icon = ""; color = "#b1e4eb"
    elif icon == "": icon = ""; color = "#83ace2"
    elif icon == "": icon = ""; color = "#83ace2"
    elif icon == "": icon = ""; color = "#83ace2"
    elif icon == "": icon = ""; color = "#83ace2"
    elif icon == "": icon = ""; color = "#83ace2"
    elif icon == "": icon = ""; color = "#b1e4eb"
    elif icon == "": icon = ""; color = "#b1e4eb"
    elif icon == "": icon = ""; color = "#83ace2"
    elif icon == "": icon = ""; color = "#83ace2"
    elif icon == "": icon = ""; color = "#83ace2"
    elif icon == "": icon = ""; color = "#83ace2"
    elif icon == "": icon = ""; color = "#83ace2"

if sys.argv[1] == "temp": print(f"{temperature} °C")
elif sys.argv[1] == "status": print(f"{status}")
elif sys.argv[1] == "wind": print(f"Wind: {wind_speed}km/h")
elif sys.argv[1] == "icon": print(icon)
elif sys.argv[1] == "icon-color": print (color)
elif sys.argv[1] == "day": print (is_day)
