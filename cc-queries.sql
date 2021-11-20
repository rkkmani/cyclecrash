delete from cyclecrash.cyclecrash_oldstaging;
copy cyclecrash.cyclecrash_oldstaging from 'C:\durga\crash\staging\Crash-Cyclist-2020.csv' delimiter ',' csv header;
delete from cyclecrash.cyclecrash_oldgoodrecords;
insert into cyclecrash.cyclecrash_oldgoodrecords select format_date_or_return_string(crash_date) ,format_time_or_return_string(crash_time),Borough,cast(zipcode as integer),lattitude,longitude,location, On_street_name , cross_street_name, off_street_name ,
        number_of_Persons_injured  ,NUMBER_OF_PERSONS_KILLED ,NUMBER_OF_PEDESTRIANS_INJURED ,NUMBER_OF_PEDESTRIANS_KILLED , NUMBER_OF_CYCLIST_INJURED ,NUMBER_OF_CYCLIST_KILLED ,
	NUMBER_OF_MOTORIST_INJURED ,NUMBER_OF_MOTORIST_KILLED ,	CONTRIBUTING_FACTOR_VEHICLE_1 ,CONTRIBUTING_FACTOR_VEHICLE_2 ,CONTRIBUTING_FACTOR_VEHICLE_3 ,
	CONTRIBUTING_FACTOR_VEHICLE_4 ,CONTRIBUTING_FACTOR_VEHICLE_5 ,COLLISION_ID ,VEHICLE_TYPE_CODE_1,VEHICLE_TYPE_CODE_2 ,VEHICLE_TYPE_CODE_3,VEHICLE_TYPE_CODE_4,
	VEHICLE_TYPE_CODE_5 from cyclecrash.cyclecrash_oldstaging where format_date_or_return_string(crash_date) is not null and format_time_or_return_string(crash_time) is not null;

select 'Total good Records:',count(*) from cyclecrash.cyclecrash_oldgoodrecords;

delete from cyclecrash.cyclecrash_newstaging;
copy cyclecrash.cyclecrash_newstaging from 'C:\durga\crash\goodRecords\Crash-Cyclist-2020-sk.csv' delimiter ',' csv header;
delete from cyclecrash.cyclecrash_newgoodrecords;
insert into cyclecrash.cyclecrash_newgoodrecords select format_date_or_return_string(crash_date) ,format_time_or_return_string(crash_time),Borough,cast(zipcode as integer),lattitude,longitude,location, On_street_name , cross_street_name, off_street_name ,
        number_of_Persons_injured  ,NUMBER_OF_PERSONS_KILLED ,NUMBER_OF_PEDESTRIANS_INJURED ,NUMBER_OF_PEDESTRIANS_KILLED , NUMBER_OF_CYCLIST_INJURED ,NUMBER_OF_CYCLIST_KILLED ,
	NUMBER_OF_MOTORIST_INJURED ,NUMBER_OF_MOTORIST_KILLED ,	CONTRIBUTING_FACTOR_VEHICLE_1 ,CONTRIBUTING_FACTOR_VEHICLE_2 ,CONTRIBUTING_FACTOR_VEHICLE_3 ,
	CONTRIBUTING_FACTOR_VEHICLE_4 ,CONTRIBUTING_FACTOR_VEHICLE_5 ,COLLISION_ID ,VEHICLE_TYPE_CODE_1,VEHICLE_TYPE_CODE_2 ,VEHICLE_TYPE_CODE_3,VEHICLE_TYPE_CODE_4,
	VEHICLE_TYPE_CODE_5 from cyclecrash.cyclecrash_newstaging where format_date_or_return_string(crash_date) is not null and format_time_or_return_string(crash_time) is not null;

select 'Total good Records:',count(*) from cyclecrash.cyclecrash_newgoodrecords;
select 'Missing Records in new file:';
select n.* from cyclecrash.cyclecrash_newGoodRecords n left join cyclecrash.cyclecrash_oldGoodRecords g on n.COLLISION_ID=g.COLLISION_ID where g.COLLISION_ID is null ;

select 'missing Records in old file :';;
select g.* from cyclecrash.cyclecrash_newGoodRecords n right join cyclecrash.cyclecrash_oldGoodRecords g on n.COLLISION_ID=g.COLLISION_ID where n.COLLISION_ID is null ;
select o.* from cyclecrash.cyclecrash_newGoodRecords n join cyclecrash.cyclecrash_oldGoodRecords o on n.COLLISION_ID=o.COLLISION_ID where
 md5(n.crash_date::text||n.crash_time::text||n.borough||n.zipcode)!= md5(o.crash_date::text||o.crash_time::text||o.borough||o.zipcode);
