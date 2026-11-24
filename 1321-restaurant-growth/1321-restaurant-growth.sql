# Write your MySQL query statement below
WITH DailyTotals AS (
    SELECT 
        visited_on, 
        SUM(amount) AS daily_amount
    FROM Customer
    GROUP BY visited_on
),
MovingWindow AS (
    SELECT 
        visited_on,
        SUM(daily_amount) OVER (
            ORDER BY visited_on 
            RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW
        ) AS amount,
        ROUND(
            AVG(daily_amount) OVER (
                ORDER BY visited_on 
                RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW
            ), 
            2
        ) AS average_amount,
        MIN(visited_on) OVER () AS first_day
    FROM DailyTotals
)
SELECT 
    visited_on, 
    amount, 
    average_amount
FROM MovingWindow
WHERE visited_on >= DATE_ADD(first_day, INTERVAL 6 DAY)
ORDER BY visited_on;