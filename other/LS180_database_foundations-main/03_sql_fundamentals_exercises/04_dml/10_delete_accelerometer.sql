ALTER TABLE parts
DROP CONSTRAINT IF EXISTS parts_device_id_fkey,
ADD CONSTRAINT parts_device_id_fkey
FOREIGN KEY (device_id) REFERENCES devices(id) ON DELETE CASCADE;

DELETE FROM parts WHERE device_id = 1;

SELECT d.name, d.created_at, p.part_number, p.device_id from devices AS d
FULL JOIN parts AS p
ON d.id = p.device_id;

