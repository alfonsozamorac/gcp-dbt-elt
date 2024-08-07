-- This model aggregates sales data by product.
{{ config(
    materialized='table'
) }}

WITH product_sales AS (
    SELECT
        p.product_name,
        SUM(s.sale_amount) AS total_sales,
        COUNT(s.sale_id) AS number_of_sales
    FROM
        {{ ref('stg_sales') }} AS s
    JOIN
        {{ ref('stg_products') }} AS p
    ON
        s.product_id = p.product_id
    GROUP BY
        p.product_name
)

SELECT * FROM product_sales
