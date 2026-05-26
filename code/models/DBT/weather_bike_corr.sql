WITH CTE AS (
    SELECT 
    t.*
    FROM {{ ref('trip_fact') }} t
    LEFT JOIN {{ ref('daily_weather') }} w ON t.trip_date = w.trip_date
    LIMIT 10
)
SELECT * FROM CTE