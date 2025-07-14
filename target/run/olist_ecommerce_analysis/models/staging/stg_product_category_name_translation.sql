

  create or replace view `portfolio-project-465909`.`olist_marts`.`stg_product_category_name_translation`
  OPTIONS()
  as -- olist_ecommerce_analysis/models/staging/stg_product_category_name_translation.sql



SELECT
    string_field_0 AS product_category_name,        -- This is the Portuguese name
    string_field_1 AS product_category_name_english -- This is the English translation
FROM
    `portfolio-project-465909`.`olist_raw`.`product_category_name_translation`
WHERE
    string_field_0 IS NOT NULL         -- <--- CORRECTED: Use original column name
    AND string_field_1 IS NOT NULL -- <--- CORRECTED: Use original column name;

