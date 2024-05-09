SELECT p.part_number, p.device_id FROM parts AS p
RIGHT OUTER JOIN devices AS d
ON p.device_id = d.id
;

SELECT p.part_number, p.device_id FROM parts AS p
JOIN devices AS d
ON p.device_id = d.id
WHERE p.device_id IS NOT NULL
;

SELECT part_number, device_id FROM parts
WHERE device_id IS NULL;