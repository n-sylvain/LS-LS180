ALTER TABLE planets
ADD COLUMN star_id integer 
REFERENCES stars(id)
;

ALTER TABLE planets
ALTER COLUMN star_id
SET NOT NULL
;

# LS solution:

ALTER TABLE planets
ADD COLUMN star_id integer NOT NULL REFERENCES stars (id);
