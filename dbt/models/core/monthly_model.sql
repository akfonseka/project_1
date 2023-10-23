{{
    config(materialized='table')
}}

with trips_data as (
    select *
    ,format_date('%m', date_trunc(date_field ,month)) as num_month
    ,format_date('%B', date_trunc( date_field, month)) as trip_month
    ,format_date('%Y', date_trunc( date_field, year)) as trip_year
    from {{ref("fact_trips")}}
),

aggregate_trips as (
select distinct
borough as trip_location
,num_month
,trip_month
,trip_year
,sum(trip_count) over(
    partition by borough, trip_month, trip_year) as total_monthly_trips
from trips_data
)

    select 

        --- count identifiers
        trip_location
        ,num_month
        ,trip_month
        ,trip_year

        --- statistical info 
        ,total_monthly_trips
        ,cast(round(avg(total_monthly_trips) over(
            partition by trip_location),2) as numeric) as avg_monthly_total

    from aggregate_trips
    order by trip_year, num_month