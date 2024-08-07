-- This model stages the raw sales data, applying basic cleaning.
{{ config(
    materialized='view'
) }}

SELECT
    sale_id,
    product_id,
    customer_id,
    sale_date,
    sale_amount
FROM
    {{ source('raw_data', 'sales') }}
WHERE
    sale_amount IS NOT NULL
    AND sale_date IS NOT NULL
