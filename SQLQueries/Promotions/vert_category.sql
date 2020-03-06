select 
  Product_CategoryName,
  count(DISTINCT Promotion_Id)
from 
  fact_promotions_vestige fpv
where 
  Invoice_Date >= ?minDate
  and
  Invoice_Date <= ?maxDate
group by 
  Product_CategoryName