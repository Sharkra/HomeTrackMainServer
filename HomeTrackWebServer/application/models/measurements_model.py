from enum import Enum
from flask import current_app as app
from sqlalchemy import select
from sqlalchemy.orm import Mapped, mapped_column,Session
from application.database import Base, engine

class SensorType(Enum):
    Ambient_Light = 1
    Humidity = 2
    Temperature = 3
    Current = 4
    VOC = 5
    Air_Particles = 6

class MeasurementData(Base):
    __tablename__ = 'Measurements'
    id: Mapped[int] = mapped_column(primary_key=True)
    SatelliteId: Mapped[int] = mapped_column
    Datetime: Mapped[int] = mapped_column
    MeasurementTypeId: Mapped[int] = mapped_column
    Value: Mapped[float]= mapped_column

    def __init__(self, MeasurementTypeId=None):
        self.MeasurementTypeId = MeasurementTypeId.value

    def __repr__(self):
        return f'<Id {self.id!r}> <SatelliteId {self.SatelliteId!r}> <Datetime {self.Datetime!r}> <Value {self.Value!r}>'

    def loadPowerFromDB(self):
        app.logger.info("Loading Power Data from DB")
        with Session(engine) as session:
            result = session.execute(select(MeasurementData).filter_by(MeasurementTypeId=self.MeasurementTypeId))
            print(result.all())
        return result

    def getData(self):
        app.logger.info("Retrieving Power Data from Model")
        app.logger.info(self.MeasurementTypeId)
        data = self.loadPowerFromDB()
        return {
            "labels": ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
            "datasets": [
                {"label": "Sales", "data": [120, 150, 180, 220, 170, 200, 250], "borderColor": '#2563eb'},
                {"label": "Revenue", "data": [80, 130, 160, 210, 150, 190, 230], "borderColor": '#16a34a'}
            ]
        }

    def getChartData():
        pass