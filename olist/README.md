# Olist Store Sales Analysis (09/2016 – 08/2018)
The following report summarizes sales performance of Olist, Brazilian ecommerce platform. It covers the period of September 2016 – August 2018. The dataset contains real commercial data and is available at [Kaggle]( https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data?select=olist_customers_dataset.csv). 
For more details, see [the interactive dashboard in Looker Studio]( https://lookerstudio.google.com/s/pL6ogt9hjes)

## Key Metrics and Dimensions
- **Sales**: total sales of all products (in Brazilian reals, R$)
- **Purchase date**: day when the order was submitted by a customer
- **Shipping start limit date**: seller’s limit date for handling the order over to the logistic partner
- **Shipping start actual date**: date when a seller actually handled the order over
- **Delivery time ratio**: the ratio between the difference in the shipping start actual date and purchase date, and the shipping start limit date and purchase date. Values between 0 and 1 denote early delivery start, whereas values over 1 denote late delivery start
- **Recency**: number of days since the last purchase (used in RFM analysis)
- **Frequency**: number of orders in the given time period (used in RFM analysis)
- **Monetary**: monetary value of orders (used in RFM analysis)
- **Average delivery deviation**: difference between the estimated and actual delivery date (in days). The more negative the value, the earlier on average the delivery
- **Average delay**: the average delay (in days) for late orders

## Insights
### Sales Overview
- In the course of 2017, Olist experienced a big growth in sales, contributing to the successful emergence of Olist as important ecommerce platform. During the analyzed period, total sales approached 1M R$ in several months
- Key product categories in terms of sales are **health and beauty**, **watches and gifts**, and **bed, bath, table**, all exceeding 1M sales in the analyzed period
- States that bring most sales are located along the most populous southeastern coast, including Sao Paulo, Minas Gerais, Rio Grande do Sul, and Santa Catarina. 

### Sellers
Based on the delivery time ratio and average order value, sellers were categorized into four categories:
- **Efficient + High Revenue**
- **Fast + Low Revenue**
- **Valuable but Late Sellers**
- **Underperformers**
Vast majority of 91.8% of sellers deliver the orders to carriers on time. Among them, efficient sellers with high revenue orders account for 45.6% of all sellers.
Additionally, sellers were categorized based on the delivery time ratio only. 10% of all sellers are **exceptional** with the delivery time ratio below 0.25, meaning that they start shipping significantly prior to shipping limit date. On the other hand, 2.5% and 5.7% of sellers are slightly, and frequently late, respectively.

### Customers
- 75.4% of orders were paid with card payment methods. Tickets (boletos) are also popular, accounting for 19% of all orders.
- Although the popularity of card payments and ticket significantly differ, the average order values for both these payment methods are high (163 R$ for card payments, 145 R$ for tickets)
- Based on the RFM analysis, 9 segments of customers were identified. Most customers belong to the **Need Attention** segment (34.4K customers), as well as to **Hibernating** (15.9K), **Potential Loyalists** (12.1K), and **Loyal Customers** (11.1K) segments. The most important one, **Best Customers** consists of 667 customers.


### Logistics
- The biggest share of late orders belong to categories with small amounts of orders. Among categories with at least 100 late orders, the share of late orders in total orders is the highest for the **office furniture**, **baby**, **electronics**, and **health and beauty** categories.
- Taking into account the average delivery deviation and the standard deviation of this metric, delays occur most often in the **furniture**, **home and comfort**, **food**, and **home appliances** categories.
- The biggest delays occur in the **home appliances** (22 days), **food and drink** (18 days), and **music** (18 days) categories
- Northeastern and southern coast, along with the enclaves in the central/western part of the country, are the regions where customers most often place more expensive orders and need to wait long for delivery at the same time

## Recommendations and Next Steps
### General
- Incentivize sellers to offer more products in the top-selling categories: **health and beauty**, **watches and gifts**, **bed, bath, table**, **sports, leisure**, and **computers, accessories**
- Introduce special discounts in months associated with peak sales, namely in March, May, and November.

### Sellers
- **Exceptional** sellers should be rewarded by being promoted to customers as recommended sellers
- **Valuable but often late** require support or logistic intervention

### Customers
- Since ticket payments are less popular but still account for high-value orders, it is important to maintain the necessary infrastructure to keep this method available
- Follow recommended actions for each customer segment from the dashboard table (available above)

### Logistics
- Consider opening new distribution centers, especially in the regions farther from the most populous regions of Brazil, in order to mitigate late deliveries to high-spending customers. The most concerning is the northeastern coast, however there is also a concentration of high-spending customers who have to wait long in the central and western part of the country.
- Examine the logistic processes in the most concerning categories, especially the **office furniture**, **baby**, **electronics**, and **health and beauty** categories, which have significant shares of late orders. Of these, the **health and beauty** category should be the priority since it generates the most sales.
