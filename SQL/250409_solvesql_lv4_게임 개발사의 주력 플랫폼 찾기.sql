with top_platform as (
  select
    developer_id,
    platform_id,
    sum(sales_na + sales_eu + sales_jp + sales_other) as sales
    -- 이게 나는 왜 정답인지 모르겠다. 아래걸로 하는게 맞지 않나?
    -- sum(sales_na) + sum(sales_eu) + sum(sales_jp) + sum(sales_other)
  from games
  group by platform_id, developer_id
)

select 
  c.name as developer,
  p.name as platform,
  t.sales as sales
from (
  select 
    *,
    rank() over(partition by developer_id order by sales desc) as rn
  from top_platform
) as t 
inner join platforms as p on t.platform_id = p.platform_id
inner join companies as c on t.developer_id = c.company_id
where t.rn = 1;