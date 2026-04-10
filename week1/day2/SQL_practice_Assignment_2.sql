-- Table Script: CustomerUsage
CREATE TABLE CustomerUsage (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
plan_type VARCHAR(20),
data_used_gb INT,
call_minutes INT,
monthly_bill DECIMAL(10,2)
);

-- Insert Statements:
INSERT INTO CustomerUsage VALUES
(1, 'Veena', 'Postpaid', 9, 471, 842.03),
(2, 'Veer', 'Postpaid', 7, 354, 434.94),
(3, 'Mohan', 'Prepaid', 33, 497, 569.23),
(4, 'Pratik', 'Prepaid', 15, 113, 1107.48),
(5, 'Farhan', 'Prepaid', 14, 1284, 845.75),
(6, 'Jiya', 'Postpaid', 28, 1578, 1325.15);

--- CASE WHEN Questions Medium Level

-- Question 1: Evaluate potential for plan upgrade:
-- If plan_type = 'Prepaid':
-- If monthly_bill > 400 OR call_minutes > 550 → 'Suggest Postpaid Upgrade'
-- Else → 'No Upgrade'
-- If plan_type = 'Postpaid':
-- If data_used_gb > 25 → 'Suggest Premium Plan'
-- Else → 'Satisfactory Usage'

SELECT *,
       CASE
           WHEN plan_type = 'Prepaid' THEN
               CASE
                   WHEN monthly_bill > 400 OR call_minutes > 550 THEN 'Suggest Postpaid Upgrade'
                   ELSE 'No Upgrade'
               END
           WHEN plan_type = 'Postpaid' THEN
               CASE
                   WHEN data_used_gb > 25 THEN 'Suggest Premium Plan'
                   ELSE 'Satisfactory Usage'
               END
       END AS upgrade_suggestion
FROM CustomerUsage;

-- Question 2: Classify customers based on data usage and plan type:
-- If plan_type = 'Postpaid':
-- If data_used_gb >= 30 → 'Heavy User - Postpaid'
-- Else If data_used_gb BETWEEN 15 AND 29 → 'Moderate User - Postpaid'
-- Else → 'Light User - Postpaid'
-- If plan_type = 'Prepaid':
-- If data_used_gb >= 20 → 'Heavy User - Prepaid'
-- Else → 'Light User - Prepaid'

SELECT *,
       CASE
           WHEN plan_type = 'Postpaid' THEN
               CASE
                   WHEN data_used_gb >= 30 THEN 'Heavy User - Postpaid'
                   WHEN data_used_gb BETWEEN 15 AND 29 THEN 'Moderate User - Postpaid'
                   ELSE 'Light User - Postpaid'
               END
           WHEN plan_type = 'Prepaid' THEN
               CASE
                   WHEN data_used_gb >= 20 THEN 'Heavy User - Prepaid'
                   ELSE 'Light User - Prepaid'
               END
       END AS usage_category
FROM CustomerUsage;

-- Question 3: Assess voice usage pattern:
-- If call_minutes > 1200:
-- If monthly_bill > 1000 → 'Excessive Talker - Premium'
-- Else → 'Excessive Talker - Standard'
-- Else If call_minutes BETWEEN 800 AND 1200 → 'Frequent Caller'
-- Else → 'Normal Caller'

SELECT *,
       CASE
           WHEN call_minutes > 1200 THEN
               CASE
                   WHEN monthly_bill > 1000 THEN 'Excessive Talker - Premium'
                   ELSE 'Excessive Talker - Standard'
               END
           WHEN call_minutes BETWEEN 800 AND 1200 THEN 'Frequent Caller'
           ELSE 'Normal Caller'
       END AS voice_pattern
FROM CustomerUsage;

-- Question 4: Determine offer eligibility:
-- If plan_type = 'Postpaid' AND data_used_gb > 25 AND call_minutes > 1000 → 'Combo Offer'
-- If plan_type = 'Prepaid' AND monthly_bill > 600 → 'Recharge Cashback Offer'
-- Else → 'No Offer'

SELECT *,
       CASE
           WHEN plan_type = 'Postpaid' AND data_used_gb > 25 AND call_minutes > 1000 THEN 'Combo Offer'
           WHEN plan_type = 'Prepaid' AND monthly_bill > 600 THEN 'Recharge Cashback Offer'
           ELSE 'No Offer'
       END AS offer_eligibility
FROM CustomerUsage;

-- Question 5: Reward program allocation:
-- If data_used_gb > 25:
-- If call_minutes > 1000 → 'Gold Tier'
-- Else → 'Silver Tier'
-- Else:
-- If call_minutes > 800 → 'Bronze Tier'
-- Else → 'Basic Tier'

SELECT *,
       CASE
           WHEN data_used_gb > 25 THEN
               CASE
                   WHEN call_minutes > 1000 THEN 'Gold Tier'
                   ELSE 'Silver Tier'
               END
           ELSE
               CASE
                   WHEN call_minutes > 800 THEN 'Bronze Tier'
                   ELSE 'Basic Tier'
               END
       END AS reward_tier
FROM CustomerUsage;

-- Question 6: Detect mismatched usage patterns:
-- If plan_type = 'Postpaid' AND monthly_bill < 500 → 'Underutilized Postpaid'
-- If plan_type = 'Prepaid' AND monthly_bill > 900 → 'Overpaying Prepaid'
-- Else → 'Plan Matches Usage'

SELECT *,
       CASE
           WHEN plan_type = 'Postpaid' AND monthly_bill < 500 THEN 'Underutilized Postpaid'
           WHEN plan_type = 'Prepaid' AND monthly_bill > 900 THEN 'Overpaying Prepaid'
           ELSE 'Plan Matches Usage'
       END AS usage_flag
FROM CustomerUsage;

-- Question 7: Identify heavy all-round users:
-- If data_used_gb > 25 AND call_minutes > 1000:
-- If monthly_bill > 1200 → 'Super User'
-- Else → 'High Usage Customer'
-- Else → 'Standard User'

SELECT *,
       CASE
           WHEN data_used_gb > 25 AND call_minutes > 1000 THEN
               CASE
                   WHEN monthly_bill > 1200 THEN 'Super User'
                   ELSE 'High Usage Customer'
               END
           ELSE 'Standard User'
       END AS user_type
FROM CustomerUsage;

-- Question 8: Voice vs Data Preference:
-- If call_minutes > data_used_gb * 30 → 'Voice Oriented User'
-- If data_used_gb > call_minutes / 30 → 'Data Oriented User'
-- Else → 'Balanced Usage'

SELECT *,
       CASE
           WHEN call_minutes > data_used_gb * 30 THEN 'Voice Oriented User'
           WHEN data_used_gb > call_minutes / 30 THEN 'Data Oriented User'
           ELSE 'Balanced Usage'
       END AS preference
FROM CustomerUsage;

-- Question 9: Suggest billing discounts:
-- If monthly_bill > 1000:
-- If plan_type = 'Prepaid' → 'Offer Switch + Discount'
-- If plan_type = 'Postpaid' → 'Offer Loyalty Discount'
-- Else → 'No Discount'

SELECT *,
       CASE
           WHEN monthly_bill > 1000 THEN
               CASE
                   WHEN plan_type = 'Prepaid' THEN 'Offer Switch + Discount'
                   WHEN plan_type = 'Postpaid' THEN 'Offer Loyalty Discount'
               END
           ELSE 'No Discount'
       END AS discount_offer
FROM CustomerUsage;

-- Question 10: Assign digital engagement tag:
-- If data_used_gb > 25:
-- If monthly_bill < 700 → 'High Efficiency User'
-- Else → 'Premium Digital User'
-- Else → 'Standard Engagement'

SELECT *,
       CASE
           WHEN data_used_gb > 25 THEN
               CASE
                   WHEN monthly_bill < 700 THEN 'High Efficiency User'
                   ELSE 'Premium Digital User'
               END
           ELSE 'Standard Engagement'
       END AS engagement_tag
FROM CustomerUsage;

-- Question 11: If call_minutes > 1500 AND data_used_gb < 10 → 'Heavy Voice, Low Data' If data_used_gb > 25 AND call_minutes < 500 → 'Heavy Data, Light Talk' Else → 'Balanced or Low Usage'

SELECT *,
       CASE
           WHEN call_minutes > 1500 AND data_used_gb < 10 THEN 'Heavy Voice, Low Data'
           WHEN data_used_gb > 25 AND call_minutes < 500 THEN 'Heavy Data, Light Talk'
           ELSE 'Balanced or Low Usage'
       END AS usage_pattern
FROM CustomerUsage;

-- Question 12: If plan_type = 'Postpaid' AND monthly_bill > 800:
-- If call_minutes > 1200 → 'Elite Postpaid User'
-- Else → 'Premium Postpaid User'
-- If plan_type = 'Prepaid' → 'Prepaid User'

SELECT *,
       CASE
           WHEN plan_type = 'Postpaid' AND monthly_bill > 800 THEN
               CASE
                   WHEN call_minutes > 1200 THEN 'Elite Postpaid User'
                   ELSE 'Premium Postpaid User'
               END
           WHEN plan_type = 'Prepaid' THEN 'Prepaid User'
       END AS user_category
FROM CustomerUsage;

-- Question 13: If data_used_gb > 20 AND monthly_bill BETWEEN 800 AND 1000 → 'Gold Data Pack Suggested' Else If data_used_gb > 30 → 'Platinum Data Pack Suggested' Else → 'Standard Plan'

SELECT *,
       CASE
           WHEN data_used_gb > 20 AND monthly_bill BETWEEN 800 AND 1000 THEN 'Gold Data Pack Suggested'
           WHEN data_used_gb > 30 THEN 'Platinum Data Pack Suggested'
           ELSE 'Standard Plan'
       END AS data_plan
FROM CustomerUsage;

-- Question 14: If call_minutes > 1000:
-- If monthly_bill < 700 → 'Value Talker'
-- Else → 'Premium Talker'
-- Else → 'Normal Caller'

SELECT *,
       CASE
           WHEN call_minutes > 1000 THEN
               CASE
                   WHEN monthly_bill < 700 THEN 'Value Talker'
                   ELSE 'Premium Talker'
               END
           ELSE 'Normal Caller'
       END AS talker_type
FROM CustomerUsage;

-- Question 15: If plan_type = 'Prepaid' AND data_used_gb > 25 → 'Prepaid Power User' If plan_type = 'Postpaid' AND data_used_gb > 25 → 'Postpaid Power User' Else → 'Normal User'

SELECT *,
       CASE
           WHEN plan_type = 'Prepaid' AND data_used_gb > 25 THEN 'Prepaid Power User'
           WHEN plan_type = 'Postpaid' AND data_used_gb > 25 THEN 'Postpaid Power User'
           ELSE 'Normal User'
       END AS power_user_tag
FROM CustomerUsage;