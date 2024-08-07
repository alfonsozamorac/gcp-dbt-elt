{% macro calculate_avg_sales(sales_amount_column) %}
    AVG({{ sales_amount_column }})
{% endmacro %}
