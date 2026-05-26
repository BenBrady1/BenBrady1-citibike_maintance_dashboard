WITH bike AS (
    SELECT DISTINCT
        start_station_id AS station_id,
        start_station_name AS station_name,
        start_lat as station_lat,
        start_lng as station_lng
    
    FROM 
        {{ ref('stg_bike') }}
    WHERE STARTED_AT != 'started_at' AND STARTED_AT != '"started_at"'
)

SELECT * FROM bike