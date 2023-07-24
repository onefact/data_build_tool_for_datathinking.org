-- downloaded from https://www.neighborhoodatlas.medicine.wisc.edu/download
{{ config(materialized='external', location='/tmp/area_deprivation_index.parquet') }}
SELECT 
  INDEX,
  GISJOIN,
  regexp_replace(ADI_NATRANK, '^(GQ|PH|QDI|GQ-PH)$', 'NULL') as ADI_NATRANK, 
  regexp_replace(ADI_STATERNK, '^(GQ|PH|QDI|GQ-PH)$', 'NULL') as ADI_STATERNK,
  FIPS,
FROM read_csv('/Users/me/Downloads/adi-download/US_2021_ADI_Census Block Group_v4.csv',
  header=True,
  delim=',',
  quote='"',
  columns={'INDEX': 'INT',
           'GISJOIN': 'VARCHAR',
           'ADI_NATRANK': 'VARCHAR',
           'ADI_STATERNK': 'VARCHAR',
           'FIPS': 'BIGINT'}
)