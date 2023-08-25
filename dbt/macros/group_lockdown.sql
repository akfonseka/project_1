{
    #
    this macro returns which lockdown period a date falls into
#
}

{% macro lockdown(date_field) %}
    case
        when {{date_field}} < '2020-03-26'
        then 'before_lockdown'
        when {{date_field}} < '2020-06-23'
        then 'first_lockdown'
        when {{date_field}} < '2020-11-05'
        then 'between_lockdowns'
        when {{date_field}} < '2020-12-02'
        then 'second_lockdown'
        when {{date_field}} < '2020-12-21'
        then 'between_lockdowns'
        when {{date_field}} < '2021-03-29'
        then 'third_lockdown'
        else 'after_lockdown'
    end

{% endmacro %}
