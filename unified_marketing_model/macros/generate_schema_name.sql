-- Keep here over utils as dbt ignores this macro from installed packages: https://docs.github.com/dbt-labs/dbt-core/issues/6355
{% macro generate_schema_name(custom_schema_name, node) -%}
    {# Allow packages (like elementary) or models with explicit custom schemas to use them #}
    {%- if node.package_name != 'unified_marketing_model' -%}
        {{ custom_schema_name | trim }}
    {%- elif custom_schema_name is none or target.name not in ['production', 'staging'] -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}