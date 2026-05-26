{% macro QofYear(x) %}


    MONTH(TO_TIMESTAMP({{x}})) AS "month",
    CASE WHEN MONTH(TO_TIMESTAMP({{x}})) IN (1,2,3) THEN 'Q1'
         WHEN MONTH(TO_TIMESTAMP({{x}})) IN (4,5,6)  THEN 'Q2'
         WHEN MONTH(TO_TIMESTAMP({{x}})) IN (7,8,9) THEN 'Q3'
         WHEN MONTH(TO_TIMESTAMP({{x}})) IN (10,11,12) THEN 'Q4'
         ELSE 'Error'
         END AS "Quater"

{% endmacro %}

{% macro day_type(x) %}

CASE
    WHEN DAYNAME(TO_TIMESTAMP({{x}})) IN ('Sat','Sun') 
    THEN 'Weekend'
    ELSE 'Weekday' 
END 

{% endmacro %}