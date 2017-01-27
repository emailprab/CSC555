
create table lineorder (
  lo_orderkey          int,
  lo_linenumber        int,
  lo_custkey           int,
  lo_partkey           int,
  lo_suppkey           int,
  lo_orderdate         int,
  lo_orderpriority     varchar(15),
  lo_shippriority      varchar(1),
  lo_quantity          int,
  lo_extendedprice     int,
  lo_ordertotalprice   int,
  lo_discount          int,
  lo_revenue           int,
  lo_supplycost        int,
  lo_tax               int,
  lo_commitdate         int,
  lo_shipmode          varchar(10)    
)
ROW FORMAT DELIMITED FIELDS 
TERMINATED BY '|' STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/home/ec2-user/data/scale4/lineorder.tbl' 
OVERWRITE INTO TABLE lineorder;
CREATE VIEW lineordercsv AS
select concat (
  lo_orderkey          ,',',
  lo_linenumber        ,',',
  lo_custkey           ,',',
  lo_partkey           ,',',
  lo_suppkey           ,',',
  lo_orderdate         ,',',
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

CREATE VIEW lineorderspace AS
select concat (
  lo_orderkey          ,' ',
  lo_linenumber        ,' ',
  lo_custkey           ,' ',
  lo_partkey           ,' ',
  lo_suppkey           ,' ',
  lo_orderdate         ,' ',
  lo_orderpriority     ,' ',
  lo_shippriority      ,' ',
  lo_quantity          ,' ',
  lo_extendedprice     ,' ',
  lo_ordertotalprice   ,' ',
  lo_discount          ,' ',
  lo_revenue           ,' ',
  lo_supplycost        ,' ',
  lo_tax               ,' ',
  lo_commitdate        
 )  
from lineorder;


