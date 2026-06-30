CREATE DATABASE IndianFuelAnalytics;

USE IndianFuelAnalytics;

--1. Verify the Data

select * from Fuel_sales;

select * from fuel_prices;

select * from fuel_stations;

select * from targets;

select count(*) as total_transactions from fuel_sales;


--2. Understand the Data
-- Business Question 1

-- Which states are present?

select distinct state from fuel_sales;

-- Which cities?

select distinct city from fuel_sales;

-- Which fuel types?

select distinct fuel_type from fuel_sales;

-- Which payment modes?

select distinct payment_mode from fuel_sales;


--3. Business Question 2

-- Which state generated the highest revenue?

SELECT
    State,
    SUM(Revenue) AS Total_Revenue
FROM Fuel_Sales
GROUP BY State
ORDER BY Total_Revenue DESC;

--4. Business Question 3

--Which customer type generates more revenue?

SELECT
    City,
    SUM(Revenue) AS Total_Revenue
FROM Fuel_Sales
GROUP BY City
ORDER BY Total_Revenue DESC;

--5. Business Question 4

--Which city generated the highest revenue?

select city, max(revenue) as revenue
from fuel_sales
group by city
order by revenue desc;

--6. Business Question 5

--Average Fuel Price

select fuel_type, avg(price_per_litre) as AvgPrice
from fuel_sales
group by fuel_type;

--7. Business Question 6

--Highest Revenue Transaction

SELECT TOP 1 *
FROM Fuel_Sales
ORDER BY Revenue desc;

--8. Business Question 7

--Which fuel type contributes the highest revenue?

select fuel_type, sum(revenue) as total_revenue
from fuel_sales
group by fuel_type
order by total_revenue desc;

--9. Business Question 8

-- Which customer type generates more revenue?

select customer_type, sum(revenue) as total_revenue
from fuel_sales
group by customer_type
order by total_revenue desc;

--10. Business Question 9

-- What is the monthly revenue trend?

with monthlyrevenue as
(
select
month(date) as month_no,
sum(revenue) as total_revenue
from fuel_sales
group by month(date)
)
select * from monthlyrevenue
order by month_no;

--11. Business Question 10

--Which stations generated more than ₹2,00,000 revenue?

select station_id, sum(revenue) as total_revenue
from fuel_sales
group by station_id
having sum(revenue) > 200000
order by total_revenue desc;

--12. Business Question 11

-- Show transaction details with station names.

select 
fs.Transaction_ID,
    st.Station_Name,
    fs.City,
    fs.Fuel_Type,
    fs.Revenue
    from fuel_sales fs
    inner join fuel_stations st
    on fs.station_id = st.station_id;

--13. Business Question 11

--Which stations don't have target information?

SELECT
    st.Station_ID,
    st.Station_Name
FROM Fuel_Stations st
LEFT JOIN Targets t
ON st.Station_ID = t.Station_ID
WHERE t.Station_ID IS NULL;
    
--14. Business Question 12

--Compare actual revenue with target.

SELECT
    fs.Station_ID,
    SUM(fs.Revenue) AS Actual_Revenue,
    t.Monthly_Target,
    SUM(fs.Revenue)-t.Monthly_Target AS Difference
FROM Fuel_Sales fs
INNER JOIN Targets t
ON fs.Station_ID=t.Station_ID
GROUP BY
    fs.Station_ID,
    t.Monthly_Target;

--15. Business Question 13

--Classify station performance

SELECT
    fs.Station_ID,
    SUM(fs.Revenue) AS Revenue,
    t.Monthly_Target,
    CASE
        WHEN SUM(fs.Revenue)>=t.Monthly_Target THEN 'Target Achieved'
        ELSE 'Target Not Achieved'
    END AS Performance
FROM Fuel_Sales fs
INNER JOIN Targets t
ON fs.Station_ID=t.Station_ID
GROUP BY
    fs.Station_ID,
    t.Monthly_Target;

--16. Business Question 14

--Which payment mode generated the highest revenue?

SELECT
    Payment_Mode,
    SUM(Revenue) AS Total_Revenue
FROM Fuel_Sales
GROUP BY Payment_Mode
ORDER BY Total_Revenue DESC;

--17. Business Question 15

--What is the average fuel price?

SELECT
    Fuel_Type,
    AVG(Price_Per_Litre) AS Average_Price
FROM Fuel_Sales
GROUP BY Fuel_Type;

--18. Business Question 16

--Top 5 stations by revenue

SELECT TOP 5
    Station_ID,
    SUM(Revenue) AS Total_Revenue
FROM Fuel_Sales
GROUP BY Station_ID
ORDER BY Total_Revenue DESC;

--19. Business Question 17

-- Total business summary

SELECT
    COUNT(*) AS Total_Transactions,
    SUM(Quantity_Litres) AS Total_Quantity,
    SUM(Revenue) AS Total_Revenue,
    AVG(Price_Per_Litre) AS Average_Price
FROM Fuel_Sales;

--20. Business Question 18

--Lowest Revenue Transaction

SELECT TOP 1 *
FROM Fuel_Sales
ORDER BY Revenue asc;

--21. Business Question 19

--Total Revenue

select sum(revenue)
as TotalRevenue
from fuel_sales;

