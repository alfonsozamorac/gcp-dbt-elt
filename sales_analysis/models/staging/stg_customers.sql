-- This model stages the raw customers data.
{{ config(
    materialized='view'
) }}

SELECT
    customer_id,
    customer_name
FROM
    {{ source('raw_data', 'customers') }}
