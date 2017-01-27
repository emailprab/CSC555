SET default_parallel 10;
supplier = LOAD '/phase2/data/scale4/supplier.tbl' USING PigStorage('|')
AS (
  s_suppkey:int,
  s_name:chararray,
  s_address:chararray,
  s_city:chararray,
  s_nation:chararray,
  s_region:chararray,
  s_phone:chararray
)
;
customer = LOAD '/phase2/data/scale4/customer.tbl' USING PigStorage('|')
AS ( c_custkey:int,
  c_name:chararray,
  c_address:chararray,
  c_city:chararray,
  c_nation:chararray,
  c_region:chararray,
  c_phone:chararray,
  c_mktsegment:chararray
);

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

FILSASIA = FILTER supplier by ( s_region == 'ASIA');
supasia = Foreach FILSASIA generate s_suppkey,s_region,s_nation;
--grps = Group supasia by s_nation;

--Store supasia into 'supasia' using PigStorage(',');

FILCASIA = FILTER customer by (c_region == 'ASIA');
custasia = Foreach FILCASIA generate c_custkey,c_region,c_nation;
--grpc = Group custasia by c_nation;

--Store custasia into 'custasia' using PigStorage(',');

FILDWDATE = FILTER dwdate by (d_year >= 1992) AND ( d_year <= 1997);
dwdt97 = Foreach FILDWDATE generate d_datekey,d_year;
--grpdwdt97 = Group  dwdt97 by d_year;
--Store dwdt97 into 'dwdt97' using PigStorage(',');

--SUPCUST = JOIN FILCASIA  by (c_region) , supasia  by ( s_region);
--supcust = Foreach SUPCUST generate  c_custkey, s_suppkey, s_region,s_nation,c_region,c_nation;


DataJoin1 = JOIN dwdt97  BY (d_datekey), lineorder BY (lo_orderdate);
DJ1= Foreach DataJoin1 generate d_year,lo_revenue,lo_custkey,lo_suppkey;


--DataJoin2 = JOIN FILSASIA by (s_suppkey), DJ1 by (lo_suppkey);
--DJ2= Foreach DataJoin2 generate s_suppkey,s_nation,DJ1.d_year,DJ1.lo_revenue,DJ1.lo_custkey,DJ1.lo_suppkey;

DataJoin2 = JOIN supasia  by (s_suppkey), DJ1 by (lo_suppkey);
DJ2 = Foreach DataJoin2 generate s_nation,d_year,lo_custkey,lo_suppkey,lo_revenue;

DataJoin3 = JOIN custasia  by (c_custkey), DJ2 by (lo_custkey);
DJ3 = Foreach DataJoin3 generate c_nation,s_nation,d_year,lo_revenue;
grpdj3 = Foreach (Group DJ3 by (c_nation , s_nation , d_year)) generate SUM(DJ3.lo_revenue) as revenue, DJ3.c_nation, DJ3.s_nation, DJ3.d_year as d_year;
orddj3 = ORDER grpdj3 by  d_year ASC, revenue ASC;

--MJoin1 = JOIN DJ1  by (lo_suppkey), DJ2 by (s_suppkey);
--MJ1 = Foreach MJoin1 generate d_datekey,d_year,s_nation,lo_revenue,lo_custkey;


--MJoin2 = JOIN MJ1  by (lo_custkey), DJ3 by (c_custkey);
--MJ2 = Foreach MJoin2 generate d_datekey,d_year,c_nation,s_nation,lo_revenue;
--MJ2 = Foreach MJoin2 generate d_year,c_nation,s_nation,lo_revenue;


--GRP1 = Group MJ2 by (MJ2.c_nation, MJ2.s_nation,MJ2.d_year);
--DJC = FOREACH GRP1 Generate  SUM(MJ2.lo_revenue) as revenue,MJ2.d_year,MJ2.c_nation, MJ2.s_nation;

--Illustrate DJC;
--illustrate orddj3;
dump orddj3;
--store orddj3 into 'pigquery31' USING PigStorage(',');

