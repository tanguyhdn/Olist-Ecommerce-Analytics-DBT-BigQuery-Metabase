-- olist_ecommerce_analysis/models/staging/stg_olist_customers.sql



SELECT
    customer_id,
    customer_unique_id, -- Useful for tracking unique individuals across multiple customer_ids if they re-register
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM
    `portfolio-project-465909`.`olist_raw`.`customers`
WHERE
    customer_id IS NOT NULL
    AND customer_unique_id IS NOT NULL
    AND customer_state IS NOT NULL -- Ensure we have basic location info