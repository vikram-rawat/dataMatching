SELECT
  CountryName,
  count(DISTINCT DistributorId) as DistributorCount,
  count(DISTINCT InvoiceNo ) as TotalInvoiceCount,
  sum(Quantity ) as TotalQuantity,
  sum(LineAmount + LineTaxAmount) as TotalInvoiceAmt,
  sum(LineAmount + LineTaxAmount)/ sum(Quantity ) as ASP,
  sum(Quantity) / count(DISTINCT InvoiceNo ) as Cart,
  sum(LinePV * Quantity ) as TotalPV ,	
  sum(LineBV * Quantity) / sum( LinePV * Quantity ) as BVPV_Ratio,
  sum(LineAmount + LineTaxAmount)/ count(DISTINCT InvoiceNo ) as averageInvoiceAmt
from
  fact_sales_order_vestige fsov
where
  to_char(invoicedate::date,
        'YYYY-MM-DD') BETWEEN ?minDate and ?maxDate
  and 
  Status = 1
GROUP by
  CountryName;