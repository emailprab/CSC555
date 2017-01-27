
dwdate = LOAD '/phase2/data/scale4/dwdate.tbl' USING PigStorage('|') 
AS (  d_datekey:int,
  d_date:chararray,
  d_dayofweek:chararray,
  d_month:chararray,
  d_year:int,
  d_yearmonthnum:int,
  d_yearmonth:chararray,
  d_daynuminweek:int,
  d_daynuminmonth:int,
  d_daynuminyear:int,
  d_monthnuminyear:int,
  d_weeknuminyear:int,
  d_sellingseason:chararray,
  d_lastdayinweekfl:chararray,
  d_lastdayinmonthfl:chararray,
  d_holidayfl:chararray,
  d_weekdayfl:chararray     
);

lineorder = LOAD '/phase2/data/scale4/lineorder.tbl' USING PigStorage('|') 
AS (lo_orderkey:int,
  lo_linenumber:int,
  lo_custkey:int,
  lo_partkey:int,
  lo_suppkey:int,
  lo_orderdate:int,
  lo_orderpriority:chararray,
  lo_shippriority:chararray,
  lo_quantity:int,
  lo_extendedprice:int,
  lo_ordertotalprice:int,
  lo_discount:int,
  lo_revenue:int,
  lo_supplycost:int,
  lo_tax:int,
  lo_commitdate:int,
  lo_shipmode:chararray    
);

--SELECT lo_partkey, lo_suppkey, d_year, lo_revenue      

--   FROM lineorder, dwdate                       
-- WHERE lo_orderdate = d_datekey; 
prejoin1d = FOREACH (JOIN lineorder BY (lo_orderdate), dwdate BY (d_datekey)) GENERATE lo_partkey,lo_suppkey,d_year,lo_revenue;
--prejoin1d = FOREACH (GROUP DataJoin1 ALL ) GENERATE lo_partkey,lo_suppkey,d_year,lo_revenue;
Store prejoin1d into 'prejoin1d' using PigStorage(',');

