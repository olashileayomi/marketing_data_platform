-- created_at: 2026-10-20T21:09:28.673129634+00:00
-- finished_at: 2026-10-20T21:09:29.226208798+00:00
-- elapsed: 553ms
-- outcome: success
-- dialect: databricks
-- node_id: not available
-- query_id: 01f1ccca-89db-19f3-b4b6-6349637c5b42
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "invocation_id": "01a15b25-cc58-7312-8e48-3d0c757298ae", "profile_name": "elementary", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED bronze_development.elementary.dbt_invocations AS JSON;

-- created_at: 2026-10-20T21:09:29.228023005+00:00
-- finished_at: 2026-10-20T21:09:29.774746629+00:00
-- elapsed: 546ms
-- outcome: success
-- dialect: databricks
-- node_id: not available
-- query_id: 01f1ccca-8a2f-1124-8210-473bc9d3eb85
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "invocation_id": "01a15b25-cc58-7312-8e48-3d0c757298ae", "profile_name": "elementary", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED bronze_development.elementary.dbt_invocations AS JSON;

-- created_at: 2026-10-20T21:09:29.776138829+00:00
-- finished_at: 2026-10-20T21:09:30.503641508+00:00
-- elapsed: 727ms
-- outcome: success
-- dialect: databricks
-- node_id: not available
-- query_id: 01f1ccca-8aa0-1713-be1c-048428ce4f55
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "invocation_id": "01a15b25-cc58-7312-8e48-3d0c757298ae", "profile_name": "elementary", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED bronze_development.elementary.dbt_invocations AS JSON;

-- created_at: 2026-10-20T21:09:30.506273808+00:00
-- finished_at: 2026-10-20T21:09:31.717297639+00:00
-- elapsed: 1.2s
-- outcome: success
-- dialect: databricks
-- node_id: not available
-- query_id: 01f1ccca-8af1-1d48-9c01-8266b381a312
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "invocation_id": "01a15b25-cc58-7312-8e48-3d0c757298ae", "profile_name": "elementary", "target_name": "dev"} */
/* --ELEMENTARY-METADATA-- {"command": "run-operation", "elementary_component": "OSS", "invocation_id": "01a15b25-cc58-7312-8e48-3d0c757298ae"} --END-ELEMENTARY-METADATA-- */
    
    with ordered_run_results as (
      select
        run_results.invocation_id,
        row_number() over (partition by run_results.unique_id order by run_results.generated_at desc) as row_number
      from bronze_development.elementary.dbt_run_results run_results
      join bronze_development.elementary.dbt_models models on run_results.unique_id = models.unique_id
    ),

    latest_models_invocations as (
      select distinct invocation_id
      from ordered_run_results
      where row_number = 1
    )

    select
      invocations.invocation_id,
      invocations.command,
      invocations.selected,
      invocations.full_refresh,
      invocations.job_url,
      invocations.job_name,
      invocations.job_id,
      invocations.job_run_id,
      invocations.job_run_url,
      invocations.orchestrator
    from bronze_development.elementary.dbt_invocations invocations
    join latest_models_invocations on invocations.invocation_id = latest_models_invocations.invocation_id;

