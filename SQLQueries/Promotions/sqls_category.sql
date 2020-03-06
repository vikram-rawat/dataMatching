select 
  displaycategoryName,
  Count(distinct promotionid) as Numbers
from 
  ciheader(nolock)ci
inner join 
  cidetail(nolock) cid 
  on 
  cid.invoiceno = ci.invoiceno
inner join 
  cidetaildiscount(nolock)cdd 
  on 
  cdd.invoiceno = ci.invoiceno
inner join 
  item_master(nolock) im 
  on 
  im.itemid = cid.itemid
where 
  invoicedate >= ?minDate
  and
  invoicedate <= ?maxDate 
  and 
  ispromo = 1 and ci.status=1
Group by 
  displaycategoryName