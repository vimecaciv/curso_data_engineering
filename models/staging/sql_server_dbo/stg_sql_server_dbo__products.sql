{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

renamed_casted AS (
    SELECT
        PRODUCT_ID,
        PRICE,
        NAME,
        INVENTORY,
        _FIVETRAN_DELETED AS is_deleted,
        _FIVETRAN_SYNCED AS date_load
    FROM src_products
    )

SELECT *
FROM renamed_casted