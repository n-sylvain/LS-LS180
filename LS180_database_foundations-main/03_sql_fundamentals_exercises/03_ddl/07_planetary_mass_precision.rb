ALTER TABLE planets
ALTER COLUMN mass
TYPE decimal(4,2) SET NOT NULL;

CHECK (mass > 0)
ALTER TABLE planets ALTER COLUMN designation SET NOT NULL;

# LS solution:

ALTER TABLE planets
ALTER COLUMN mass TYPE numeric,
ALTER COLUMN mass SET NOT NULL,
ADD CHECK (mass > 0.0),
ALTER COLUMN designation SET NOT NULL;