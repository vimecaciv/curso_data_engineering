{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
    ),

renamed_casted AS (
    SELECT
        EVENT_ID,
        PAGE_URL,
        EVENT_TYPE,
        USER_ID,
        PRODUCT_ID,
        SESSION_ID,
        CREATED_AT,
        ORDER_ID,
        _FIVETRAN_DELETED AS is_deleted,
        _FIVETRAN_SYNCED AS date_load
    FROM src_events
    )

SELECT * FROM renamed_casted