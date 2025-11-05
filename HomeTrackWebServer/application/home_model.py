# Model for the data to show on the home page of the application
import time

def getRooms():
    return {"Rooms":['Room1', 'Room2', 'Room3']}

def getPowerDataByRoom(room):
    
    return {
        "labels":[1, 2, 3, 4, 5, 6, 7],
        "datasets": [
            {"label": 'Room1', "data": [80, 130, 160, 210, 150, 190, 230], "borderColor": "#12b83c"},
            {"label": 'Room2', "data": [120, 150, 180, 220, 170, 200, 250], "borderColor": '#121db8'},
            {"label": 'Room3', "data": [120, 150, 180, 220, 170, 200, 250], "borderColor": "#a31639"}
        ]
    }

def getTime():
    return {"time": time.time()}

def getHomeSettings():
    return{
        "Rooms": ['Room1', 'Room2', 'Room3']
    }