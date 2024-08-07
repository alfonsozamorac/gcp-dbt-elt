-- This model aggregates sales data by date.
{{ config(
    materialized='table'
) }}

WITH daily_sales AS (
    SELECT
        DATE(sale_date) AS date,
        SUM(sale_amount) AS total_sales,
        COUNT(sale_id) AS number_of_sales
    FROM
        {{ ref('stg_sales') }}
    GROUP BY
        date
)

SELECT * FROM daily_sales
