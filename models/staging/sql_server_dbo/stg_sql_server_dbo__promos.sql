{{
  config(
    materialized='view'
  )
}}

with source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

empty_values as (

    select
        'sin_promo' AS promo_id,
        '0' AS discount,
        'inactive' AS status,
        NULL AS _fivetran_deleted,
        '2024-10-25' AS _fivetran_synced

    from source

),

unido as (

SELECT         
    {{dbt_utils.generate_surrogate_key(['promo_id'])}} AS promo_id,
    discount,
    status,
    _fivetran_deleted,
    _fivetran_synced 
FROM source

UNION ALL

SELECT 
    promo_id,
    discount,
    status,
    _fivetran_deleted,
    _fivetran_synced 
FROM empty_values

),



renamed as (

    select
        promo_id,
        discount,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source

)


select *
from renamed
