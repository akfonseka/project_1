{
    #
    this macro returns a numeric representation of a weather field
#
}

{%- macro weather_num(weather) -%}
    case
        {{ weather }}
        when 'Unknown'
        then 0
        when 'Windy/Rainy/Cold'
        then 1
        when 'Light Rain'
        then 2
        when 'Cloudy'
        then 3
        when 'Clear/Sunny'
        then 4
    end

{%- endmacro -%}
