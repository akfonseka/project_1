{{
    config(materialized='view')
}}

with trips_data as (
    select *
    from {{ref("fact_trips")}}
    where weather_num != 0
)

    select 

    grouped_weather

    from trips_data
    group by grouped_weather

