

UPDATE ModifierArguments
SET Value = Value * 3
WHERE Name = "Amount" AND ModifierId = "PYRAMID_GRANT_BUILDERS";

UPDATE ModifierArguments
SET Value = Value * 3
WHERE Name = "Amount" AND ModifierId = "COLOSSUS_GRANT_TRADER";

UPDATE ModifierArguments
SET Value = Value * 3
WHERE Name = "Amount" AND ModifierId = "HALICARNASSUS_GRANT_ADMIRAL";

UPDATE ModifierArguments
SET Value = Value * 3
WHERE Name = "Amount" AND ModifierId = "KOTOKU_GRANTMONKS";

UPDATE ModifierArguments
SET Value = Value * 3
WHERE Name = "Amount" AND ModifierId = "MEENAKSHITEMPLE_FREE_GURU";

UPDATE ModifierArguments
SET Value = Value * 3
WHERE Name = "Amount" AND ModifierId LIKE "STAUEZEUS_GRANT_%";

