# My incorrect solution:

SELECT d.name, p.part_number FROM devices AS d
INNER JOIN parts AS p
ON p.device_id = d.id;

# LS solution

SELECT devices.name, COUNT(parts.device_id) FROM devices
LEFT OUTER JOIN parts ON devices.id = parts.device_id GROUP BY devices.name;