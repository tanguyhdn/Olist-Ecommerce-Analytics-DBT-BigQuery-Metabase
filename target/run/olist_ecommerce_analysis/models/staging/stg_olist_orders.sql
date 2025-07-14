

  create or replace view `portfolio-project-465909`.`olist_marts`.`stg_olist_orders`
  OPTIONS()
  as -- olist_ecommerce_analysis/models/staging/stg_olist_orders.sql



SELECT
    order_id,
    customer_id,
    order_status,
    -- These columns are already TIMESTAMP types, so just select them directly
    order_purchase_timestamp AS order_purchased_at,
    order_approved_at AS order_approved_at,
    order_delivered_carrier_date AS order_delivered_carrier_at,
    order_delivered_customer_date AS order_delivered_customer_at,
    order_estimated_delivery_date AS order_estimated_delivery_at
FROM
    `portfolio-project-465909`.`olist_raw`.`orders`
WHERE
    order_id IS NOT NULL
    AND order_purchase_timestamp IS NOT NULL;

