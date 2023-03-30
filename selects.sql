SELECT COUNT(*)
    FROM customers
    WHERE active_customer = true LIMIT 20;

SELECT AVG(subscription_price) as avg_subs_prices
    FROM subscription_history 
    LIMIT 20;

SELECT MIN(subscription_price) as min_subs_prices,
    subscription_date, 
    subscription_expiration 
    FROM subscription_history 
    GROUP BY subscription_date, 
    subscription_expiration 
    LIMIT 20; 

SELECT name, 
    UPPER(sex) AS sex, 
    dob, 
    address 
    FROM users
    LIMIT 20;

SELECT REPLACE(LOWER(name), ' ', '-') AS slug_service, 
    name,
    description 
    FROM services LIMIT 20;