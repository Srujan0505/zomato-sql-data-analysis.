-- =====================================================
-- ZOMATO RESTAURANT DATA ANALYSIS
-- SQL Portfolio Project
-- =====================================================

USE zomato_project;


-- =====================================================
-- 1. DATA OVERVIEW
-- =====================================================

SELECT COUNT(*) AS total_records
FROM zomato;


-- =====================================================
-- 2. RESTAURANTS BY CITY
-- =====================================================

SELECT
    City,
    COUNT(*) AS restaurant_count
FROM zomato
GROUP BY City
ORDER BY restaurant_count DESC
LIMIT 10;


-- =====================================================
-- 3. POPULAR CUISINES
-- =====================================================

SELECT
    Cuisines,
    COUNT(*) AS restaurant_count
FROM zomato
WHERE Cuisines IS NOT NULL
GROUP BY Cuisines
ORDER BY restaurant_count DESC
LIMIT 10;


-- =====================================================
-- 4. RATING ANALYSIS
-- =====================================================

SELECT
    `Rating text`,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(`Aggregate rating`), 2) AS average_rating
FROM zomato
GROUP BY `Rating text`
ORDER BY restaurant_count DESC;


-- =====================================================
-- 5. ONLINE DELIVERY ANALYSIS
-- =====================================================

SELECT
    `Has Online delivery`,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(`Aggregate rating`), 2) AS average_rating,
    ROUND(AVG(Votes), 0) AS average_votes
FROM zomato
WHERE `Aggregate rating` > 0
GROUP BY `Has Online delivery`;


-- =====================================================
-- 6. TABLE BOOKING ANALYSIS
-- =====================================================

SELECT
    `Has Table booking`,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(`Aggregate rating`), 2) AS average_rating
FROM zomato
WHERE `Aggregate rating` > 0
GROUP BY `Has Table booking`;


-- =====================================================
-- 7. PRICE VS RATING
-- =====================================================

SELECT
    CASE
        WHEN `Average Cost for two` < 300 THEN 'Budget'
        WHEN `Average Cost for two` BETWEEN 300 AND 700 THEN 'Mid-Range'
        WHEN `Average Cost for two` BETWEEN 701 AND 1500 THEN 'Premium'
        ELSE 'Fine Dining'
    END AS price_category,
    COUNT(*) AS restaurant_count,
    ROUND(AVG(`Aggregate rating`), 2) AS average_rating
FROM zomato
GROUP BY price_category
ORDER BY average_rating DESC;


-- =====================================================
-- 8. BEST VALUE RESTAURANTS
-- =====================================================

SELECT
    `Restaurant Name`,
    City,
    Cuisines,
    `Average Cost for two`,
    `Aggregate rating`,
    Votes
FROM zomato
WHERE `Aggregate rating` >= 4.0
  AND `Average Cost for two` <= 500
  AND Votes >= 100
ORDER BY `Aggregate rating` DESC, Votes DESC
LIMIT 20;