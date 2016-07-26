
/* TreeMap example query for ABMVIZ HTML5 */
/* Ben Stabler, ben.stabler@rsginc.com, 07/08/16 */

/* Set Scenario  */
ALTER USER [ATLANTAREGION\TAMConsult] WITH DEFAULT_SCHEMA = BS10

/* Creates SIMPLEMODES (simplified mode groupings) table */
IF EXISTS (SELECT * FROM sys.objects, sys.schemas WHERE sys.objects.schema_id=sys.schemas.schema_id and sys.objects.name = 'SimpleModes')
	BEGIN
		DROP TABLE SimpleModes
	END

CREATE TABLE SimpleModes (ModeName VARCHAR(50), SimpleModeName VARCHAR(50))
INSERT INTO SimpleModes VALUES ('DRIVEALONEFREE','AUTO')
INSERT INTO SimpleModes VALUES ('DRIVEALONEPAY','AUTO')
INSERT INTO SimpleModes VALUES ('SHARED2FREE','AUTO')
INSERT INTO SimpleModes VALUES ('SHARED2PAY','AUTO')
INSERT INTO SimpleModes VALUES ('SHARED3FREE','AUTO')
INSERT INTO SimpleModes VALUES ('SHARED3PAY','AUTO')
INSERT INTO SimpleModes VALUES ('WALK','NONMOTOR')
INSERT INTO SimpleModes VALUES ('BIKE','NONMOTOR')
INSERT INTO SimpleModes VALUES ('WALK_LOCAL','TRANSIT')
INSERT INTO SimpleModes VALUES ('WALK_PREMIUM','TRANSIT')
INSERT INTO SimpleModes VALUES ('DRIVE_LOCAL','TRANSIT')
INSERT INTO SimpleModes VALUES ('DRIVE_PREMIUM','TRANSIT')
INSERT INTO SimpleModes VALUES ('SCHOOL_BUS','SCHOOLBUS')

/* Trip mode share by simple modes with MAINGROUP, SUBGROUP, and QUANTITY 
in order to create the Tree Map (square pie chart) visual */  
SELECT SIMPLEMODENAME AS MAINGROUP, TRIP_MODE_NAME AS SUBGROUP, COUNT(TRIP_MODE_NAME) AS QUANTITY
FROM TRIPS, SIMPLEMODES
WHERE TRIPS.TRIP_MODE_NAME=SIMPLEMODES.MODENAME
GROUP BY SIMPLEMODENAME, TRIP_MODE_NAME 
ORDER BY SIMPLEMODENAME, TRIP_MODE_NAME	