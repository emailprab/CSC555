dwdate = LOAD '/phase2/data/scale4/dwdate.tbl' USING PigStorage('|') 
AS (d_datekey:int,
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
dwd = FOREACH dwdate GENERATE $0,$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16;

store dwd into 'dwdateout.csv' USING PigStorage(',');


