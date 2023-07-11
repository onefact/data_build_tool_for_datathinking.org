-- Retrieved from: https://www.checkbooknyc.com/data-feeds
-- Select Contracts
-- Select Agency: Police Department
-- Select all columns
{{ config(materialized='external', location='/tmp/nypd_contracts.parquet') }}
SELECT *
FROM read_csv('https://public.datathinking.org/checkbooknyc.com%2Fnypd_contracts.csv',
    header=True,
    delim=',',
    quote='"',
    columns={
        'Document Code': 'VARCHAR',
        'Prime Contract ID': 'VARCHAR',
        'Contract Includes Sub Vendors': 'VARCHAR',
        'Vendor Record Type': 'VARCHAR',
        'Prime Vendor': 'VARCHAR',
        'Prime Vendor M/WBE Category': 'VARCHAR',
        'Prime Contract Purpose': 'VARCHAR',
        'Prime Contract Current Amount': 'DOUBLE',
        'Prime Contract Original Amount': 'DOUBLE',
        'Prime Vendor Spend to Date': 'DOUBLE',
        'Prime Contract Start Date': 'VARCHAR',
        'Prime Contract End Date': 'VARCHAR',
        'Prime Contract Registration Date': 'VARCHAR',
        'Prime Contracting Agency': 'VARCHAR',
        'Prime Contract Version': 'VARCHAR',
        'Parent Contract ID': 'VARCHAR',
        'Prime Contract Type': 'VARCHAR',
        'Prime Contract Award Method': 'VARCHAR',
        'Prime Contract Expense Category': 'VARCHAR',
        'Prime Contract Industry': 'VARCHAR',
        'Prime Contract PIN': 'VARCHAR',
        'Prime Contract APT PIN': 'VARCHAR',
        'Prime Woman Owned Business': 'VARCHAR',
        'Prime Emerging Business': 'VARCHAR',
        'Sub Vendor': 'VARCHAR',
        'Sub Vendor M/WBE Category': 'VARCHAR',
        'Sub Contract Purpose': 'VARCHAR',
        'Sub Vendor Status in PIP': 'VARCHAR',
        'Sub Contract Industry': 'VARCHAR',
        'Sub Contract Current Amount': 'DOUBLE',
        'Sub Contract Original Amount': 'DOUBLE',
        'Sub Vendor Paid To Date': 'DOUBLE',
        'Sub Contract Start Date': 'VARCHAR',
        'Sub Contract End Date': 'VARCHAR',
        'Sub Contract Reference ID': 'VARCHAR',
        'Sub Woman Owned Business': 'VARCHAR',
        'Sub Emerging Business': 'VARCHAR'
    })
