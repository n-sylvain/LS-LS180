SELECT d.name, p.part_number FROM devices AS d
INNER JOIN parts AS p
ON p.device_id = d.id;