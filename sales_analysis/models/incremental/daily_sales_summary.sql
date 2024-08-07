{{ config(
    materialized='incremental',
    unique_key='sale_id',
    partition_by={
        "field": "date",
        "data_type": "DATE"
    }
) }}

WITH new_sales AS (
    SELECT
        sale_id,
        product_id,
        customer_id,
        DATE(sale_date) AS date,
        sale_amount
    FROM
        {{ source('raw_data', 'sales') }}
    {% if is_incremental() %}
    WHERE
        DATE(sale_date) > (SELECT MAX(date) FROM {{ this }})
    {% endif %}
),
aggregated_sales AS (
    SELECT
        date,
        SUM(sale_amount) AS total_sales,
        COUNT(sale_id) AS number_of_sales
    FROM
        new_sales
    GROUP BY
        date
)

SELECT * FROM aggregated_sales
