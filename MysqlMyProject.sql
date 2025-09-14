-- This 3 tables  I used in this project
SELECT * FROM iloilo_flights;
SELECT * FROM iloilo_airlines;
SELECT * FROM iloilo_passengers;

-- problem Scenario1: Which airline has the most passengers?
SELECT a.airline_name, COUNT(p.passenger_id) AS total_passenger
FROM iloilo_flights f
JOIN iloilo_passengers p 
    ON f.flight_id = p.flight_id
JOIN iloilo_airlines a 
    ON f.airline = a.airline_name
GROUP BY a.airline_name
ORDER BY total_passenger DESC;

-- problem Scenario 2: Which airline has the most passengers affected by delayed flights?
-- using CTE Query
WITH Delayed_flight AS (
    SELECT f.flight_id, f.airline, f.status,
           COUNT(p.passenger_id) AS affected_passenger
    FROM iloilo_flights f
    JOIN iloilo_passengers p 
        ON f.flight_id = p.flight_id
    WHERE f.status = 'Delayed'
    GROUP BY f.flight_id, f.airline, f.status
)
SELECT airline,
       SUM(affected_passenger) AS total_affected,
       status AS their_status
FROM Delayed_flight
GROUP BY airline, status
ORDER BY total_affected DESC;

-- ranking airlines based on their Average Ticket Price
SELECT airline,
       AVG(ticket_price) AS avg_ticket_price,
       RANK() OVER (ORDER BY AVG(ticket_price) DESC) AS rank_of_airline
FROM iloilo_flights
GROUP BY airline
ORDER BY rank_of_airline ASC;

-- find flights with above-average passenger counts
SELECT flight_id, airline, passenger_count
FROM iloilo_flights
WHERE passenger_count > (
    SELECT AVG(passenger_count) FROM iloilo_flights
)
ORDER BY passenger_count DESC;

-- how many flights affected by cloudy and rainy condition flights
SELECT f.airline, aircraft_type,
       COUNT( f.flight_id) AS bad_condition_flights
FROM iloilo_flights f
WHERE f.weather_condition = 'Rainy' & 'Coudy'
GROUP BY f.airline
ORDER BY bad_condition_flights DESC;

-- total income of all airline
WITH ticket_prices AS (
    SELECT airline, flight_id, SUM(ticket_price) AS total_income
    FROM iloilo_flights
    GROUP BY airline, flight_id
)
SELECT airline, SUM(total_income) AS total_income_per_airline
FROM ticket_prices
GROUP BY airline
ORDER BY total_income_per_airline DESC;

-- cumulative flight revenue analysis using Window functions
SELECT airline, flight_id,ticket_price,
SUM(ticket_price) OVER (PARTITION BY airline ORDER BY ticket_price) AS rolling_prices
FROM iloilo_flights;
