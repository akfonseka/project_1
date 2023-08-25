{{
    config(materialized="view")
}}

with bikedata as 
(
    select *
    ,cast(Time as TIME) as time_stamp
    ,row_number() over(partition by UUID, Time) as row_no 
    from {{source("staging", '2020-data')}}
    where UUID is not null
)

select 
    --- identifiers 
    {{dbt_utils.surrogate_key(['UUID', 'time_stamp'])}} as trip_id
    ,UUID as uuid 
    ,Area as area
    
    --- time info 
    ,Date as date_field
    ,time_stamp 
    ,{{time_of_day_description('time_stamp')}} as time_of_day_description
    ,Day as day_type 

    --- weather info
    ,GroupedWeather as grouped_weather

    --- statistical info
    ,cast(Count as integer) as trip_count
from 
bikedata

-- dbt build -m <model.sql> --var 'is_test_run: false'
-- {% if var('is_test_run', default=true) %}
    
--     limit 100

-- {% endif %}