select concat (
  lo_orderkey          ,',',
  lo_linenumber        ,',',
  lo_custkey           ,',',
  lo_partkey           ,',',
  lo_suppkey           ,',',
  lo_orderdate         ,',',
  lo_orderpriority     ,',',
  lo_shippriority      ,',',
  lo_quantity          ,',',
  lo_extendedprice     ,',',
  lo_ordertotalprice   ,',',
  lo_discount          ,',',
  lo_revenue           ,',',
  lo_supplycost        ,',',
  lo_tax               ,',',
  lo_commitdate        ,',',
  lo_shipmode )  
from lineorder;

