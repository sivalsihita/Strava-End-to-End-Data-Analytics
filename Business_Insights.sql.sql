USE strava_analytics;

SELECT
    COUNT(DISTINCT Id) AS unique_users,
    COUNT(*) AS total_activity_records,
    MIN(ActivityDate) AS start_date,
    MAX(ActivityDate) AS end_date,
    ROUND(AVG(TotalSteps), 0) AS avg_daily_steps,
    ROUND(AVG(Calories), 0) AS avg_daily_calories
FROM daily_activity;
-- Result:
-- 33 unique users were analyzed across 940 daily activity records.
-- The observation period spans from 12 April 2016 to 9 May 2016.
-- Average daily steps were 7,638 and average daily calorie
-- expenditure was 2,304 calories.

-- ============================================================
-- BUSINESS INSIGHT 2: USER ACTIVITY SEGMENTATION
-- ============================================================

SELECT
    CASE
        WHEN avg_steps < 5000 THEN 'Low Activity'
        WHEN avg_steps < 10000 THEN 'Moderate Activity'
        ELSE 'High Activity'
    END AS activity_segment,
    COUNT(*) AS user_count,
    ROUND(AVG(avg_steps), 0) AS average_steps
FROM (
    SELECT
        Id,
        AVG(TotalSteps) AS avg_steps
    FROM daily_activity
    GROUP BY Id
) AS user_activity
GROUP BY activity_segment
ORDER BY
    CASE
        WHEN activity_segment = 'Low Activity' THEN 1
        WHEN activity_segment = 'Moderate Activity' THEN 2
        ELSE 3
    END;
    -- Result:
-- 8 users were classified as Low Activity, averaging 2,936 steps/day.
-- 18 users were classified as Moderate Activity, averaging 7,624 steps/day.
-- 7 users were classified as High Activity, averaging 12,488 steps/day.

-- BUSINESS INSIGHT 3: SEDENTARY BEHAVIOUR BY USER SEGMENT
SELECT
    CASE
        WHEN avg_steps < 5000 THEN 'Low Activity'
        WHEN avg_steps < 10000 THEN 'Moderate Activity'
        ELSE 'High Activity'
    END AS activity_segment,
    COUNT(*) AS user_count,
    ROUND(AVG(avg_sedentary_minutes), 0) AS avg_sedentary_minutes
FROM (
    SELECT
        Id,
        AVG(TotalSteps) AS avg_steps,
        AVG(SedentaryMinutes) AS avg_sedentary_minutes
    FROM daily_activity
    GROUP BY Id
) AS user_activity
GROUP BY activity_segment
ORDER BY
    CASE
        WHEN activity_segment = 'Low Activity' THEN 1
        WHEN activity_segment = 'Moderate Activity' THEN 2
        ELSE 3
    END
    -- Result:
-- Low Activity: 8 users, averaging 1,174 sedentary minutes/day.
-- Moderate Activity: 18 users, averaging 931 sedentary minutes/day.
-- High Activity: 7 users, averaging 974 sedentary minutes/day.


-- BUSINESS INSIGHT 4: ACTIVITY LEVEL VS CALORIES BURNED
SELECT
    CASE
        WHEN avg_steps < 5000 THEN 'Low Activity'
        WHEN avg_steps < 10000 THEN 'Moderate Activity'
        ELSE 'High Activity'
    END AS activity_segment,
    COUNT(*) AS user_count,
    ROUND(AVG(avg_steps), 0) AS average_steps,
    ROUND(AVG(avg_calories), 0) AS average_calories
FROM (
    SELECT
        Id,
        AVG(TotalSteps) AS avg_steps,
        AVG(Calories) AS avg_calories
    FROM daily_activity
    GROUP BY Id
) AS user_activity
GROUP BY activity_segment
ORDER BY
    CASE
        WHEN activity_segment = 'Low Activity' THEN 1
        WHEN activity_segment = 'Moderate Activity' THEN 2
        ELSE 3
    END;
    -- Result:
-- Low Activity: 8 users, averaging 2,936 steps and 2,014 calories/day.
-- Moderate Activity: 18 users, averaging 7,624 steps and 2,298 calories/day.
-- High Activity: 7 users, averaging 12,488 steps and 2,549 calories/day.

-- BUSINESS INSIGHT 5: SLEEP DURATION VS PHYSICAL ACTIVITY
USE strava_analytics;

SELECT
    CASE
        WHEN avg_sleep_minutes < 360 THEN 'Less than 6 Hours'
        WHEN avg_sleep_minutes < 480 THEN '6–8 Hours'
        ELSE 'More than 8 Hours'
    END AS sleep_segment,
    
    COUNT(*) AS user_count,
    ROUND(AVG(avg_sleep_minutes), 0) AS average_sleep_minutes,
    ROUND(AVG(avg_steps), 0) AS average_daily_steps

FROM (
    SELECT
        s.Id,
        AVG(s.TotalMinutesAsleep) AS avg_sleep_minutes,
        AVG(a.TotalSteps) AS avg_steps
    FROM sleep_day_clean AS s
    INNER JOIN daily_activity AS a
        ON s.Id = a.Id
    GROUP BY s.Id
) AS user_sleep_activity

GROUP BY sleep_segment

ORDER BY
    CASE
        WHEN sleep_segment = 'Less than 6 Hours' THEN 1
        WHEN sleep_segment = '6–8 Hours' THEN 2
        ELSE 3
    END;
    -- Result:
-- Less than 6 Hours: 8 users, averaging 230 minutes of sleep
-- and 7,693 daily steps.
-- 6–8 Hours: 14 users, averaging 433 minutes of sleep
-- and 7,693 daily steps.
-- More than 8 Hours: 2 users, averaging 579 minutes of sleep
-- and 4,073 daily steps.

-- BUSINESS INSIGHT 6: SLEEP EFFICIENCY ANALYSIS
USE strava_analytics;

SELECT
    CASE
        WHEN sleep_efficiency < 70 THEN 'Low Efficiency'
        WHEN sleep_efficiency < 85 THEN 'Moderate Efficiency'
        ELSE 'High Efficiency'
    END AS sleep_efficiency_segment,
    
    COUNT(*) AS user_count,
    ROUND(AVG(sleep_efficiency), 1) AS average_sleep_efficiency,
    ROUND(AVG(avg_sleep_minutes), 0) AS average_sleep_minutes

FROM (
    SELECT
        Id,
        AVG(TotalMinutesAsleep) AS avg_sleep_minutes,
        AVG(
            (TotalMinutesAsleep / NULLIF(TotalTimeInBed, 0)) * 100
        ) AS sleep_efficiency
    FROM sleep_day_clean
    GROUP BY Id
) AS user_sleep

GROUP BY sleep_efficiency_segment

ORDER BY
    CASE
        WHEN sleep_efficiency_segment = 'Low Efficiency' THEN 1
        WHEN sleep_efficiency_segment = 'Moderate Efficiency' THEN 2
        ELSE 3
    END;
    -- Result:
-- Low Efficiency: 2 users, with an average sleep efficiency of 65.6%
-- and average sleep duration of 473 minutes.
-- High Efficiency: 22 users, with an average sleep efficiency of 93.6%
-- and average sleep duration of 369 minutes.
-- No users were classified into the Moderate Efficiency segment.

-- BUSINESS INSIGHT 7: ACTIVITY COMPONENTS VS CALORIES
USE strava_analytics;

SELECT
    CASE
        WHEN VeryActiveMinutes >= 30 THEN 'High Very-Active'
        WHEN VeryActiveMinutes >= 10 THEN 'Moderate Very-Active'
        ELSE 'Low Very-Active'
    END AS activity_intensity_segment,

    COUNT(*) AS record_count,
    ROUND(AVG(VeryActiveMinutes), 1) AS avg_very_active_minutes,
    ROUND(AVG(FairlyActiveMinutes), 1) AS avg_fairly_active_minutes,
    ROUND(AVG(LightlyActiveMinutes), 1) AS avg_lightly_active_minutes,
    ROUND(AVG(SedentaryMinutes), 1) AS avg_sedentary_minutes,
    ROUND(AVG(Calories), 0) AS avg_calories

FROM daily_activity

GROUP BY activity_intensity_segment

ORDER BY
    CASE
        WHEN activity_intensity_segment = 'Low Very-Active' THEN 1
        WHEN activity_intensity_segment = 'Moderate Very-Active' THEN 2
        ELSE 3
    END;
    -- Result:
-- Low Very-Active: 536 records, averaging 1.0 very-active minute,
-- 1,034.0 sedentary minutes and 2,029 calories/day.
-- Moderate Very-Active: 151 records, averaging 18.2 very-active minutes,
-- 948.3 sedentary minutes and 2,358 calories/day.
-- High Very-Active: 253 records, averaging 65.6 very-active minutes,
-- 926.2 sedentary minutes and 2,853 calories/day.

-- BUSINESS INSIGHT 8: WEEKDAY VS WEEKEND ACTIVITY
USE strava_analytics;

SELECT
    CASE
        WHEN DAYOFWEEK(STR_TO_DATE(ActivityDate, '%m/%d/%Y')) IN (1, 7)
            THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,

    COUNT(*) AS activity_records,

    ROUND(AVG(TotalSteps), 0) AS average_steps,

    ROUND(AVG(Calories), 0) AS average_calories,

    ROUND(AVG(SedentaryMinutes), 0) AS average_sedentary_minutes

FROM daily_activity

GROUP BY day_type

ORDER BY
    CASE
        WHEN day_type = 'Weekday' THEN 1
        ELSE 2
    END;
    -- Result:
-- Weekday: 695 activity records, averaging 7,669 steps,
-- 2,302 calories and 996 sedentary minutes/day.
-- Weekend: 245 activity records, averaging 7,551 steps,
-- 2,310 calories and 977 sedentary minutes/day.

-- BUSINESS INSIGHT 9: TOP 10 MOST ACTIVE USERS
USE strava_analytics;

SELECT
    Id,
    COUNT(*) AS activity_records,
    ROUND(AVG(TotalSteps), 0) AS average_daily_steps,
    ROUND(AVG(Calories), 0) AS average_daily_calories,
    ROUND(AVG(VeryActiveMinutes), 1) AS average_very_active_minutes
FROM daily_activity
GROUP BY Id
ORDER BY average_daily_steps DESC
LIMIT 10;

-- Result:
-- Top 10 users were identified based on average daily steps.
-- The most active user averaged 16,040 steps/day,
-- followed by users averaging 14,763 and 12,117 steps/day.
-- Among the top 10 users, average daily steps ranged
-- from 9,372 to 16,040 steps/day.
-- Average very-active minutes ranged from 13.5 to 85.2 minutes/day.

-- BUSINESS INSIGHT 10: USER ACTIVITY CONSISTENCY
USE strava_analytics;

SELECT
    Id,
    COUNT(*) AS activity_days,
    ROUND(AVG(TotalSteps), 0) AS average_daily_steps,
    ROUND(AVG(Calories), 0) AS average_daily_calories,
    ROUND(AVG(VeryActiveMinutes), 1) AS average_very_active_minutes
FROM daily_activity
GROUP BY Id
ORDER BY activity_days DESC, average_daily_steps DESC
LIMIT 10;
-- Result:
-- The top 10 most consistent users each recorded activity
-- on 31 days.
-- Their average daily steps ranged from 8,572 to 16,040 steps/day.
-- Average daily calories ranged from 1,516 to 3,437 calories/day.
-- Average very-active minutes ranged from 5.1 to 85.2 minutes/day.

-- BUSINESS INSIGHT 11: PEAK ACTIVITY HOURS
USE strava_analytics;

SELECT
    HOUR(STR_TO_DATE(ActivityHour, '%m/%d/%Y %h:%i:%s %p')) AS activity_hour,
    COUNT(*) AS activity_records,
    SUM(StepTotal) AS total_steps,
    ROUND(AVG(StepTotal), 0) AS average_steps_per_record
FROM hourly_steps
GROUP BY HOUR(STR_TO_DATE(ActivityHour, '%m/%d/%Y %h:%i:%s %p'))
ORDER BY total_steps DESC
LIMIT 10;
-- Result:
-- 6:00 PM: 906 records, totaling 542,848 steps,
-- averaging 599 steps per record.
-- 7:00 PM: 906 records, totaling 528,552 steps,
-- averaging 583 steps per record.
-- 12:00 PM: 922 records, totaling 505,848 steps,
-- averaging 549 steps per record.
-- 5:00 PM: 906 records, totaling 498,517 steps,
-- averaging 550 steps per record.
-- 2:00 PM: 921 records, totaling 497,813 steps,
-- averaging 541 steps per record.
-- 1:00 PM: 921 records, totaling 495,220 steps,
-- averaging 538 steps per record.
-- 4:00 PM: 907 records, totaling 450,639 steps,
-- averaging 497 steps per record.
-- 10:00 AM: 929 records, totaling 447,467 steps,
-- averaging 482 steps per record.
-- 11:00 AM: 927 records, totaling 423,534 steps,
-- averaging 457 steps per record.
-- 9:00 AM: 931 records, totaling 403,404 steps,
-- averaging 433 steps per record.

-- BUSINESS INSIGHT 12: CALORIES BY ACTIVITY INTENSITY
USE strava_analytics;

SELECT
    CASE
        WHEN VeryActiveMinutes >= 30 THEN 'High Very-Active'
        WHEN VeryActiveMinutes >= 10 THEN 'Moderate Very-Active'
        ELSE 'Low Very-Active'
    END AS activity_intensity_segment,

    COUNT(*) AS record_count,

    ROUND(AVG(VeryActiveMinutes), 1) AS avg_very_active_minutes,

    ROUND(AVG(FairlyActiveMinutes), 1) AS avg_fairly_active_minutes,

    ROUND(AVG(LightlyActiveMinutes), 1) AS avg_lightly_active_minutes,

    ROUND(AVG(SedentaryMinutes), 1) AS avg_sedentary_minutes,

    ROUND(AVG(Calories), 0) AS avg_calories

FROM daily_activity

GROUP BY activity_intensity_segment

ORDER BY
    CASE
        WHEN activity_intensity_segment = 'Low Very-Active' THEN 1
        WHEN activity_intensity_segment = 'Moderate Very-Active' THEN 2
        ELSE 3
    END;
    -- Result:
-- Low Very-Active: 536 records, averaging 1.0 very-active minute,
-- 7.4 fairly-active minutes, 178.0 lightly-active minutes,
-- 1,034.0 sedentary minutes and 2,029 calories/day.
--
-- Moderate Very-Active: 151 records, averaging 18.2 very-active minutes,
-- 21.0 fairly-active minutes, 230.0 lightly-active minutes,
-- 948.3 sedentary minutes and 2,358 calories/day.
--
-- High Very-Active: 253 records, averaging 65.6 very-active minutes,
-- 22.2 fairly-active minutes, 201.9 lightly-active minutes,
-- 926.2 sedentary minutes and 2,853 calories/day.

-- BUSINESS INSIGHT 13: SLEEP DURATION VS DAILY ACTIVITY
USE strava_analytics;

SELECT
    CASE
        WHEN avg_sleep_minutes < 360 THEN 'Less than 6 Hours'
        WHEN avg_sleep_minutes < 480 THEN '6-8 Hours'
        ELSE 'More than 8 Hours'
    END AS sleep_segment,
    COUNT(*) AS user_count,
    ROUND(AVG(avg_daily_steps), 0) AS average_daily_steps,
    ROUND(AVG(avg_daily_calories), 0) AS average_daily_calories
FROM
(
    SELECT
        s.Id,
        AVG(s.TotalMinutesAsleep) AS avg_sleep_minutes,
        AVG(a.TotalSteps) AS avg_daily_steps,
        AVG(a.Calories) AS avg_daily_calories
    FROM sleep_day_clean AS s
    INNER JOIN daily_activity AS a
        ON s.Id = a.Id
    GROUP BY s.Id
) AS user_sleep_activity
GROUP BY sleep_segment
ORDER BY
    CASE
        WHEN sleep_segment = 'Less than 6 Hours' THEN 1
        WHEN sleep_segment = '6-8 Hours' THEN 2
        ELSE 3
    END;
    -- Result:
-- Less than 6 Hours: 8 users, averaging 7,693 daily steps
-- and 2,261 calories/day.
--
-- 6-8 Hours: 14 users, averaging 7,693 daily steps
-- and 2,411 calories/day.
--
-- More than 8 Hours: 2 users, averaging 4,073 daily steps
-- and 1,557 calories/day.

-- BUSINESS INSIGHT 14: WEEKDAY VS WEEKEND ACTIVITY

USE strava_analytics;

SELECT
    CASE
        WHEN DAYOFWEEK(STR_TO_DATE(ActivityDate, '%m/%d/%Y')) IN (1, 7)
            THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS activity_records,
    ROUND(AVG(TotalSteps), 0) AS average_daily_steps,
    ROUND(AVG(Calories), 0) AS average_daily_calories,
    ROUND(AVG(VeryActiveMinutes), 1) AS average_very_active_minutes,
    ROUND(AVG(SedentaryMinutes), 0) AS average_sedentary_minutes
FROM daily_activity
GROUP BY day_type
ORDER BY
    CASE
        WHEN day_type = 'Weekday' THEN 1
        ELSE 2
    END;
    -- Result:
-- Weekday: 695 records, averaging 7,669 daily steps,
-- 2,302 calories/day, 21.2 very-active minutes
-- and 996 sedentary minutes.
--
-- Weekend: 245 records, averaging 7,551 daily steps,
-- 2,310 calories/day, 21.0 very-active minutes
-- and 977 sedentary minutes.

-- BUSINESS INSIGHT 15: ACTIVITY LEVEL VS CALORIE EXPENDITURE
USE strava_analytics;

SELECT
    CASE
        WHEN TotalSteps < 5000 THEN 'Low Activity'
        WHEN TotalSteps < 10000 THEN 'Moderate Activity'
        ELSE 'High Activity'
    END AS activity_level,
    COUNT(*) AS activity_records,
    ROUND(AVG(TotalSteps), 0) AS average_daily_steps,
    ROUND(AVG(Calories), 0) AS average_daily_calories,
    ROUND(AVG(VeryActiveMinutes), 1) AS average_very_active_minutes
FROM daily_activity
GROUP BY activity_level
ORDER BY
    CASE
        WHEN activity_level = 'Low Activity' THEN 1
        WHEN activity_level = 'Moderate Activity' THEN 2
        ELSE 3
    END;
    -- Result:
-- Low Activity: 303 records, averaging 2,128 daily steps,
-- 1,807 calories/day and 2.3 very-active minutes.
--
-- Moderate Activity: 334 records, averaging 7,466 daily steps,
-- 2,355 calories/day and 13.4 very-active minutes.
--
-- High Activity: 303 records, averaging 13,337 daily steps,
-- 2,744 calories/day and 48.5 very-active minutes.