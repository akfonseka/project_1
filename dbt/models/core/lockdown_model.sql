{{
    config(materialized='table')
}}

with trips_data as (
    select *
    from {{ref("fact_trips")}}
),

lockdown_impact as (
select 
borough
,date_field
,time_stamp         
,{{lockdown('date_field')}} as lockdown_period
,trip_count 
from trips_data
)

    select 

        --- lockdown 
        lockdown_period
        
        --- count info
        ,round(avg(trip_count), 2) as avg_trip_count

    from lockdown_impact
    group by lockdown_period
    order by avg_trip_count desc 