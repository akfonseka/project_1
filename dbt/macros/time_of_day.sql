{
    #
    this macro returns the time of day description of a bike ride
#
}

{% macro time_of_day_description(time_stamp) -%}
    case
        when extract(hour from {{time_stamp}}) < 9
        then 'early_morning'
        when extract(hour from {{time_stamp}}) < 12
        then 'late_morning'
        when extract(hour from {{time_stamp}}) < 15
        then 'early_afternoon'
        when extract(hour from {{time_stamp}}) < 18
        then 'late_afternoon'
        when extract(hour from {{time_stamp}}) < 21
        then 'early_evening'
        else 'late_evening'
    end 
{% endmacro %}
