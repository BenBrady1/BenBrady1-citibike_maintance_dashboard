--BELOW IS THE SCRIPT USED IN SNOWFLAKE TO CREATE THE BIKES TABLE
--THE TABLE WAS DOWNLOADED FROM CITIBIKE IN TWO BATCHES: 2016 & 2019

--2016 DATA--
--Create Stage
CREATE STAGE DEMO.DEMO_SCHEMA.BIKE16;
--Import from local host using SNOWSQL
--Verify
SELECT * FROM DEMO.DEMO_SCHEMA.BIKE16

--Create table
CREATE OR REPLACE TABLE demo.demo_schema.bikes(
    ride_id STRING,
    started_at STRING,
    ended_at STRING,
    start_station_name STRING,
    start_station_id STRING,
    end_station_name STRING,
    end_station_id STRING,
    start_lat STRING,
    start_lng STRING,
    end_lat STRING,
    end_lng STRING,
    member_casual STRING
) 
--Import 2016 data
COPY INTO demo.demo_schema.bikes
FROM(
    select
        t.$12,
        t.$2,
        t.$3,
        t.$5,
        t.$4,
        t.$9,
        t.$8,
        t.$6,
        t.$7,
        t.$10,
        t.$11,
        t.$13
    from @DEMO.DEMO_SCHEMA.BIKE16 t) 
    ON_ERROR = SKIP_FILE_1;

--2019 DATA--
--Create Stage
CREATE STAGE DEMO.DEMO_SCHEMA.BIKE19;
--Import from local host using SNOWSQL
--Verify
SELECT * FROM DEMO.DEMO_SCHEMA.BIKE19
--Fill Table with 2019 data
COPY INTO demo.demo_schema.bikes
FROM(
        SELECT
            s.$1,
            s.$2,
            s.$3,
            s.$4,
            s.$5,
            s.$6,
            s.$7,
            s.$8,
            s.$9,
            s.$10,
            s.$11,
            s.$12,
            s.$13
        FROM
            @DEMO.DEMO_SCHEMA.BIKE_STAGE s
    ) ON_ERROR = SKIP_FILE_1;

--Schedule Refresh
CREATE TASK DEMO.DEMO_SCHEMA.bike_task 
WAREHOUSE = COMPUTE_WH
AFTER DEMO.DEMO_SCHEMA.weather_task 
AS 
    COPY INTO demo.demo_schema.bikes
    FROM(
        SELECT
            s.$1,
            s.$2,
            s.$3,
            s.$4,
            s.$5,
            s.$6,
            s.$7,
            s.$8,
            s.$9,
            s.$10,
            s.$11,
            s.$12,
            s.$13
        FROM
            @DEMO.DEMO_SCHEMA.BIKE_STAGE s
    );