select
distinct dm.DistributorId,
	dm.DistributorRegistrationDate 
from
	DistributorMaster dm
where
	dm.DistributorRegistrationDate >= ?minDate
	and 
	dm.DistributorRegistrationDate <= ?maxDate