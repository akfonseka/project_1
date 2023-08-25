{{
    config(materialized="table")
}}

with data_2015 as (
    select 
    *
    ,2015 as year
    from {{ref("2015_bikedata")}}
),

data_2016 as (
    select 
    *
    ,2016 as year
    from {{ref("2016_bikedata")}}
),

data_2017 as (
    select 
    *
    ,2017 as year
    from {{ref("2017_bikedata")}}
),

data_2018 as (
    select 
    *
    ,2018 as year
    from {{ref("2018_bikedata")}}
),

data_2019 as (
    select 
    *
    ,2019 as year
    from {{ref("2019_bikedata")}}
),

data_2020 as (
    select 
    *
    ,2020 as year
    from {{ref("2020_bikedata")}}
),

data_2021 as (
    select 
    *
    ,2021 as year
    from {{ref("2021_bikedata")}}
),

trips_unioned as (
    select * from data_2015
    union all 
    select * from data_2016
    union all 
    select * from data_2017 
    union all 
    select * from data_2018
    union all 
    select * from data_2019 
    union all 
    select * from data_2020 
    union all 
    select * from data_2021 
),

dim_locations as (
    select *
    from {{ref("dim_locations")}}
)

select 

    trips_unioned.trip_id
    ,trips_unioned.uuid
    ,location.Borough as borough
    ,trips_unioned.area
    ,trips_unioned.year
    ,trips_unioned.date_field
    ,trips_unioned.time_stamp
    ,trips_unioned.time_of_day_description
    ,trips_unioned.day_type
    ,trips_unioned.grouped_weather
    ,{{weather_num('trips_unioned.grouped_weather')}} as weather_num
    ,trips_unioned.trip_count

from trips_unioned
left join dim_locations as location
on trips_unioned.uuid = location.SiteID
