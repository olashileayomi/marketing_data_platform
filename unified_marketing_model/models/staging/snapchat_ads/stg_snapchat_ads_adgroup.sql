/*
    Tables
*/

WITH source_data AS (

    SELECT * FROM {{ source('snapchat_ads', 'adgroups') }}
{{ add_rows_limit() }}),

/*
    Transformations
*/

formatted AS (

    SELECT
        -- Surrogate Key
        CAST(_surrogate_key AS STRING) AS _surrogate_key,

        -- PK
        CAST(ad_group_id AS STRING) AS ad_group_id,

        -- FK
        CAST(campaign_id AS STRING) AS campaign_id,

        -- Details
        CAST(ad_group_name AS STRING) AS ad_group_name,

        -- Metadata
        CAST(ad_group_updated_at AS TIMESTAMP) AS ad_group_updated_at
    FROM
        source_data
)

SELECT * FROM formatted