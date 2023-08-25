{{
    config(materialized='table')
}}

with trips_data as (
    select *
    from {{ref("fact_trips")}}
    where weather_num != 0
)

    select 

    --- time of day 
    time_of_day_description   

    --- weather condition
    ,round(avg(weather_num), 2) as avg_weather_condition

     --- trip counts
    ,round(avg(trip_count), 2) as avg_trip_count 

    from trips_data
    group by time_of_day_description
    order by avg_trip_count desc