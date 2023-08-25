{{
    config(materialized="table")
}}

select 
    SiteID 
    ,Location_description
    ,Borough
from {{ ref("location_lookup")}} 
