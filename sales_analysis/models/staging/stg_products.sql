-- This model stages the raw products data.
{{ config(
    materialized='view'
) }}

SELECT
    product_id,
    product_name
FROM
    {{ source('raw_data', 'products') }}
