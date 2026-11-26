# Write your MySQL query statement below
WITH UserEvents AS (
    SELECT 
        user_id,
        event_date,
        event_type,
        plan_name,
        monthly_amount,
        -- Rank events chronologically (using event_id as a tie-breaker for same-day events)
        ROW_NUMBER() OVER (
            PARTITION BY user_id 
            ORDER BY event_date DESC, event_id DESC
        ) AS rn,
        -- Track highest historical amount per user
        MAX(monthly_amount) OVER (
            PARTITION BY user_id
        ) AS max_historical_amount,
        -- Count total downgrades per user
        SUM(CASE WHEN event_type = 'downgrade' THEN 1 ELSE 0 END) OVER (
            PARTITION BY user_id
        ) AS downgrade_count,
        -- Calculate total days between first and last event
        DATEDIFF(
            MAX(event_date) OVER (PARTITION BY user_id),
            MIN(event_date) OVER (PARTITION BY user_id)
        ) AS days_as_subscriber
    FROM subscription_events
)
SELECT 
    user_id,
    plan_name AS current_plan,
    monthly_amount AS current_monthly_amount,
    max_historical_amount,
    days_as_subscriber
FROM UserEvents
WHERE 
    rn = 1                                              -- Filter to the user's latest event
    AND event_type != 'cancel'                          -- 1. Currently active subscription
    AND downgrade_count >= 1                            -- 2. At least one downgrade in history
    AND monthly_amount < (max_historical_amount * 0.5)  -- 3. Current revenue < 50% of max
    AND days_as_subscriber >= 60                        -- 4. Subscribed for at least 60 days
ORDER BY 
    days_as_subscriber DESC, 
    user_id ASC;