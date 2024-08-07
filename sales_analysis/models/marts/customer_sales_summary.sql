-- This model aggregates sales data by customer.
{{ config(
    materialized='table'
) }}

WITH customer_sales AS (
    SELECT
        c.customer_name,
        SUM(s.sale_amount) AS total_spent,
        COUNT(s.sale_id) AS purchase_count
    FROM
        {{ ref('stg_sales') }} AS s
    JOIN
        {{ ref('stg_customers') }} AS c
    ON
        s.customer_id = c.customer_id
    GROUP BY
        c.customer_name
)

SELECT * FROM customer_sales
