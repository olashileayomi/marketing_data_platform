/*
    Tables
*/

WITH source_data AS (

    SELECT * FROM {{ source('snapchat_ads', 'campaigns') }}
{{ add_rows_limit() }}),

/*
    Transformations
*/

formatted AS (

    SELECT
        -- FK
        CAST(campaign_id AS STRING) AS campaign_id,

        -- FK
        CAST(account_id AS STRING) AS account_id,

        -- Details
        CAST(campaign_name AS STRING) AS campaign_name

    FROM
        source_data
)

SELECT * FROM formatted