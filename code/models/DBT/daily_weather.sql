WITH daily_weather AS (
    SELECT 
        date(time) AS trip_date, 
        weather, 
        temp,
        pressure,
        humidity, 
        clouds
    FROM {{ source('demo','weather')}}
),
    daily_weather_agg AS (
        SELECT 
            trip_date,
            weather,
            ROUND(AVG(temp),2) AS avg_temp,
            ROUND(AVG(pressure),2) AS avg_pressure,
            ROUND(AVG(humidity),2) AS avg_humidity,
            ROUND(AVG(clouds),2) AS avg_clouds  
        FROM daily_weather
        GROUP BY trip_date, weather
        QUALIFY ROW_NUMBER() OVER (PARTITION BY trip_date ORDER BY COUNT(weather) DESC) = 1
    )


SELECT * FROM daily_weather_agg