-- olist_ecommerce_analysis/models/marts/dimensions/dim_customers.sql



SELECT
    customer_id,
    customer_unique_id, -- A unique identifier for a customer across multiple 'customer_id's if they re-register
    customer_zip_code_prefix,
    customer_city,
    customer_state
    -- Add any derived customer attributes here if needed, e.g., customer_segment
FROM
    `portfolio-project-465909`.`olist_marts`.`stg_olist_customers` -- Reference the staging customer model
WHERE
    customer_id IS NOT NULL
    AND customer_unique_id IS NOT NULL