
-----------------------
-- Debug
-----------------------

DELETE FROM BuildingPrereqs WHERE Building = "BUILDING_TERRACOTTA_ARMY";

UPDATE Buildings
SET Cost = 1, PrereqTech="TECH_POTTERY", AdjacentResource=NULL, AdjacentDistrict=NULL, PrereqCivic=NULL
WHERE BuildingType = "BUILDING_TERRACOTTA_ARMY";



INSERT INTO Building_ValidTerrains
		(BuildingType, 			TerrainType)
VALUES	("BUILDING_TERRACOTTA_ARMY",	"TERRAIN_PLAINS");

INSERT INTO Building_ValidTerrains
		(BuildingType, 			TerrainType)
VALUES	("BUILDING_TERRACOTTA_ARMY",	"TERRAIN_GRASS");