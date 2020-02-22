select
	dd.Distributor_id ,
	dd.Distribution_Registration_Date 
from
	dim_distributor dd
where
	Distribution_Registration_Date >= ?minDate
	and Distribution_Registration_Date <= ?maxDate
