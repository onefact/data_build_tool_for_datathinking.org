-- downloaded from https://www.neighborhoodatlas.medicine.wisc.edu/download
{{ config(materialized='external', location='/tmp/area_deprivation_index.parquet') }}
WITH import_adi AS (
  SELECT * FROM read_csv('/Users/me/Downloads/adi-download/US_2021_ADI_Census Block Group_v4.csv',
                          header=True,
                          delim=',',
                          quote='"',
                          columns={'INDEX': 'INT',
                                  'GISJOIN': 'VARCHAR',
                                  'ADI_NATRANK': 'VARCHAR',
                                  'ADI_STATERNK': 'VARCHAR',
                                  'FIPS': 'BIGINT'}
                        )
),
replace_nulls AS (
  SELECT 
    INDEX,
    GISJOIN,
    regexp_replace(ADI_NATRANK, '^(GQ|PH|QDI|GQ-PH)$', 0) as ADI_NATRANK, 
    regexp_replace(ADI_STATERNK, '^(GQ|PH|QDI|GQ-PH)$', 0) as ADI_STATERNK,
    FIPS,
  FROM import_adi
),
replace_zeros AS (
  SELECT 
    INDEX,
    GISJOIN,
    CASE WHEN ADI_NATRANK = 0 THEN NULL ELSE ADI_NATRANK END as ADI_NATRANK, 
    CASE WHEN ADI_STATERNK = 0 THEN NULL ELSE ADI_STATERNK END as ADI_STATERNK,
    FIPS,
  FROM replace_nulls
),
cast_nulls AS (
  SELECT 
    INDEX,
    GISJOIN,
    CAST(ADI_NATRANK AS INT) as ADI_NATRANK, 
    CAST(ADI_STATERNK AS INT) as ADI_STATERNK,
    FIPS,
  FROM replace_zeros
)
SELECT * FROM cast_nulls