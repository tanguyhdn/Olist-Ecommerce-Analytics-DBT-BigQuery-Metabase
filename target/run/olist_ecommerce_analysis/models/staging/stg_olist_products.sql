

  create or replace view `portfolio-project-465909`.`olist_marts`.`stg_olist_products`
  OPTIONS()
  as -- olist_ecommerce_analysis/models/staging/stg_olist_products.sql



SELECT
    product_id,
    -- product_category_name is in Portuguese, will be translated in dim_products
    product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM
    `portfolio-project-465909`.`olist_raw`.`products`
WHERE
    product_id IS NOT NULL
    AND product_category_name IS NOT NULL -- Ensure we have a category;

