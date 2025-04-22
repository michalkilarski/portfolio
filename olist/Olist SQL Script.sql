-- DATA EVALUATION
-- CUSTOMERS TABLE
-- Counting rows
select count(*)
from customers

-- Finding duplicates
select *, count(*)
from customers c 
group by customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state 
having count(*) > 1

-- Finding missing values
select
	sum(case when customer_id = '' then 1 else 0 end) as missing_customer_id,
	sum(case when customer_unique_id = '' then 1 else 0 end) as missing_customer_unique_id,
	sum(case when customer_zip_code_prefix is null then 1 else 0 end) as missing_customer_zip_code_prefix,
	sum(case when customer_city = '' then 1 else 0 end) as missing_customer_city,
	sum(case when customer_state = '' then 1 else 0 end) as missing_customer_state
from customers c 

-- GEOLOCATION TABLE
-- Counting rows
select count(*)
from geolocation g 

-- Finding duplicates
select *, count(*)
from geolocation g 
group by g.geolocation_zip_code_prefix, g.geolocation_lat, g.geolocation_lng, g.geolocation_city, g.geolocation_state
having count(*) > 1 

-- Finding missing values
select
	sum(case when g.geolocation_zip_code_prefix is null then 1 else 0 end) as missing_zip_code,
	sum(case when geolocation_lat is null then 1 else 0 end) as missing_lat,
	sum(case when g.geolocation_lng is null then 1 else 0 end) as missing_lng,
	sum(case when geolocation_city = '' then 1 else 0 end) as missing_city,
	sum(case when geolocation_state = '' then 1 else 0 end) as missing_state
from geolocation g 

-- ITEMS TABLE
-- Counting rows
select count(*)
from items i 

-- Finding duplicates
select *, count(*)
from items
group by order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value
having count(*) > 1

-- Finding missing values
select 
	sum(case when order_id = '' then 1 else 0 end) as missing_order,
	sum(case when order_item_id is null then 1 else 0 end) as missing_order_item,
	sum(case when product_id = '' then 1 else 0 end) as missing_product,
	sum(case when seller_id = '' then 1 else 0 end) as missing_seller,
	sum(case when shipping_limit_date = '' then 1 else 0 end) as missing_limit_date,
	sum(case when price is null then 1 else 0 end) as missing_price,
	sum(case when freight_value is null then 1 else 0 end) as missing_freight
from items

-- Checking for negative prices
select *
from items
where price < 0 or freight_value < 0;

-- ORDER PAYMENTS TABLE
-- Counting rows
select count(*)
from order_payments op 

-- Finding duplicates
select *, count(*)
from order_payments op 
group by 1,2,3,4,5
having count(*) > 1

-- Finding missing values
select 
	sum(case when order_id = '' then 1 else 0 end) as missing_order,
	sum(case when payment_sequential is null then 1 else 0 end) as missing_sequential,
	sum(case when payment_type = '' then 1 else 0 end) as missing_type,
	sum(case when payment_value is null then 1 else 0 end) as missing_value,
	sum(case when payment_installments is null then 1 else 0 end) as missing_installments
from order_payments op 

-- ORDERS TABLE
-- Counting rows
select count(*)
from orders

-- Finding duplicates
select *, count(*)
from orders
group by 1,2,3,4,5,6,7,8
having count(*) > 1

-- Finding missing values
select 
	sum(case when order_id = '' then 1 else 0 end) as missing_order,
	sum(case when customer_id = '' then 1 else 0 end) as missing_customer,
	sum(case when order_status = '' then 1 else 0 end) as missing_status,
	sum(case when order_purchase_timestamp = '' then 1 else 0 end) as missing_timestamp,
	sum(case when order_approved_at = '' then 1 else 0 end) as missing_approved_at,
	sum(case when order_delivered_carrier_date = '' then 1 else 0 end) as missing_carrier_date,
	sum(case when order_delivered_customer_date = '' then 1 else 0 end) as missing_customer_date,
	sum(case when order_estimated_delivery_date = '' then 1 else 0 end) as missing_delivery_date
from orders

-- PRODUCT CATEGORY NAME TABLE
-- Counting rows
select count(*)
from product_category_name pcn 

-- Finding duplicates
select *, count(*)
from product_category_name pcn 
group by 1,2
having count(*) > 1

-- Finding missing values
select
	sum(case when product_category_name = '' then 1 else 0 end) as mmissing_name,
	sum(case when product_category_name_english = '' then 1 else 0 end) as missing_name_english
from product_category_name pcn 

-- PRODUCTS TABLE'
-- Counting rows
select count(*)
from products

-- Finding duplicates
select *, count(*)
from products
group by 1,2,3,4,5,6,7,8,9
having count(*) > 1

-- Finding missing values
select 
	sum(case when product_id = '' then 1 else 0 end) as missing_id,
	sum(case when product_category_name = '' then 1 else 0 end) as missing_category,
	sum(case when product_name_lenght is null then 1 else 0 end) as missing_name_length,
	sum(case when product_description_lenght is null then 1 else 0 end) as missing_description_length,
	sum(case when product_photos_qty is null then 1 else 0 end) as missing_photos_qty,
	sum(case when product_weight_g is null then 1 else 0 end) as missing_weight,
	sum(case when product_length_cm is null then 1 else 0 end) as missing_length,
	sum(case when product_height_cm is null then 1 else 0 end) as missing_height,
	sum(case when product_width_cm is null then 1 else 0 end) as missing_width
from products;

-- SELLERS TABLE
-- Counting rows
select count(*)
from sellers

-- Finding duplicates
select *, count(*)
from sellers
group by 1,2,3,4
having count(*) > 1

-- Finding missing values
select
	sum(case when seller_id = '' then 1 else 0 end) as missing_id,
	sum(case when seller_zip_code_prefix is null then 1 else 0 end) as missing_zipcode,
	sum(case when seller_city = '' then 1 else 0 end) as missing_city,
	sum(case when seller_state = '' then 1 else 0 end) as missing_state
from sellers;

-- SUMMARY

with summary as
(select 
	c.customer_unique_id,
	o.order_id,
	i.product_id,
	i.price,
	s.seller_id
from customers c 
join orders o
on c.customer_id = o.customer_id
join items i 
on o.order_id = i.order_id
join sellers s 
on i.seller_id = s.seller_id)
select
	count(distinct customer_unique_id) customers_count,
	count(distinct order_id) order_count,
	count(distinct product_id) product_count,
	count(distinct seller_id) sellers_count,
	sum(price) total_sales
from summary
order by 1, 2, 3, 4

--ANALYSIS 1: SALES PER CATEGORY

select 
	initcap(replace(coalesce(product_category_name_english, 'Unknown'), '_', ' ')) as product_category, 
	sum(price) as total_sales
from orders o
join items i
on o.order_id = i.order_id
join products p
on i.product_id = p.product_id
left join product_category_name pcn 
on p.product_category_name = pcn.product_category_name
where order_status = 'delivered'
group by 1
order by 2 desc

-- ANALYSIS 2: SALES PER REGION

with unique_geolocation as 
	(select distinct on (geolocation_zip_code_prefix)
	geolocation_zip_code_prefix,
	geolocation_lat,
	geolocation_lng
	from geolocation
	where geolocation_lat <= 5.27438888 or geolocation_lat >= -33.75116944 or geolocation_lng >= -73.98283055 or geolocation_lng <= -34.79314722)
select 
	initcap(c.customer_city) as customer_city, 
	c.customer_state, 
	state_name,
	population as state_population,
	lpad(c.customer_zip_code_prefix::text, 5, '0') as zip_code_prefix,
	'Brazil' as country,
	ug.geolocation_lat, 
	ug.geolocation_lng, 
	concat(ug.geolocation_lat, ', ', ug.geolocation_lng) as lat_lng,
	concat(initcap(c.customer_city), ', ', c.customer_state, ', Brazil') as city_state_country,
	sum(price) as total_sales
from items i
join orders o
on i.order_id = o.order_id
join customers c
on o.customer_id = c.customer_id
join unique_geolocation ug
on c.customer_zip_code_prefix = ug.geolocation_zip_code_prefix
join brazilian_states bs
on bs.state_code = c.customer_state
where order_status = 'delivered'
group by 1,2,3,4,5,6,7,8,9,10
order by total_sales desc;

-- ANALYSIS 3: SELLER PERFORMANCE AND RELIABILITY

with seller_analysis as
	(select
		o.order_id,
		i.seller_id,
		price,
		to_date(left(o.order_purchase_timestamp, 10), 'YYYY-MM-DD') as purchase_date,
		case
			when o.order_delivered_carrier_date is null or o.order_delivered_carrier_date = '' then null 
			else to_date(left(o.order_delivered_carrier_date, 10), 'YYYY-MM-DD')
		end as handled_date,
		to_date(left(i.shipping_limit_date, 10), 'YYYY-MM-DD') as limit_date
	from orders o
	join items i 
	on o.order_id = i.order_id),
efficiency_analysis as
	(select
		seller_id,
		price,
		purchase_date,
		handled_date,
		limit_date,
		(limit_date - purchase_date) as est_handle_days,
		(limit_date - handled_date) as days_deviation,
		(cast((handled_date - purchase_date) as float) / nullif(cast((limit_date - purchase_date) as float), 0)) as time_ratio
	from seller_analysis 
	where handled_date is not null and handled_date > purchase_date and (limit_date - purchase_date) < 100),
seller_scores as
	(select
		seller_id,
		avg(time_ratio) as avg_time_ratio,
		avg(price) as aov
	from efficiency_analysis
	group by seller_id),
aov_median as
(select
	percentile_cont(0.5) within group (order by aov) median_aov
from seller_scores)
select
	seller_id,
	avg_time_ratio,
	aov,
	case
		when avg_time_ratio <= 0.25 then 'Exceptional'
		when avg_time_ratio <= 0.75 then 'Reliable'
		when avg_time_ratio <= 1 then 'On Time'
		when avg_time_ratio <= 1.2 then 'Slightly late'
		else 'Frequently late'
	end as efficiency_category,
	case
		when aov >= median_aov then 'High AOV'
		else 'Low AOV'
	end as aov_group,
	case
		when avg_time_ratio <= 1 and aov >= median_aov then 'Efficient + High Revenue Sellers'
		when avg_time_ratio > 1 and aov >= median_aov then 'Valuable but Late Sellers'
		when avg_time_ratio <= 1 and aov <= median_aov then 'Fast + Low Revenue'
		else 'Underperformers'
	end as performance_category
from seller_scores
cross join aov_median
order by avg_time_ratio

-- Counts
with seller_analysis as
	(select
		o.order_id,
		i.seller_id,
		price,
		to_date(left(o.order_purchase_timestamp, 10), 'YYYY-MM-DD') as purchase_date,
		case
			when o.order_delivered_carrier_date is null or o.order_delivered_carrier_date = '' then null 
			else to_date(left(o.order_delivered_carrier_date, 10), 'YYYY-MM-DD')
		end as handled_date,
		to_date(left(i.shipping_limit_date, 10), 'YYYY-MM-DD') as limit_date
	from orders o
	join items i 
	on o.order_id = i.order_id),
efficiency_analysis as
	(select
		seller_id,
		price,
		purchase_date,
		handled_date,
		limit_date,
		(limit_date - purchase_date) as est_handle_days,
		(limit_date - handled_date) as days_deviation,
		(cast((handled_date - purchase_date) as float) / nullif(cast((limit_date - purchase_date) as float), 0)) as time_ratio
	from seller_analysis 
	where handled_date is not null and handled_date > purchase_date and (limit_date - purchase_date) < 100),
seller_scores as
	(select
		seller_id,
		avg(time_ratio) as avg_time_ratio,
		avg(price) as aov
	from efficiency_analysis
	group by seller_id),
aov_median as
(select
	percentile_cont(0.5) within group (order by aov) median_aov
from seller_scores),
sub as
	(select
		seller_id,
		avg_time_ratio,
		aov,
		case
			when avg_time_ratio <= 0.25 then 'Exceptional'
			when avg_time_ratio <= 0.75 then 'Reliable'
			when avg_time_ratio <= 1 then 'On Time'
			when avg_time_ratio <= 1.2 then 'Slightly late'
			else 'Frequently late'
		end as efficiency_category,
		case
			when aov >= median_aov then 'High AOV'
			else 'Low AOV'
		end as aov_group,
		case
			when avg_time_ratio <= 1 and aov >= median_aov then 'Efficient + High Revenue Sellers'
			when avg_time_ratio > 1 and aov >= median_aov then 'Valuable but Late Sellers'
			when avg_time_ratio <= 1 and aov <= median_aov then 'Fast + Low Revenue'
			else 'Underperformers'
		end as performance_category
	from seller_scores
	cross join aov_median)
select 
	performance_category,
	count(*)
from sub
group by performance_category 

-- ANALYSIS 4: LATE DELIVERIES PER CATEGORY

with product_delivery_times as
	(select 
		initcap(replace(coalesce(product_category_name_english, 'Unknown'), '_', ' ')) as product_category,
		case 
			when order_delivered_customer_date is null or order_delivered_customer_date = '' then null
			else to_date(left(order_delivered_customer_date, 10), 'YYYY-MM-DD')
		end as delivered_date,
		case 
			when order_estimated_delivery_date is null or order_estimated_delivery_date = '' then null
			else to_date(left(order_estimated_delivery_date, 10), 'YYYY-MM-DD')
		end as estimated_delivery_date
	from orders o
	join items i 
	on o.order_id = i.order_id
	join products p 
	on i.product_id = p.product_id
	join product_category_name pcn 
	on p.product_category_name = pcn.product_category_name
	where o.order_status = 'delivered'),
deviation as
	(select 
		product_category,
		(delivered_date - estimated_delivery_date) as delivery_days_deviation
	from product_delivery_times pdt
	where delivered_date is not null and estimated_delivery_date is not null),
metrics as
	(select
		product_category,
		count(*) as total_orders,
		count(case when delivery_days_deviation > 0 then 1 end) as late_orders,
		avg(delivery_days_deviation) as avg_deviation_all,
	    stddev(delivery_days_deviation) as stddev_deviation,
	    avg(case when delivery_days_deviation > 0 then delivery_days_deviation end) as avg_delay_when_late
	from deviation
	group by product_category)
select
	product_category,
	late_orders,
	cast((late_orders) as float) / nullif(cast((total_orders) as float), 0) as percent_late_orders,
  	round(avg_deviation_all, 2) as avg_deviation_all_orders,
  	round(coalesce(avg_delay_when_late, 0), 2) as avg_delay_when_late_orders,
  	round(stddev_deviation, 2) as std_deviation
from metrics
order by percent_late_orders desc;

-- ANALYSIS 5: PAYMENT METHODS VS ORDER VALUE AND FREQUENCY

with transformed_payments as
	(select 
		case 
			when payment_type like '%card' then 'Card payments'
			when payment_type = 'boleto' then 'Ticket'
			else initcap(replace(payment_type, '_', ' '))
		end as payment_type,
		op.order_id,
		op.payment_value
	from order_payments op
	join orders o
	on op.order_id = o.order_id
	where payment_type != 'not_defined')
select
	payment_type,
	count(distinct order_id) as total_orders, 
	count(order_id) as total_payments,
	avg(payment_value) as avg_order_value,
	count(order_id) / sum(count(order_id)) over() as percentage_of_payments
from transformed_payments
group by payment_type 
order by avg_order_value desc;

-- ANALYSIS 6: CUSTOMER SEGMENTATION
with reference_date as 
	(select max(to_date(left(order_purchase_timestamp, 10), 'YYYY-MM-DD')) as max_order_date
	from orders),
customer_spending as
	(select 
		customer_unique_id,
		max(to_date(left(order_purchase_timestamp, 10), 'YYYY-MM-DD')) as last_purchase_date,
		count(distinct o.order_id) as order_count,
		sum(price) as total_spent
	from customers c
	join orders o
	on c.customer_id = o.customer_id
	join items i
	on o.order_id = i.order_id
	where order_status = 'delivered'
	group by customer_unique_id),
rfm_scores as
	(select
		customer_unique_id,
		(max_order_date - last_purchase_date) as recency_days,
		order_count,
		total_spent,
		ntile(4) over (order by (max_order_date - last_purchase_date) asc) as recency_score,
		ntile(4) over (order by order_count desc) as frequency_score,
		ntile(4) over (order by total_spent desc) as monetary_score
	from customer_spending cr
	cross join reference_date r),
segmentation as 
	(select 
		customer_unique_id,
		recency_score,
		frequency_score,
		monetary_score,
		case 
			when recency_score = 1 and frequency_score = 1 and monetary_score in (1, 2) then 'Best Customers'
			when recency_score <= 2 and frequency_score <= 2 and monetary_score <= 3 and not (recency_score = 1 and frequency_score = 1 and monetary_score in (1, 2)) then 'Loyal Customers'
			when recency_score <= 2 and frequency_score in (2, 3) and monetary_score in (1, 2) and not (recency_score <= 2 and frequency_score <= 2 and monetary_score <= 3) then 'Potential Loyalists'
			when recency_score = 1 and frequency_score in (3,4) then 'New Customers'
			when recency_score = 3 and frequency_score in (1,2) and monetary_score <= 3 then 'At Risk'
			when recency_score = 4 and frequency_score in (1,2) and monetary_score <=3 then 'Can''t Lose Them' --check
			when (recency_score in (2, 3) and frequency_score in (2, 3) and monetary_score in (2, 3)) or
	         (recency_score = 2 and frequency_score = 1 and monetary_score = 4) or
	         (recency_score = 2 and frequency_score = 2 and monetary_score = 4) or
	         (recency_score = 3 and frequency_score = 2 and monetary_score = 4)
	        then 'Need Attention'
			when (recency_score in (3, 4) and frequency_score in (3, 4) and monetary_score in (3, 4)) or
	         (recency_score = 2 and frequency_score in (3, 4) and monetary_score in (3, 4)) or
	         (recency_score = 4 and frequency_score = 2 and monetary_score = 4)
	        then 'Hibernating'
			when recency_score in (2,3,4) and frequency_score = 4 and monetary_score = 1 then 'One-Time High Value'
			else 'Need Attention'
		end as customer_segment
	from rfm_scores)
select 
	customer_segment,
	count(*)
from segmentation
group by customer_segment

-- ANALYSIS 7: SALES OVER TIME
select
	to_date(left(order_approved_at, 10), 'YYYY-MM-DD') as order_date,
	sum(price) as revenue
from items i
join orders o
on i.order_id = o.order_id
where o.order_status = 'delivered' and order_approved_at != ''
group by order_approved_at
order by order_approved_at

-- ANALYSIS 8: SALES VS DELIVERIES
with orders_deliveries as
(select
	o.order_id,
	to_date(left(o.order_delivered_carrier_date, 10), 'YYYY-MM-DD') as delivery_start,
	to_date(left(o.order_delivered_customer_date, 10), 'YYYY-MM-DD') as delivery_end
from orders o
where o.order_delivered_carrier_date != '' and o.order_delivered_customer_date != ''),
deliveries_days as
(select
	order_id,
	(delivery_end - delivery_start) as delivery_days
from orders_deliveries
where (delivery_end - delivery_start) > 0),
unique_geolocation as 
	(select distinct on (geolocation_zip_code_prefix)
	geolocation_zip_code_prefix,
	geolocation_lat,
	geolocation_lng
	from geolocation
	where geolocation_lat between -33.75116944 and 5.27438888 and geolocation_lng between -73.98283055 and -34.79314722),
sales_by_location as (
    select 
        concat(ug.geolocation_lat, ', ', ug.geolocation_lng) as lat_lng,
        sum(i.price) as total_sales,
        avg(dd.delivery_days) as avg_delivery_days
    from items i
    join orders o on i.order_id = o.order_id
    join customers c on o.customer_id = c.customer_id
    join unique_geolocation ug on c.customer_zip_code_prefix = ug.geolocation_zip_code_prefix
    join deliveries_days dd on dd.order_id = o.order_id
    where o.order_status = 'delivered'
    group by lat_lng),
cut_off as
(select
	percentile_cont(0.75) within group (order by total_sales) as cutoff_total_sales,
    percentile_cont(0.75) within group (order by avg_delivery_days) as cutoff_delivery_days
from sales_by_location)
select 
	lat_lng,
	total_sales,
	avg_delivery_days,
	(total_sales * avg_delivery_days) as impact_score,
	case
		when total_sales >= cutoff_total_sales and avg_delivery_days <= cutoff_delivery_days then 'High Sales / Short Delivery'
		when total_sales >= cutoff_total_sales and avg_delivery_days > cutoff_delivery_days then 'High Sales / Long Delivery'
		when total_sales < cutoff_total_sales and avg_delivery_days <= cutoff_delivery_days then 'Low Sales / Short Delivery'
		when total_sales < cutoff_total_sales and avg_delivery_days > cutoff_delivery_days then 'Low Sales / Long Delivery'
	end category
from sales_by_location
cross join cut_off
order by avg_delivery_days desc;
