The database will be a SQL database with the following tables

- Satellite
    - Storing information regarding the satellite
- Room
    - Stores information regarding the rooms for display
- PowerCircuit
    - Stores information regarding the measured power circuits
- Measurements
    - Stores the measurements collected
- MeasurementType
    - Stores information regarding the type of the measurements, including name to display and units
- CurrentSensor
    - Stores information regarding the current sensors for data validation and visualization

## Satellite table
- Id
    - int
- RoomId
    - int
- UpstreamSatelliteId
    - int
- HasTemperature
    - TRUE/FALSE
- HasHumitity
    - TRUE/FALSE
- HasVOC
    - TRUE/FALSE
- HasAirParticle
    - TRUE/FALSE
- HasAmbientLight
    - TRUE/FALSE
- HasCurrent
    - TRUE/FALSE

## Room table
- Id
    - int
- Name
    - string

## PowerCircuit table
- Id
    - int
- Name
    - string
- RoomId
    - int

## Measurements table
- Id
    - UUID
- SatelliteId
    - int
- Datetime
    - UnixTimestamp Int
- MeasurementTypeId
    - int
- Value
    - float

## MeasurementType
- Id
    - 1
    - 2
    - 3
    - 4
    - 5
    - 6
- Name
    - "Ambient Light"
    - "Humitity"
    - "Temperature"
    - "Current"
    - "VOC" [TODO: Needs further investigation]
    - "Air Particle count"
- Units
    - "Lux"
    - "%"
    - "&deg;C"
    - "A"
    - [TODO]
    - "&mu;g/m<sup>3</sup>

## CurrentSensor table
- Id
    - int
- PowerCircuitId
    - int
- Rating
    - int
- SatelliteId
    - int
