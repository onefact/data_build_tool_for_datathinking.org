-- data from https://www2.census.gov/geo/docs/maps-data/data/gazetteer/2022_Gazetteer/2022_Gaz_zcta_national.zip
{{ config(materialized='external', location='/tmp/zip_code_to_coordinates.parquet') }}
SELECT * FROM read_csv('https://public.datathinking.org/census.gov%2F2022_Gaz_zcta_national.txt', 
    header=true, 
    delim='\t', 
    columns= {
        'GEOID': 'INTEGER',
        'ALAND': 'BIGINT', 
        'AWATER': 'DOUBLE',
        'ALAND_SQMI': 'DOUBLE',
        'AWATER_SQMI': 'DOUBLE',
        'INTPTLAT': 'DOUBLE',
        'INTPTLONG': 'DOUBLE'
    })