WITH CTE AS (
    SELECT
        TO_TIMESTAMP(started_at) AS started_at,
        DATE(TO_TIMESTAMP(started_at)) AS date_started_at,
        HOUR(TO_TIMESTAMP(started_at)) AS hour_started_at,
        DAYNAME(TO_TIMESTAMP(started_at)) AS day_hour_at,
        {{ day_type('started_at') }},
        {{ QofYear('started_at') }} 
from
{{ ref('stg_bike') }}
where STARTED_AT != 'Start Time' and STARTED_AT != '"Start Time"'
)

select * FROM CTE