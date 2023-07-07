-- source: https://data.cityofnewyork.us/api/views/erm2-nwe9/rows.csv?accessType=DOWNLOAD
-- via: https://data.cityofnewyork.us/Social-Services/311-Service-Requests-from-2010-to-Present/erm2-nwe9
-- yields: https://public.datathinking.org/cityofnewyork.us%2Fservice_requests.parquet
-- code example: https://nbviewer.org/github/onefact/datathinking.org-codespace/blob/main/notebooks/princeton-university/week-1-visualizing-33-million-phone-calls-in-new-york-city.ipynb
SELECT * FROM read_csv('https://public.datathinking.org/cityofnewyork.us%2F311-Service-Requests-from-2010-to-Present.csv', 
                       header=True, 
                       delim=',', 
                       quote='"', 
                       ignore_errors=False,
                       columns={'Unique Key': 'BIGINT',
                                'Created Date': 'VARCHAR',
                                'Closed Date': 'VARCHAR',
                                'Agency': 'VARCHAR',
                                'Agency Name': 'VARCHAR',
                                'Complaint Type': 'VARCHAR',
                                'Descriptor': 'VARCHAR',
                                'Location Type': 'VARCHAR',
                                'Incident Zip': 'VARCHAR',
                                'Incident Address': 'VARCHAR',
                                'Street Name': 'VARCHAR',
                                'Cross Street 1': 'VARCHAR',
                                'Cross Street 2': 'VARCHAR',
                                'Intersection Street 1': 'VARCHAR',
                                'Intersection Street 2': 'VARCHAR',
                                'Address Type': 'VARCHAR',
                                'City': 'VARCHAR',
                                'Landmark': 'VARCHAR',
                                'Facility Type': 'VARCHAR',
                                'Status': 'VARCHAR',
                                'Due Date': 'VARCHAR',
                                'Resolution Description': 'VARCHAR',
                                'Resolution Action Updated Date': 'VARCHAR',
                                'Community Board': 'VARCHAR',
                                'BBL': 'VARCHAR',
                                'Borough': 'VARCHAR',
                                'X Coordinate (State Plane)': 'VARCHAR',
                                'Y Coordinate (State Plane)': 'VARCHAR',
                                'Open Data Channel Type': 'VARCHAR',
                                'Park Facility Name': 'VARCHAR',
                                'Park Borough': 'VARCHAR',
                                'Vehicle Type': 'VARCHAR',
                                'Taxi Company Borough': 'VARCHAR',
                                'Taxi Pick Up Location': 'VARCHAR',
                                'Bridge Highway Name': 'VARCHAR',
                                'Bridge Highway Direction': 'VARCHAR',
                                'Road Ramp': 'VARCHAR',
                                'Bridge Highway Segment': 'VARCHAR',
                                'Latitude': 'DOUBLE',
                                'Longitude': 'DOUBLE',
                                'Location': 'VARCHAR'}
                    )
-- LIMIT 1000 -- DEBUG
-- TIMING on macbook pro: 16:44:46  1 of 1 OK created sql table model main.service_requests ........................ [OK in 2944.05s]
-- 22:21:23  1 of 1 OK created sql table model main.service_requests ........................ [OK in 2751.54s]
-- THEN need to run `duckdb /tmp/service_requests.duckdb` and `COPY service_requests TO '/tmp/service_requests.parquet' (FORMAT 'PARQUET', CODEC 'ZSTD');` and copy to s3
-- COPY to s3: `aws s3 cp /tmp/service_requests.parquet s3://datathinking.org/cityofnewyork.us/ --profile me@laptop-datascientist`