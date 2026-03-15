{% macro get_trip_duration(dotime,putime) %}
    timestamp_diff({{dotime}},{{putime}},minute)
{% endmacro %}