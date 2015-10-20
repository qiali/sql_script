create table qiao.trips 
	as select tripid, 
	degrees(st_azimuth(st_point(startloclon::double precision,
		startloclat::double precision),st_point(endloclon::double precision,
		endloclat::double precision))) as azimuth,
	substring(enddate from 12 for 2)::double precision * 60 + substring(enddate from 15 for 2)::double precision - 
	substring(startdate from 12 for 2)::double precision - substring(startdate from 15 for 2)::double precision 
	as time_lapse_minutes,
	mode as type 
	from traffic_inrix_2015.trips;

create table qiao.trips_1 
	as select a.waypointsequence, a.shape, b.tripid, b.azimuth, b.time_lapse_minutes, b.type 
	from traffic_inrix_2015.waypoints a 
	join qiao.trips b 
	on a.tripid = b.tripid;

create table qiao.traffic_trips as
with unfiltered as 
	(select t1.tripid, t1.azimuth, t1.time_lapse_minutes, t1.type, sum(st_distance(t1.shape, t2.shape)) as dist_meter
	from qiao.trips_1 t1, qiao.trips_1 t2 where t2.waypointsequence::int=t1.waypointsequence::int+1 
	and t1.tripid = t2.tripid
	group by t1.tripid, t1.azimuth, t1.time_lapse_minutes, t1.type)
	select * from unfiltered;