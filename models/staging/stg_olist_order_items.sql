-- olist_ecommerce_analysis/models/staging/stg_olist_order_items.sql

{{
    config(
        materialized='view'
    )
}}

SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date AS shipping_limit_at,
    price,
    freight_value
FROM
    {{ source('olist_raw', 'order_items') }}
WHERE
    order_id IS NOT NULL
    AND product_id IS NOT NULL
    AND price IS NOT NULL