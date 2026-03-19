/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?
-- 2. How many days has each customer visited the restaurant?
-- 3. What was the first item from the menu purchased by each customer?
-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
-- 5. Which item was the most popular for each customer?
-- 6. Which item was purchased first by the customer after they became a member?
-- 7. Which item was purchased just before the customer became a member?
-- 8. What is the total items and amount spent for each member before they became a member?
-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

                                             --  SOLUTIONS and ALTERNATIVE QUESTIONS
                                                  
-- =========================================
-- Q1. Total amount spent per customer
-- =========================================
SELECT 
    s.customer_id, 
    SUM(m.price) AS total_spent
FROM sales s
JOIN menu m
    USING (product_id)
GROUP BY s.customer_id;


-- Alternative: Spend per customer per product
SELECT 
    s.customer_id, 
    s.product_id, 
    SUM(m.price) AS total_spent
FROM sales s
JOIN menu m
    USING (product_id)
GROUP BY s.customer_id, s.product_id
ORDER BY s.customer_id;

-- =========================================
-- Q2. How many days has each customer visited the restaurant?
-- =========================================
SELECT 
    customer_id, 
    COUNT(DISTINCT order_date) AS visit_days
FROM sales
GROUP BY customer_id;

-- Alternative: How many days did customers order sushi?
SELECT 
    s.customer_id, 
    COUNT(DISTINCT s.order_date) AS sushi_days
FROM sales s
JOIN menu m
    USING (product_id)
WHERE m.product_name = 'sushi'
GROUP BY s.customer_id;

-- Alternative: Data quality check - sales with missing menu mapping
SELECT *
FROM sales s
LEFT JOIN menu m
    USING (product_id)
WHERE m.product_id IS NULL;

-- =========================================
-- Q3. What was the first item from the menu purchased by each customer?
-- =========================================

