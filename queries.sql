-- Query 5a: All work items for customer Berger, Franz
SELECT o.order_no, o.data, o.plate, wi.description, wi.hours
FROM customer c
JOIN "order" o    ON c.cust_no  = o.cust_no
JOIN work_item wi ON c.order_no = wi.order_no
WHERE c.cust_name = 'Berger, Franz'
ORDER BY o.date, wi.item_no;

-- Query 5b: Total hours per mechanic in March 2026
SELECT m.mech_name,
   ROUND(SUM(wi.hours), 1)      AS total_hours,
   COUNT(DISTINCT wi.order_no)  AS orders
FROM mechanic m
JOIN work_item wi ON m.mech_id   = wi.mech_id
JOIN "order" o    ON wi.order_no = o.order_no
WHERE o.date BETWEEN '2026-03-01' AND '2026-03-31'
GROUP BY m.mech_id
ORDER BY total_hours DESC;

-- Variant 1: EXCEPT
-- Query 5c-1: Vehicles with no repair order
SELECT plate, model FROM vehicle
EXCEPT
SELECT v.plate, v.model FROM vehicle v
JOIN "order" o ON v.plate = o.plate;

-- Variant 2: NOT EXISTS
-- Query 5c-2: Vehicles with no repair order
SELECT plate, model FROM vehicle v
WHERE NOT EXISTS (
   SELECT 1 FROM "order" o
   WHERE o.plate = v.plate
);
