from enum import Enum
from flask import current_app as app
from sqlalchemy import Column, Integer, Float
from application.database import Base

class SensorType(Enum):
    Ambient_Light = 1
    Humidity = 2
    Temperature = 3
    Current = 4
    VOC = 5
    Air_Particles = 6

class MeasurementData(Base):
    __tablename__ = 'Measurements'
    id = Column(Integer, primary_key=True)
    SatelliteId = Column(Integer)
    Datetime = Column(Integer)
    MeasurementTypeId = Column(Integer)
    Value = Column(Float)

    def __init__(self, MeasurementTypeId=None):
        self.MeasurementTypeId = MeasurementTypeId.value

    def loadPowerFromDB(self):
        app.logger.info("Loading Power Data from DB")

    def getData(self):
        app.logger.info("Loading Power Data from DB")
        app.logger.info(self.MeasurementTypeId)
        return {
            "labels": ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
            "datasets": [
                {"label": "Sales", "data": [120, 150, 180, 220, 170, 200, 250], "borderColor": '#2563eb'},
                {"label": "Revenue", "data": [80, 130, 160, 210, 150, 190, 230], "borderColor": '#16a34a'}
            ]
        }

    def getChartData():
        pass