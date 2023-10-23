{{
    config(materialized='table')
}}

with trips_data as (
    select *
    from {{ref("fact_trips")}}
    where weather_num != 0
),

weather_impact as (
    select 
    grouped_weather
    ,round(avg(trip_count), 2) as avg_trip_count 
    from trips_data
    group by grouped_weather
)

    select 

    --- weather info
    t.grouped_weather   
    ,t.weather_num

     --- trip counts
    ,w.avg_trip_count

    from weather_impact as w 
    inner join trips_data as t 
    on w.grouped_weather = t.grouped_weather
    group by grouped_weather, weather_num, avg_trip_count
    order by avg_trip_count desc