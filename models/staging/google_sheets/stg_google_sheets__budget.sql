{{
  config(
    materialized='view'
  )
}}

WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

renamed_casted AS (
    SELECT
          _row::varchar(256) 
        , product_id::varchar(256) 
        , quantity::varchar(256) 
        , month::varchar(256) 
        , _fivetran_synced AS date_load
    FROM src_budget
    )

SELECT *
FROM renamed_casted