-- olist_ecommerce_analysis/models/marts/facts/fct_daily_sales.sql



WITH order_item_details AS (
    SELECT
        oi.order_id,
        oi.product_id,
        oi.seller_id,
        oi.price,
        oi.freight_value,
        -- Assume quantity of 1 per order_item_id line, or sum up if multiple quantities could exist
        -- For Olist, typically each row is one unit, but we'll use a placeholder for quantity
        1 AS quantity, -- Assuming each order_item_id line represents one unit
        oi.shipping_limit_at
    FROM
        `portfolio-project-465909`.`olist_marts`.`stg_olist_order_items` oi
),
order_details AS (
    SELECT
        o.order_id,
        o.customer_id,
        DATE(o.order_purchased_at) AS order_date, -- Extract date for daily aggregation
        o.order_status,
        o.order_approved_at,
        o.order_delivered_customer_at
    FROM
        `portfolio-project-465909`.`olist_marts`.`stg_olist_orders` o
    WHERE
        o.order_status IN ('delivered', 'shipped') -- Focus on actual sales
        AND o.order_purchased_at IS NOT NULL
)

SELECT
    od.order_date,
    od.order_id,
    od.customer_id,
    oid.product_id,
    dp.product_category_name_english,
    dp.product_category_name_portuguese,
    oid.seller_id,
    dc.customer_city,
    dc.customer_state,
    oid.quantity,
    oid.price AS item_price,
    oid.freight_value,
    (oid.price + oid.freight_value) AS total_item_value,
    -- Calculate revenue (price includes shipping from item perspective)
    (oid.price * oid.quantity) AS item_revenue,
    -- Calculate profit using simulated COGS from dim_products
    (oid.price * oid.quantity) - (dp.simulated_cost_of_goods_sold * oid.quantity) AS item_profit,
    od.order_status,
    od.order_approved_at,
    od.order_delivered_customer_at,
    oid.shipping_limit_at
FROM
    order_details od
JOIN
    order_item_details oid ON od.order_id = oid.order_id
LEFT JOIN
    `portfolio-project-465909`.`olist_marts`.`dim_products` dp ON oid.product_id = dp.product_id
LEFT JOIN
    `portfolio-project-465909`.`olist_marts`.`dim_customers` dc ON od.customer_id = dc.customer_id
WHERE
    dp.product_id IS NOT NULL -- Ensure product details are available
    AND dc.customer_id IS NOT NULL -- Ensure customer details are available