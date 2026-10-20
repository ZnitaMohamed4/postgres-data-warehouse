/*
===============================================================
Stored Procedure: Load Bronze Layer (CSV -> Bronze)
===============================================================
Purpose:
    Truncates the bronze tables and reloads them from the CSV
    files with COPY (full load).
Usage:
    CALL bronze.load_bronze();
===============================================================
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time       TIMESTAMP;
    end_time         TIMESTAMP;
    batch_start_time TIMESTAMP;
    batch_end_time   TIMESTAMP;
BEGIN
    batch_start_time := clock_timestamp();
    RAISE NOTICE '================ Loading Bronze Layer ================';

    -- CRM
    RAISE NOTICE '>> Loading CRM tables';

    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.crm_cust_info;
    COPY bronze.crm_cust_info
    FROM '/tmp/datasets/source_crm/cust_info.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    end_time := clock_timestamp();
    RAISE NOTICE '   crm_cust_info: % s', EXTRACT(EPOCH FROM end_time - start_time);

    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.crm_prd_info;
    COPY bronze.crm_prd_info
    FROM '/tmp/datasets/source_crm/prd_info.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    end_time := clock_timestamp();
    RAISE NOTICE '   crm_prd_info: % s', EXTRACT(EPOCH FROM end_time - start_time);

    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.crm_sales_details;
    COPY bronze.crm_sales_details
    FROM '/tmp/datasets/source_crm/sales_details.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    end_time := clock_timestamp();
    RAISE NOTICE '   crm_sales_details: % s', EXTRACT(EPOCH FROM end_time - start_time);

    -- ERP
    RAISE NOTICE '>> Loading ERP tables';

    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.erp_cust_az12;
    COPY bronze.erp_cust_az12
    FROM '/tmp/datasets/source_erp/CUST_AZ12.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    end_time := clock_timestamp();
    RAISE NOTICE '   erp_cust_az12: % s', EXTRACT(EPOCH FROM end_time - start_time);

    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.erp_loc_a101;
    COPY bronze.erp_loc_a101
    FROM '/tmp/datasets/source_erp/LOC_A101.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    end_time := clock_timestamp();
    RAISE NOTICE '   erp_loc_a101: % s', EXTRACT(EPOCH FROM end_time - start_time);

    start_time := clock_timestamp();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    COPY bronze.erp_px_cat_g1v2
    FROM '/tmp/datasets/source_erp/PX_CAT_G1V2.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    end_time := clock_timestamp();
    RAISE NOTICE '   erp_px_cat_g1v2: % s', EXTRACT(EPOCH FROM end_time - start_time);

    batch_end_time := clock_timestamp();
    RAISE NOTICE '================ Bronze load completed ================';
    RAISE NOTICE 'Total duration: % s', EXTRACT(EPOCH FROM batch_end_time - batch_start_time);

EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE '!!! ERROR loading Bronze layer !!!';
    RAISE NOTICE 'Message: %', SQLERRM;
    RAISE NOTICE 'SQLSTATE: %', SQLSTATE;
END;
$$;