# data_build_tool_for_datathinking.org
Using dbt to explore datathinking.org datasets.

## Steps to initialize `dbt`

1. Install `dbt` using `pip3 install dbt-duckdb` (https://github.com/jwills/dbt-duckdb)
2. Run `dbt init` and enter `datathinking` as the project name
3. Create `profiles.yml` in the `datathinking` directory with the following contents:

```
datathinking:
  target: dev
  outputs:
    dev:
      type: duckdb
      path: /tmp/dbt.duckdb
      # path: '/Users/me/Downloads/311_Service_Requests_from_2010_to_Present.csv'
      # path: 's3://datathinking.org/311_Service_Requests_from_2010_to_Present.csv'
      extensions:
        - httpfs
        - parquet
      settings:
        s3_region: us-east-1
        # s3_access_key_id: "{{ env_var('S3_ACCESS_KEY_ID') }}"
        # s3_secret_access_key: "{{ env_var('S3_SECRET_ACCESS_KEY') }}"
```

4. Add an example data model, in `models/new_york_city_311_calls.sql` with the following contents:

```
SELECT * FROM read_csv_auto('/Users/me/Downloads/311_Service_Requests_from_2010_to_Present.csv') LIMIT 10
```

5. Execute `dbt run`
6. Verify that you can query the data using `duckdb` (install using `brew install duckdb`):
```
 me@laptop   ~/dropbox/projects/data_build_tool_for_datathinking.org/datathinking     main    duckdb /tmp/dbt.duckdb
v0.7.1 b00b93f0b1
Enter ".help" for usage hints.
D SELECT * FROM main.new_york_city_311_calls;
┌────────────┬─────────────────────┬──────────────────────┬─────────┬───┬───────────┬──────────────────────┬──────────┬───────────┬──────────┐
│ Unique Key │    Created Date     │     Closed Date      │ Agency  │ … │ Road Ramp │ Bridge Highway Seg…  │ Latitude │ Longitude │ Location │
│   int64    │      timestamp      │       varchar        │ varchar │   │  varchar  │       varchar        │  double  │  double   │ varchar  │
├────────────┼─────────────────────┼──────────────────────┼─────────┼───┼───────────┼──────────────────────┼──────────┼───────────┼──────────┤
│   34247134 │ 2016-09-04 14:35:29 │ 09/07/2016 03:50:3…  │ DPR     │ … │           │                      │          │           │          │
│   34250114 │ 2016-09-05 15:47:42 │ 09/07/2016 03:47:1…  │ DOF     │ … │           │                      │          │           │          │
│   34249970 │ 2016-09-05 15:56:00 │ 09/12/2016 10:06:2…  │ DPR     │ … │           │                      │          │           │          │
│   27050693 │ 2014-01-04 14:10:00 │ 01/20/2014 09:50:0…  │ DOT     │ … │           │                      │          │           │          │
│   34262636 │ 2016-09-07 09:49:51 │ 09/15/2016 07:00:2…  │ DOF     │ … │           │                      │          │           │          │
│   41686038 │ 2019-02-12 14:57:34 │ 02/13/2019 02:59:1…  │ HPD     │ … │           │                      │          │           │          │
│   34253047 │ 2016-09-06 10:48:38 │ 09/07/2016 12:52:4…  │ DOF     │ … │           │                      │          │           │          │
│   34262378 │ 2016-09-07 14:03:33 │ 09/08/2016 03:19:1…  │ DOF     │ … │           │                      │          │           │          │
│   34262389 │ 2016-09-07 20:26:28 │ 09/07/2016 08:26:4…  │ HRA     │ … │           │                      │          │           │          │
│   27050121 │ 2014-01-03 12:52:00 │ 01/03/2014 01:25:0…  │ DOT     │ … │           │                      │          │           │          │
├────────────┴─────────────────────┴──────────────────────┴─────────┴───┴───────────┴──────────────────────┴──────────┴───────────┴──────────┤
│ 10 rows                                                                                                               41 columns (9 shown) │
└────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
D
```