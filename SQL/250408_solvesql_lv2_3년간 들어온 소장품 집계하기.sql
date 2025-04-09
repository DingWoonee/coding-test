select
  classification,
  sum(case when strftime('%Y', acquisition_date) = '2014' then 1 else 0 end) as '2014',
  sum(case when strftime('%Y', acquisition_date) = '2015' then 1 else 0 end) as '2015',
  sum(case when strftime('%Y', acquisition_date) = '2016' then 1 else 0 end) as '2016'
from artworks
group by classification
order by classification;