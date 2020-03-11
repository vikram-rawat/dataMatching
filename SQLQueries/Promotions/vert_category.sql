select 
  Product_CategoryName as product_category,
  count(DISTINCT Promotion_Id) as counts
from 
  fact_promotions_vestige fpv
where 
  Invoice_Date >= ?minDate
  and
  Invoice_Date <= ?maxDate
group by 
  Product_CategoryName
order by
  counts 
	desc