-- olist_ecommerce_analysis/models/marts/dimensions/dim_products.sql

{{
    config(
        materialized='table',
        unique_key='product_id'
    )
}}

SELECT
    p.product_id,
    p.product_category_name AS product_category_name_portuguese,
    t.product_category_name_english,
    p.product_name_lenght,
    p.product_description_lenght,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,
    CAST(ROUND(RAND() * (200 - 10) + 10, 2) AS NUMERIC) AS simulated_cost_of_goods_sold
FROM
    {{ ref('stg_olist_products') }} p
LEFT JOIN
    {{ ref('stg_product_category_name_translation') }} t
    ON p.product_category_name = t.product_category_name
WHERE
    p.product_id IS NOT NULL