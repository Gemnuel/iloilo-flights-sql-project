-- My Data Cleaning Project

-- create a copy of the original table
Create Table iloilo_flights2
LIKE iloilo_flights;

 -- insert all records into the copy
INSERT INTO iloilo_flights2
SELECT * FROM iloilo_flights;

-- adding column to the table
ALTER TABLE iloilo_flights2
ADD column passenger_capacity VARCHAR(255);

-- assign passenger capacity based on airline
UPDATE iloilo_flights2
SET passenger_capacity = CASE
WHEN airline = 'Skyjet' THEN 200
WHEN airline = 'Cebu Pacific' THEN 200
WHEN airline = 'Philippine Airlines' THEN 200
WHEN airline = 'PAL Express' THEN 200
WHEN airline = 'AirAsia' THEN 200
END;

-- checking if some column have null values so can replace or delete if data is critical
SELECT * FROM iloilo_flights2
WHERE airline AND airline AND departure_time AND status IS NULL;

-- Find duplicates
	SELECT f.flight_id, airline, COUNT(*) AS duplicate_count
	FROM iloilo_flights2  f
	JOIN iloilo_passengers p ON  f.flight_id = p.flight_id
	GROUP BY flight_id, airline
	HAVING COUNT(*) >= 1;
    
    -- Standardize data
    UPDATE iloilo_flights2
    SET airline = UPPER(airline);
    
    -- check if updated successfully
    SELECT * FROM iloilo_flights2;
    
    -- check if for pissile wrong value like the passenger_count is higher that passenger capacity and the ticket price is 0
    SELECT * FROM iloilo_flights2
    WHERE passenger_count > passenger_capacity OR ticket_price < 0;
    
    -- Fix incorrect values
    UPDATE iloilo_flights2
    SET status = 'ON TIME'
    WHERE status IN ('ontime','intime','On Time');
    
	-- Check if arrival_time is before departure_time (invalid)
    SELECT flight_id, arrival_time, departure_time
    FROM iloilo_flights2
    WHERE arrival_time < departure_time;
    
    