CREATE TABLE prejoin1d AS
SELECT lo_partkey, lo_suppkey, d_year, lo_revenue 
FROM lineorder, dwdate 
WHERE lo_orderdate = d_datekey
;
