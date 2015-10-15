create table qiao.cex as
with columns as (
	select a.*,
		substring(a.geoid from 8 for 19) as bg_id,
		b.b25027_002 as owned_with_mortgage,
		b.b25027_010 as owned_without_mortage,
		b.b25032_013 as rented,
		c.b05002_005 as northeast,
		c.b05002_006 as midwest,
		c.b05002_007 as south,
		c.b05002_008 as west,
		d.b07202_001 as in_metropolitan,
		d.b07203_001 as not_in_metropolitan,
		e.b09002_003+e.b09002_004+e.b09002_005+e.b09002_010+e.b09002_011+e.b09002_012+
		e.b09002_016+e.b09002_017+e.b09002_018 as children_under_6,
		e.b09002_006+e.b09002_013+e.b09002_019 as children_6_11,
		e.b09002_007+e.b09002_014+e.b09002_020 as children_12_17,
		f.b19037_004+f.b19037_021+f.b19037_038+f.b19037_055 as inclass_10k_15k,
		f.b19037_005+f.b19037_022+f.b19037_039+f.b19037_056 as inclass_15k_20k,
		f.b19037_006+f.b19037_007+f.b19037_023+f.b19037_024+f.b19037_040+f.b19037_041+f.b19037_057+f.b19037_058 as inclass_20k_30k,
		f.b19037_008+f.b19037_009+f.b19037_025+f.b19037_026+f.b19037_042+f.b19037_043+f.b19037_059+f.b19037_060 as inclass_30k_40k,
		f.b19037_010+f.b19037_011+f.b19037_027+f.b19037_028+f.b19037_044+f.b19037_045+f.b19037_061+f.b19037_062 as inclass_40k_50k,
		g.b25040_002+g.b25040_003 as gas,
		g.b25040_004 as electricity,
		g.b25040_005 as fuel_oil,
		g.b25040_006+g.b25040_007+g.b25040_008+g.b25040_009 as other,
		g.b25040_010 as no_fuel_used,
		g.b25041_002 as housing_units_no_bedroom,
		g.b25041_003 as housing_units_1_bedroom,
		g.b25041_004 as housing_units_2_bedrooms,
		g.b25041_005 as housing_units_3_bedrooms,
		g.b25041_006 as housing_units_4_bedrooms,
		g.b25041_007 as housing_units_5_more_bedrooms,
		h.b15001_005::int+h.b15001_013::int+h.b15001_021::int+h.b15001_029::int+h.b15001_037::int+h.b15001_046::int+
		h.b15001_054::int+h.b15001_062::int+h.b15001_070::int+h.b15001_078::int as edu_9_12th_no_diploma,
		h.b15001_006::int+h.b15001_014::int+h.b15001_022::int+h.b15001_030::int+h.b15001_038::int+h.b15001_047::int+
		h.b15001_055::int+h.b15001_063::int+h.b15001_071::int+h.b15001_079::int as edu_hsch_graduate,
		h.b15001_007::int+h.b15001_015::int+h.b15001_023::int+h.b15001_031::int+h.b15001_039::int+h.b15001_048::int+
		h.b15001_056::int+h.b15001_064::int+h.b15001_072::int+h.b15001_080::int as edu_less_than_college,
		h.b15001_008::int+h.b15001_016::int+h.b15001_024::int+h.b15001_032::int+h.b15001_040::int+h.b15001_049::int+
		h.b15001_057::int+h.b15001_065::int+h.b15001_073::int+h.b15001_081::int as edu_associate,
		h.b15001_009::int+h.b15001_017::int+h.b15001_025::int+h.b15001_033::int+h.b15001_041::int+h.b15001_050::int+
		h.b15001_058::int+h.b15001_066::int+h.b15001_074::int+h.b15001_082::int as edu_bachelor,
		h.b15001_010::int+h.b15001_018::int+h.b15001_026::int+h.b15001_034::int+h.b15001_042::int+h.b15001_051::int+
		h.b15001_059::int+h.b15001_067::int+h.b15001_075::int+h.b15001_083::int as edu_master,
		i.b06008_003 as married,
		i.b06008_006 as widowed,
		i.b06008_004 as divorced,
		i.b06008_005 as separated,
		i.b06008_002 as never_married,
		j.b03001_004 as mexican,
		j.b03001_005 as puerto_rican,
		j.b03001_006 as cuban,
		j.b03001_003 as hispanic,
		j.b03001_002 as non_hispanic,
		h.b15002_003+h.b15002_020 as high_edu_never_attended,
		h.b15002_004+h.b15002_005+h.b15002_006+h.b15002_021+h.b15002_022+h.b15002_023 as high_edu_1_8,
		h.b15002_007+h.b15002_008+h.b15002_009+h.b15002_010+h.b15002_024+h.b15002_025+h.b15002_026+h.b15002_027 as high_edu_9_12,
		h.b15002_011+h.b15002_028 as high_edu_hs_graduate,
		h.b15002_012+h.b15002_013+h.b15002_029+h.b15002_030 as high_edu_some_college,
		h.b15002_014+h.b15002_031 as high_edu_aa_degree,
		h.b15002_015+h.b15002_032 as high_edu_bachelor,
		h.b15002_016+h.b15002_017+h.b15002_018+h.b15002_033+h.b15002_034+h.b15002_035 as high_edu_master,
		k.b24090_003::int+k.b24090_006::int+k.b24090_013::int+k.b24090_016::int as incomey_private_company,
		k.b24090_009::int+k.b24090_019::int as incomey_federal,
		k.b24090_008::int+k.b24090_018::int as incomey_state,
		k.b24090_007::int+k.b24090_017::int as incomey_local,
		k.b24090_005::int+k.b24090_015::int as incomey_self_employed,
		l.c24010_005+l.c24010_041 as administrator,
		l.c24010_014+l.c24010_050 as teacher,
		m.b25115_004::int+m.b25115_017::int as married_couple_only,
		m.b25115_007::int+m.b25115_020::int as all_other_married_couples,
		m.b25115_009::int+m.b25115_022::int as one_parent_male_with_child,
		m.b25115_012::int+m.b25115_025::int as one_parent_female_with_child,
		m.b25115_014::int+m.b25115_027::int as single_consumers,
		n.b19121_003 as median_income_1earner,
		n.b19121_004 as median_income_2earners,
		n.b19121_002 as median_income_no_earners,
		n.b19121_005 as median_income_3_more_earners,
		o.b02001_002 as white,
		o.b02001_003 as black,
		o.b02001_005 as asian,
		o.b02001_006 as pacific_islander,
		o.b02001_008 as multi_race,
		p.b01001_002 as male,
		p.b01001_026 as female,
		q.b07411_001 as fincbtax,
		r.b01002_002 as median_age_male,
		r.b01002_003 as median_age_female,
		s.b23020_001 as mean_hours_past_year,
		t.b11006_001 as households_with_65years_over,
		p.b01001_031+p.b01001_032+p.b01001_033+p.b01001_034+p.b01001_035+p.b01001_036+p.b01001_037+p.b01001_038+
		p.b01001_039+p.b01001_040+p.b01001_041+p.b01001_042+p.b01001_043+p.b01001_044+p.b01001_045+p.b01001_046+
		p.b01001_047+p.b01001_048+p.b01001_049 as female_over_16,
		p.b01001_007+p.b01001_008+p.b01001_009+p.b01001_010+p.b01001_011+p.b01001_012+p.b01001_013+p.b01001_014+
		p.b01001_015+p.b01001_016+p.b01001_017+p.b01001_018+p.b01001_019+p.b01001_020+p.b01001_021+p.b01001_022+
		p.b01001_023+p.b01001_024+p.b01001_025 as male_over_16,
		p.b01001_003+p.b01001_004+p.b01001_005+p.b01001_006 as male_under_18,
		p.b01001_027+p.b01001_028+p.b01001_029+p.b01001_030 as female_under_18,
		u.b17012_002 as income_past_12_months_below_poverty_level,
		u.b17012_019 as income_past_12_months_above_poverty_level
	from acs5yr_census_2013._g20135 a
	join acs5yr_census_2013._e201350104000 b
		on a.logrecno=b.logrecno
		and lower(a.stusab)=b.stusab		
	join acs5yr_census_2013._e201350009000 c
		on a.logrecno=c.logrecno
		and lower(a.stusab)=c.stusab
	join acs5yr_census_2013._e201350019000 d
		on a.logrecno=d.logrecno
		and lower(a.stusab)=d.stusab
	join acs5yr_census_2013._e201350034000 e
		on a.logrecno=e.logrecno
		and lower(a.stusab)=e.stusab
	join acs5yr_census_2013._e201350060000 f
		on a.logrecno=f.logrecno
		and lower(a.stusab)=f.stusab
	join acs5yr_census_2013._e201350105000 g
		on a.logrecno=g.logrecno
		and lower(a.stusab)=g.stusab
	join acs5yr_census_2013._e201350043000 h
		on a.logrecno=h.logrecno
		and lower(a.stusab)=h.stusab
		and (b15001_005 != '' or h.b15001_013 != '' or h.b15001_021 != '' or h.b15001_029 != '' or h.b15001_037 != '' or h.b15001_046 != '' or 
		h.b15001_054 != '' or h.b15001_062 != '' or h.b15001_070 != '' or h.b15001_078 != '' or 
		h.b15001_006 != '' or h.b15001_014 != '' or h.b15001_022 != '' or h.b15001_030 != '' or h.b15001_038 != '' or h.b15001_047 != '' or 
		h.b15001_055 != '' or h.b15001_063 != '' or h.b15001_071 != '' or h.b15001_079 != '' or 
		h.b15001_007 != '' or h.b15001_015 != '' or h.b15001_023 != '' or h.b15001_031 != '' or h.b15001_039 != '' or h.b15001_048 != '' or 
		h.b15001_056 != '' or h.b15001_064 != '' or h.b15001_072 != '' or h.b15001_080 != '' or 
		h.b15001_008 != '' or h.b15001_016 != '' or h.b15001_024 != '' or h.b15001_032 != '' or h.b15001_040 != '' or h.b15001_049 != '' or 
		h.b15001_057 != '' or h.b15001_065 != '' or h.b15001_073 != '' or h.b15001_081 != '' or 
		h.b15001_009 != '' or h.b15001_017 != '' or h.b15001_025 != '' or h.b15001_033 != '' or h.b15001_041 != '' or h.b15001_050 != '' or 
		h.b15001_058 != '' or h.b15001_066 != '' or h.b15001_074 != '' or h.b15001_082 != '' or 
		h.b15001_010 != '' or h.b15001_018 != '' or h.b15001_026 != '' or h.b15001_034 != '' or h.b15001_042 != '' or h.b15001_051 != '' or 
		h.b15001_059 != '' or h.b15001_067 != '' or h.b15001_075 != '' or h.b15001_083 != '' )
	join acs5yr_census_2013._e201350014000 i
		on a.logrecno=i.logrecno
		and lower(a.stusab)=i.stusab
	join acs5yr_census_2013._e201350005000 j
		on a.logrecno=j.logrecno
		and lower(a.stusab)=j.stusab
	join acs5yr_census_2013._e201350084000 k
		on a.logrecno=k.logrecno
		and lower(a.stusab)=k.stusab
	join acs5yr_census_2013._e201350080000 l
		on a.logrecno=l.logrecno
		and lower(a.stusab)=l.stusab
	join acs5yr_census_2013._e201350109000 m
		on a.logrecno=m.logrecno
		and lower(a.stusab)=m.stusab
	join acs5yr_census_2013._e201350064000 n
		on a.logrecno=n.logrecno
		and lower(a.stusab)=n.stusab
	join acs5yr_census_2013._e201350004000 o
		on a.logrecno=o.logrecno
		and lower(a.stusab)=o.stusab
	join acs5yr_census_2013._e201350002000 p
		on a.logrecno=p.logrecno
		and lower(a.stusab)=p.stusab
	join acs5yr_census_2013._e201350022000 q
		on a.logrecno=q.logrecno
		and lower(a.stusab)=q.stusab
	join acs5yr_census_2013._e201350003000 r
		on a.logrecno=r.logrecno
		and lower(a.stusab)=r.stusab
	join acs5yr_census_2013._e201350078000 s
		on a.logrecno=s.logrecno
		and lower(a.stusab)=s.stusab
	join acs5yr_census_2013._e201350037000 t
		on a.logrecno=t.logrecno
		and lower(a.stusab)=t.stusab
	join acs5yr_census_2013._e201350053000 u
		on a.logrecno=u.logrecno
		and lower(a.stusab)=u.stusab
		)
		select * from columns
		
		alter table qiao.cex add column owned_with_mortgage_z double precision;
		with averages as (
			select avg(owned_with_mortgage::double precision), 		stddev(owned_with_mortgage::double precision) from qiao.cex) 
			update qiao.cex set owned_with_mortgage_z = (owned_with_mortgage::double 		precision-avg)/stddev from averages;

		alter table qiao.cex add column owned_without_mortage_z double precision;
		with averages as (
			select avg(owned_without_mortage::double precision), 		stddev(owned_without_mortage::double precision) from qiao.cex) 
			update qiao.cex set owned_without_mortage_z = (owned_without_mortage::double 		precision-avg)/stddev from averages;

		alter table qiao.cex add column rented_z double precision;
		with averages as (
			select avg(rented), stddev(rented) from qiao.cex) 
			update qiao.cex set rented_z = (rented-avg)/stddev from averages;

		alter table qiao.cex add column northeast_z double precision;
		with averages as (
				select avg(northeast::double precision), 	
					stddev(northeast::double precision) from qiao.cex) 
				update qiao.cex set northeast_z = (northeast::double precision-avg)/stddev from averages;		

		alter table qiao.cex add column midwest_z double precision;
		with averages as (
				select avg(midwest::double precision), stddev(midwest::double precision) 			from qiao.cex) 
				update qiao.cex set midwest_z = (midwest::double precision-avg)/stddev 			from averages;
			
		alter table qiao.cex add column south_z double precision;
		with averages as (
				select avg(south::double precision), stddev(south::double precision) 			from qiao.cex) 
				update qiao.cex set south_z = (south::double precision-avg)/stddev 			from averages;
				
		alter table qiao.cex add column west_z double precision;
		with averages as (
				select avg(west::double precision), stddev(west::double precision) from qiao.cex) 
				update qiao.cex set west_z = (west::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column in_metropolitan_z double precision;
		with averages as (
				select avg(in_metropolitan), stddev(in_metropolitan) from qiao.cex) 
				update qiao.cex set in_metropolitan_z = (in_metropolitan-avg)/stddev from averages;
				
		alter table qiao.cex add column not_in_metropolitan_z double precision;
		with averages as (
				select avg(not_in_metropolitan), stddev(not_in_metropolitan) from qiao.cex) 
				update qiao.cex set not_in_metropolitan_z = (not_in_metropolitan-avg)/stddev from averages;
			
		alter table qiao.cex add column children_under_6_z double precision;
		with averages as (
				select avg(children_under_6), stddev(children_under_6) from qiao.cex) 
				update qiao.cex set children_under_6_z = (children_under_6-avg)/stddev from averages;
			
		alter table qiao.cex add column children_6_11_z double precision;
		with averages as (
				select avg(children_6_11), stddev(children_6_11) from qiao.cex) 
				update qiao.cex set children_6_11_z = (children_6_11-avg)/stddev from averages;
			
		alter table qiao.cex add column children_12_17_z double precision;
		with averages as (
				select avg(children_12_17), stddev(children_12_17) from qiao.cex) 
				update qiao.cex set children_12_17_z = (children_12_17-avg)/stddev from averages;
			
		alter table qiao.cex add column inclass_10k_15k_z double precision;
		with averages as (
				select avg(inclass_10k_15k), stddev(inclass_10k_15k) from qiao.cex) 
				update qiao.cex set inclass_10k_15k_z = (inclass_10k_15k-avg)/stddev from averages;
				
		alter table qiao.cex add column inclass_15k_20k_z double precision;
		with averages as (
				select avg(inclass_15k_20k), stddev(inclass_15k_20k) from qiao.cex) 
				update qiao.cex set inclass_15k_20k_z = (inclass_15k_20k-avg)/stddev from averages;
			
		alter table qiao.cex add column inclass_20k_30k_z double precision;
		with averages as (
				select avg(inclass_20k_30k), stddev(inclass_20k_30k) from qiao.cex) 
				update qiao.cex set inclass_20k_30k_z = (inclass_20k_30k-avg)/stddev from averages;
				
		alter table qiao.cex add column inclass_30k_40k_z double precision;
		with averages as (
				select avg(inclass_30k_40k), stddev(inclass_30k_40k) from qiao.cex) 
				update qiao.cex set inclass_30k_40k_z = (inclass_30k_40k-avg)/stddev from averages;
				
		alter table qiao.cex add column inclass_40k_50k_z double precision;
		with averages as (
				select avg(inclass_40k_50k), stddev(inclass_40k_50k) from qiao.cex) 
				update qiao.cex set inclass_40k_50k_z = (inclass_40k_50k-avg)/stddev from averages;
			
		alter table qiao.cex add column gas_z double precision;
		with averages as (
				select avg(gas), stddev(gas) from qiao.cex) 
				update qiao.cex set gas_z = (gas-avg)/stddev from averages;
			
		alter table qiao.cex add column electricity_z double precision;
		with averages as (
				select avg(electricity), stddev(electricity) from qiao.cex) 
				update qiao.cex set electricity_z = (electricity-avg)/stddev from averages;
			
		alter table qiao.cex add column fuel_oil_z double precision;
		with averages as (
				select avg(fuel_oil), stddev(fuel_oil) from qiao.cex) 
				update qiao.cex set fuel_oil_z = (fuel_oil-avg)/stddev from averages;
			
		alter table qiao.cex add column other_z double precision;
		with averages as (
				select avg(other), stddev(other) from qiao.cex) 
				update qiao.cex set other_z = (other-avg)/stddev from averages;
			
		alter table qiao.cex add column no_fuel_used_z double precision;
		with averages as (
				select avg(no_fuel_used), stddev(no_fuel_used) from qiao.cex) 
				update qiao.cex set no_fuel_used_z = (no_fuel_used-avg)/stddev from averages;
			
		alter table qiao.cex add column housing_units_no_bedroom_z double precision;
		with averages as (
				select avg(housing_units_no_bedroom), stddev(housing_units_no_bedroom) from qiao.cex) 
				update qiao.cex set housing_units_no_bedroom_z = (housing_units_no_bedroom-avg)/stddev from averages;
			
		alter table qiao.cex add column housing_units_1_bedroom_z double precision;
		with averages as (
				select avg(housing_units_1_bedroom), stddev(housing_units_1_bedroom) from qiao.cex) 
				update qiao.cex set housing_units_1_bedroom_z = (housing_units_1_bedroom-avg)/stddev from averages;
			
		alter table qiao.cex add column housing_units_2_bedrooms_z double precision;
		with averages as (
				select avg(housing_units_2_bedrooms), stddev(housing_units_2_bedrooms) from qiao.cex) 
				update qiao.cex set housing_units_2_bedrooms_z = (housing_units_2_bedrooms-avg)/stddev from averages;
			
		alter table qiao.cex add column housing_units_3_bedrooms_z double precision;
		with averages as (
				select avg(housing_units_3_bedrooms), stddev(housing_units_3_bedrooms) from qiao.cex) 
				update qiao.cex set housing_units_3_bedrooms_z = (housing_units_3_bedrooms-avg)/stddev from averages;
			
		alter table qiao.cex add column housing_units_4_bedrooms_z double precision;
		with averages as (
				select avg(housing_units_4_bedrooms), stddev(housing_units_4_bedrooms) from qiao.cex) 
				update qiao.cex set housing_units_4_bedrooms_z = (housing_units_4_bedrooms-avg)/stddev from averages;
			
		alter table qiao.cex add column housing_units_5_more_bedrooms_z double precision;
		with averages as (
				select avg(housing_units_5_more_bedrooms), stddev(housing_units_5_more_bedrooms) from qiao.cex) 
				update qiao.cex set housing_units_5_more_bedrooms_z = (housing_units_5_more_bedrooms-avg)/stddev from averages;
			
		alter table qiao.cex add column edu_9_12th_no_diploma_z double precision;
		with averages as (
				select avg(edu_9_12th_no_diploma), stddev(edu_9_12th_no_diploma) from qiao.cex) 
				update qiao.cex set edu_9_12th_no_diploma_z = (edu_9_12th_no_diploma-avg)/stddev from averages;
			
		alter table qiao.cex add column edu_hsch_graduate_z double precision;
		with averages as (
				select avg(edu_hsch_graduate), stddev(edu_hsch_graduate) from qiao.cex) 
				update qiao.cex set edu_hsch_graduate_z = (edu_hsch_graduate-avg)/stddev from averages;
			
		alter table qiao.cex add column edu_less_than_college_z double precision;
		with averages as (
				select avg(edu_less_than_college), stddev(edu_less_than_college) from qiao.cex) 
				update qiao.cex set edu_less_than_college_z = (edu_less_than_college-avg)/stddev from averages;
			
		alter table qiao.cex add column edu_associate_z double precision;
		with averages as (
				select avg(edu_associate), stddev(edu_associate) from qiao.cex) 
				update qiao.cex set edu_associate_z = (edu_associate-avg)/stddev from averages;
						
		alter table qiao.cex add column edu_bachelor_z double precision;
		with averages as (
				select avg(edu_bachelor), stddev(edu_bachelor) from qiao.cex) 
				update qiao.cex set edu_bachelor_z = (edu_bachelor-avg)/stddev from averages;
			
		alter table qiao.cex add column edu_master_z double precision;
		with averages as (
				select avg(edu_master), stddev(edu_master) from qiao.cex) 
				update qiao.cex set edu_master_z = (edu_master-avg)/stddev from averages;
			
		alter table qiao.cex add column married_z double precision;
		with averages as (
				select avg(married::double precision), stddev(married::double precision) from qiao.cex) 
				update qiao.cex set married_z = (married::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column widowed_z double precision;
		with averages as (
				select avg(widowed::double precision), stddev(widowed::double precision) from qiao.cex) 
				update qiao.cex set widowed_z = (widowed::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column divorced_z double precision;
		with averages as (
				select avg(divorced::double precision), stddev(divorced::double precision) from qiao.cex) 
				update qiao.cex set divorced_z = (divorced::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column separated_z double precision;
		with averages as (
				select avg(separated::double precision), stddev(separated::double precision) from qiao.cex) 
				update qiao.cex set separated_z = (separated::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column never_married_z double precision;
		with averages as (
				select avg(never_married::double precision), stddev(never_married::double precision) from qiao.cex) 
				update qiao.cex set never_married_z = (never_married::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column mexican_z double precision;
		with averages as (
				select avg(mexican::double precision), stddev(mexican::double precision) from qiao.cex) 
				update qiao.cex set mexican_z = (mexican::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column puerto_rican_z double precision;
		with averages as (
				select avg(puerto_rican::double precision), stddev(puerto_rican::double precision) from qiao.cex) 
				update qiao.cex set puerto_rican_z = (puerto_rican::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column cuban_z double precision;
		with averages as (
				select avg(cuban::double precision), stddev(cuban::double precision) from qiao.cex) 
				update qiao.cex set cuban_z = (cuban::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column hispanic_z double precision;
		with averages as (
				select avg(hispanic::double precision), stddev(hispanic::double precision) from qiao.cex) 
				update qiao.cex set hispanic_z = (hispanic::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column non_hispanic_z double precision;
		with averages as (
				select avg(non_hispanic::double precision), stddev(non_hispanic::double precision) from qiao.cex) 
				update qiao.cex set non_hispanic_z = (non_hispanic::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column high_edu_never_attended_z double precision;
		with averages as (
				select avg(high_edu_never_attended), stddev(high_edu_never_attended) from qiao.cex) 
				update qiao.cex set high_edu_never_attended_z = (high_edu_never_attended::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column high_edu_1_8_z double precision;
		with averages as (
				select avg(high_edu_1_8), stddev(high_edu_1_8) from qiao.cex) 
				update qiao.cex set high_edu_1_8_z = (high_edu_1_8::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column high_edu_9_12_z double precision;
		with averages as (
				select avg(high_edu_9_12), stddev(high_edu_9_12) from qiao.cex) 
				update qiao.cex set high_edu_9_12_z = (high_edu_9_12::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column high_edu_hs_graduate_z double precision;
		with averages as (
				select avg(high_edu_hs_graduate), stddev(high_edu_hs_graduate) from qiao.cex) 
				update qiao.cex set high_edu_hs_graduate_z = (high_edu_hs_graduate::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column high_edu_some_college_z double precision;
		with averages as (
				select avg(high_edu_some_college), stddev(high_edu_some_college) from qiao.cex) 
				update qiao.cex set high_edu_some_college_z = (high_edu_some_college::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column high_edu_aa_degree_z double precision;
		with averages as (
				select avg(high_edu_aa_degree), stddev(high_edu_aa_degree) from qiao.cex) 
				update qiao.cex set high_edu_aa_degree_z = (high_edu_aa_degree::double precision-avg)/stddev from averages;
			
		alter table qiao.cex add column high_edu_bachelor_z double precision;
		with averages as (
				select avg(high_edu_bachelor), stddev(high_edu_bachelor) from qiao.cex) 
				update qiao.cex set high_edu_bachelor_z = (high_edu_bachelor-avg)/stddev from averages;
			
		alter table qiao.cex add column high_edu_master_z double precision;
		with averages as (
				select avg(high_edu_master), stddev(high_edu_master) from qiao.cex) 
				update qiao.cex set high_edu_master_z = (high_edu_master-avg)/stddev from averages;
			
		alter table qiao.cex add column incomey_private_company_z double precision;
		with averages as (
				select avg(incomey_private_company), stddev(incomey_private_company) from qiao.cex) 
				update qiao.cex set incomey_private_company_z = (incomey_private_company-avg)/stddev from averages;
			
		alter table qiao.cex add column incomey_federal_z double precision;
		with averages as (
				select avg(incomey_federal), stddev(incomey_federal) from qiao.cex) 
				update qiao.cex set incomey_federal_z = (incomey_federal-avg)/stddev from averages;
			
		alter table qiao.cex add column incomey_state_z double precision;
		with averages as (
				select avg(incomey_state), stddev(incomey_state) from qiao.cex) 
				update qiao.cex set incomey_state_z = (incomey_state-avg)/stddev from averages;
			
		alter table qiao.cex add column incomey_local_z double precision;
		with averages as (
				select avg(incomey_local), stddev(incomey_local) from qiao.cex) 
				update qiao.cex set incomey_local_z = (incomey_local-avg)/stddev from averages;
			
		alter table qiao.cex add column incomey_self_employed_z double precision;
		with averages as (
				select avg(incomey_self_employed), stddev(incomey_self_employed) from qiao.cex) 
				update qiao.cex set incomey_self_employed_z = (incomey_self_employed-avg)/stddev from averages;
			
		alter table qiao.cex add column administrator_z double precision;
		with averages as (
				select avg(administrator), stddev(administrator) from qiao.cex) 
				update qiao.cex set administrator_z = (administrator-avg)/stddev from averages;
			
		alter table qiao.cex add column teacher_z double precision;
		with averages as (
				select avg(teacher), stddev(teacher) from qiao.cex) 
				update qiao.cex set teacher_z = (teacher-avg)/stddev from averages;
			
		alter table qiao.cex add column married_couple_only_z double precision;
		with averages as (
				select avg(married_couple_only), stddev(married_couple_only) from qiao.cex) 
				update qiao.cex set teacher_z = (married_couple_only-avg)/stddev from averages;
			
		alter table qiao.cex add column all_other_married_couples_z double precision;
		with averages as (
				select avg(all_other_married_couples), stddev(all_other_married_couples) from qiao.cex) 
				update qiao.cex set all_other_married_couples_z = (all_other_married_couples-avg)/stddev from averages;
			
		alter table qiao.cex add column one_parent_male_with_child_z double precision;
		with averages as (
				select avg(one_parent_male_with_child), stddev(one_parent_male_with_child) from qiao.cex) 
				update qiao.cex set one_parent_male_with_child_z = (one_parent_male_with_child-avg)/stddev from averages;
			
		alter table qiao.cex add column one_parent_female_with_child_z double precision;
		with averages as (
				select avg(one_parent_female_with_child), stddev(one_parent_female_with_child) from qiao.cex) 
				update qiao.cex set one_parent_female_with_child_z = (one_parent_female_with_child-avg)/stddev from averages;
			
		alter table qiao.cex add column single_consumers_z double precision;
		with averages as (
				select avg(single_consumers), stddev(single_consumers) from qiao.cex) 
				update qiao.cex set single_consumers_z = (single_consumers-avg)/stddev from averages;
			
alter table qiao.cex add column median_income_1earner_z double precision;
with averages as (
			select avg(median_income_1earner::double precision), stddev(median_income_1earner::double precision) from qiao.cex
			where median_income_1earner != '.') 
			update qiao.cex set median_income_1earner_z = (median_income_1earner::double precision-avg)/stddev from averages
			where median_income_1earner != '.';
			
alter table qiao.cex add column median_income_2earners_z double precision;
with averages as (
		select avg(median_income_2earners::double precision), stddev(median_income_2earners::double precision) from qiao.cex
		where median_income_2earners != '.') 
		update qiao.cex set median_income_2earners_z = (median_income_2earners::double precision-avg)/stddev from averages
		where median_income_2earners != '.';
			
alter table qiao.cex add column median_income_no_earners_z double precision;
with averages as (
		select avg(median_income_no_earners::double precision), stddev(median_income_no_earners::double precision) from qiao.cex
		where median_income_no_earners != '.') 
		update qiao.cex set median_income_no_earners_z = (median_income_no_earners::double precision-avg)/stddev from averages
		where median_income_no_earners != '.';
			
alter table qiao.cex add column median_income_3_more_earners_z double precision;
with averages as (
		select avg(median_income_3_more_earners::double precision), stddev(median_income_3_more_earners::double precision) from qiao.cex
		where median_income_3_more_earners != '.') 
		update qiao.cex set median_income_3_more_earners_z = (median_income_3_more_earners::double precision-avg)/stddev from averages
		where median_income_3_more_earners != '.';
			
		alter table qiao.cex add column white_z double precision;
		with averages as (
				select avg(white), stddev(white) from qiao.cex) 
				update qiao.cex set white_z = (white-avg)/stddev from averages;
			
		alter table qiao.cex add column black_z double precision;
		with averages as (
				select avg(black), stddev(black) from qiao.cex) 
				update qiao.cex set black_z = (black-avg)/stddev from averages;
			
		alter table qiao.cex add column asian_z double precision;
		with averages as (
				select avg(asian), stddev(asian) from qiao.cex) 
				update qiao.cex set asian_z = (asian-avg)/stddev from averages;
			
		alter table qiao.cex add column pacific_islander_z double precision;
		with averages as (
				select avg(pacific_islander), stddev(pacific_islander) from qiao.cex) 
				update qiao.cex set pacific_islander_z = (pacific_islander-avg)/stddev from averages;
			
		alter table qiao.cex add column multi_race_z double precision;
		with averages as (
				select avg(multi_race), stddev(multi_race) from qiao.cex) 
				update qiao.cex set multi_race_z = (multi_race-avg)/stddev from averages;
			
		alter table qiao.cex add column male_z double precision;
		with averages as (
				select avg(male), stddev(male) from qiao.cex) 
				update qiao.cex set male_z = (male-avg)/stddev from averages;
			
		alter table qiao.cex add column female_z double precision;
		with averages as (
				select avg(female), stddev(female) from qiao.cex) 
				update qiao.cex set female_z = (female-avg)/stddev from averages;