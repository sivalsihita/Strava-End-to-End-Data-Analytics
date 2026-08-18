/* ============================================================
   1. DATABASE SETUP
   ============================================================ */
CREATE DATABASE strava_analytics;

/* ============================================================
   2. DAILY ACTIVITY — DATA PROFILING & VALIDATION
   ============================================================ */

-- 2.1 Total number of records
USE strava_analytics;

SELECT COUNT(*) AS total_rows
FROM daily_activity;

-- 2.2 Number of unique users
SELECT COUNT(DISTINCT Id) AS unique_users
FROM daily_activity;

-- 2.3 Sample records
SELECT *
FROM daily_activity
LIMIT 5;

-- 2.4 Missing-value check
SELECT
    COUNT(*) AS total_rows,
    SUM(Id IS NULL) AS missing_id,
    SUM(ActivityDate IS NULL) AS missing_date,
    SUM(TotalSteps IS NULL) AS missing_steps,
    SUM(Calories IS NULL) AS missing_calories
FROM daily_activity;

-- 2.5 Duplicate records by user and activity date
SELECT
    Id,
    ActivityDate,
    COUNT(*) AS duplicate_count
FROM daily_activity
GROUP BY Id, ActivityDate
HAVING COUNT(*) > 1;

-- 2.6 Activity date range
SELECT
    MIN(ActivityDate) AS start_date,
    MAX(ActivityDate) AS end_date
FROM daily_activity;

-- 2.7 Coverage of users and dates
SELECT
    COUNT(DISTINCT Id) AS users,
    COUNT(DISTINCT ActivityDate) AS unique_dates
FROM daily_activity;

-- 2.8 Zero-step days
SELECT
    COUNT(*) AS zero_step_days
FROM daily_activity
WHERE TotalSteps = 0;

-- 2.9 Zero-calorie days
SELECT
    COUNT(*) AS zero_calorie_days
FROM daily_activity
WHERE Calories = 0;

-- 2.10 Records showing a full day of sedentary time
SELECT
    COUNT(*) AS sedentary_1440_records
FROM daily_activity
WHERE SedentaryMinutes = 1440;

-- 2.11 Details of full-sedentary records
SELECT
    Id,
    ActivityDate,
    TotalSteps,
    Calories,
    SedentaryMinutes
FROM daily_activity
WHERE SedentaryMinutes = 1440
ORDER BY Id, ActivityDate;

-- 2.12 Records with both zero steps and a full sedentary day
SELECT
    COUNT(*) AS zero_steps_and_full_sedentary
FROM daily_activity
WHERE TotalSteps = 0
  AND SedentaryMinutes = 1440;
  
  -- 2.13 Records with zero calories
  SELECT
    Id,
    ActivityDate,
    TotalSteps,
    Calories,
    SedentaryMinutes
FROM daily_activity
WHERE Calories = 0;

-- 2.14 Zero-step records that are not full-sedentary days
SELECT
    Id,
    ActivityDate,
    TotalSteps,
    Calories,
    SedentaryMinutes
FROM daily_activity
WHERE TotalSteps = 0
  AND SedentaryMinutes <> 1440
ORDER BY Id, ActivityDate;

-- 2.15 Full-sedentary records with recorded steps
SELECT
    Id,
    ActivityDate,
    TotalSteps,
    Calories,
    SedentaryMinutes
FROM daily_activity
WHERE SedentaryMinutes = 1440
  AND TotalSteps > 0
ORDER BY Id, ActivityDate;

-- 2.16 Detailed review of potentially inconsistent records
SELECT
    Id,
    ActivityDate,
    TotalSteps,
    VeryActiveMinutes,
    FairlyActiveMinutes,
    LightlyActiveMinutes,
    SedentaryMinutes,
    Calories
FROM daily_activity
WHERE SedentaryMinutes = 1440
  AND TotalSteps > 0
ORDER BY Id, ActivityDate;

/* ============================================================
   3. HOURLY STEPS — DATA PROFILING & VALIDATION
   ============================================================ */
   
   
USE strava_analytics;
SELECT COUNT(*) AS total_rows
FROM hourly_steps;

SELECT COUNT(DISTINCT Id) AS unique_users
FROM hourly_steps;

SELECT *
FROM hourly_steps
LIMIT 5;

-- 3.1 Missing-value check
SELECT
    COUNT(*) AS total_rows,
    SUM(Id IS NULL) AS missing_id,
    SUM(ActivityHour IS NULL) AS missing_hour,
    SUM(StepTotal IS NULL) AS missing_steps
FROM hourly_steps;

-- 3.2  Duplicate records
SELECT
    Id,
    ActivityHour,
    COUNT(*) AS duplicate_count
FROM hourly_steps
GROUP BY Id, ActivityHour
HAVING COUNT(*) > 1;

-- 3.3  Date-time range
SELECT
    MIN(ActivityHour) AS start_datetime,
    MAX(ActivityHour) AS end_datetime
FROM hourly_steps;

-- 3.4  Negative step values
SELECT
    COUNT(*) AS negative_step_records
FROM hourly_steps
WHERE StepTotal < 0;

-- 3.5  Zero-step hourly records
SELECT
    COUNT(*) AS zero_step_hours
FROM hourly_steps
WHERE StepTotal = 0;

/* ============================================================
   4. HOURLY CALORIES — DATA PROFILING & VALIDATION
   ============================================================ */
   
USE strava_analytics;

SELECT COUNT(*) AS total_rows
FROM hourlycalories;

SELECT COUNT(*) AS total_rows
FROM strava_analytics.hourlycalories;

SELECT COUNT(DISTINCT Id) AS unique_users
FROM hourlycalories;

USE strava_analytics;

SELECT *
FROM hourlycalories
LIMIT 5;

-- 4.1  Missing-value check
SELECT
    COUNT(*) AS total_rows,
    SUM(Id IS NULL) AS missing_id,
    SUM(ActivityHour IS NULL) AS missing_hour,
    SUM(Calories IS NULL) AS missing_calories
FROM hourlycalories;


-- 4.2  Date-time rangeSELECT
    MIN(ActivityHour) AS start_datetime,
    MAX(ActivityHour) AS end_datetime
FROM hourlycalories;

-- 4.3 Negative calorie values
SELECT
    COUNT(*) AS negative_calorie_records
FROM hourlycalories
WHERE Calories < 0;

-- 4.4  Zero-calorie hourly records
SELECT
    COUNT(*) AS zero_calorie_hours
FROM hourlycalories
WHERE Calories = 0;

/* ============================================================
   5. HOURLY INTENSITIES — DATA PROFILING & VALIDATION
   ============================================================ */
   
USE strava_analytics;

SELECT COUNT(*) AS total_rows
FROM hourly_intensities;

SELECT *
FROM hourly_intensities
LIMIT 5;

USE strava_analytics;

SELECT COUNT(DISTINCT Id) AS unique_users
FROM hourly_intensities;

-- 5.1  Missing-value check
SELECT
    COUNT(*) AS total_rows,
    SUM(Id IS NULL) AS missing_id,
    SUM(ActivityHour IS NULL) AS missing_hour,
    SUM(TotalIntensity IS NULL) AS missing_total_intensity,
    SUM(AverageIntensity IS NULL) AS missing_average_intensity
FROM hourly_intensities;


-- 5.2  Duplicate recordsSELECT
    SELECT
    Id,
    ActivityHour,
    COUNT(*) AS duplicate_count
FROM hourly_intensities
GROUP BY Id, ActivityHour
HAVING COUNT(*) > 1;

-- 5.3  Date-time range
SELECT
    MIN(ActivityHour) AS start_datetime,
    MAX(ActivityHour) AS end_datetime
FROM hourly_intensities;

-- 5.4  Negative intensity values
SELECT
    COUNT(*) AS negative_intensity_records
FROM hourly_intensities
WHERE TotalIntensity < 0
   OR AverageIntensity < 0;
   
   /* ============================================================
   6. SLEEP DAY — DATA PROFILING & VALIDATION
   ============================================================ */
   
   USE strava_analytics;

SELECT COUNT(*) AS total_rows
FROM sleep_day;

SELECT COUNT(DISTINCT Id) AS unique_users
FROM sleep_day;

SELECT *
FROM sleep_day
LIMIT 5;

-- 6.1 Missing-value check
SELECT
    COUNT(*) AS total_rows,
    SUM(Id IS NULL) AS missing_id,
    SUM(SleepDay IS NULL) AS missing_sleep_day,
    SUM(TotalSleepRecords IS NULL) AS missing_sleep_records,
    SUM(TotalMinutesAsleep IS NULL) AS missing_minutes_asleep,
    SUM(TotalTimeInBed IS NULL) AS missing_time_in_bed
FROM sleep_day;


-- 6.2  Duplicate recordsSELECT
    SELECT
    Id,
    SleepDay,
    COUNT(*) AS duplicate_count
FROM sleep_day
GROUP BY Id, SleepDay
HAVING COUNT(*) > 1;

-- 6.3  Sleep date range
SELECT
    MIN(SleepDay) AS start_datetime,
    MAX(SleepDay) AS end_datetime
FROM sleep_day;

-- 6.4 Invalid sleep-duration records
SELECT COUNT(*) AS invalid_sleep_records
FROM sleep_day
WHERE TotalMinutesAsleep < 0
   OR TotalTimeInBed < 0
   OR TotalMinutesAsleep > TotalTimeInBed;

  /* ============================================================
   7. SLEEP DUPLICATE INVESTIGATION
   ============================================================ */ 
  
 -- 7.1  Review the known duplicate user/date combinations
 SELECT
    Id,
    SleepDay,
    TotalSleepRecords,
    TotalMinutesAsleep,
    TotalTimeInBed
FROM sleep_day
WHERE Id IN (4388161847, 4702921684, 8378563200)
ORDER BY Id, SleepDay;

-- 7.2  General duplicate-record review
SELECT
    s.Id,
    s.SleepDay,
    s.TotalSleepRecords,
    s.TotalMinutesAsleep,
    s.TotalTimeInBed
FROM sleep_day AS s
INNER JOIN (
    SELECT
        Id,
        SleepDay
    FROM sleep_day
    GROUP BY Id, SleepDay
    HAVING COUNT(*) > 1
) AS d
    ON s.Id = d.Id
   AND s.SleepDay = d.SleepDay
ORDER BY s.Id, s.SleepDay;

/* ============================================================
   8. CREATE CLEANED SLEEP DATASET
   ============================================================
   One record is retained for each unique combination of
   Id and SleepDay.
   ============================================================ */

CREATE TABLE sleep_day_clean AS
SELECT
    Id,
    SleepDay,
    TotalSleepRecords,
    TotalMinutesAsleep,
    TotalTimeInBed
FROM (
    SELECT
        Id,
        SleepDay,
        TotalSleepRecords,
        TotalMinutesAsleep,
        TotalTimeInBed,
        ROW_NUMBER() OVER (
            PARTITION BY Id, SleepDay
            ORDER BY Id
        ) AS rn
    FROM sleep_day
) AS cleaned
WHERE rn = 1;

/* ============================================================
   9. CLEANING VALIDATION
   ============================================================ */
   
SELECT COUNT(*) AS cleaned_rows
FROM sleep_day_clean;

-- Confirm that duplicate Id + SleepDay combinations are removed
SELECT
    Id,
    SleepDay,
    COUNT(*) AS duplicate_count
FROM sleep_day_clean
GROUP BY Id, SleepDay
HAVING COUNT(*) > 1;
/* ============================================================
   END OF DATA CLEANING & VALIDATION
   ============================================================ */
   
   
   USE strava_analytics;

DROP VIEW IF EXISTS tableau_dashboard_data;

CREATE VIEW tableau_dashboard_data AS

SELECT
    a.Id,

    STR_TO_DATE(a.ActivityDate, '%m/%d/%Y') AS activity_date,

    /* ---------------- BASIC ACTIVITY ---------------- */
    a.TotalSteps AS total_steps,
    a.Calories AS calories,

    a.VeryActiveMinutes AS very_active_minutes,
    a.FairlyActiveMinutes AS fairly_active_minutes,
    a.LightlyActiveMinutes AS lightly_active_minutes,
    a.SedentaryMinutes AS sedentary_minutes,

    /* ---------------- ACTIVITY LEVEL ---------------- */
    CASE
        WHEN a.TotalSteps < 5000 THEN 'Low Activity'
        WHEN a.TotalSteps < 10000 THEN 'Moderate Activity'
        ELSE 'High Activity'
    END AS activity_level,

    /* ---------------- ACTIVITY INTENSITY ---------------- */
    CASE
        WHEN a.VeryActiveMinutes >= 30 THEN 'High Very-Active'
        WHEN a.VeryActiveMinutes >= 10 THEN 'Moderate Very-Active'
        ELSE 'Low Very-Active'
    END AS activity_intensity_segment,

    /* ---------------- DAY TYPE ---------------- */
    CASE
        WHEN DAYOFWEEK(
            STR_TO_DATE(a.ActivityDate, '%m/%d/%Y')
        ) IN (1,7)
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,

    /* ---------------- SLEEP ---------------- */
    s.TotalMinutesAsleep AS total_minutes_asleep,
    s.TotalTimeInBed AS total_time_in_bed,

    CASE
        WHEN s.TotalTimeInBed > 0
        THEN ROUND(
            (s.TotalMinutesAsleep / s.TotalTimeInBed) * 100,
            1
        )
        ELSE NULL
    END AS sleep_efficiency,

    CASE
        WHEN s.TotalMinutesAsleep < 360 THEN 'Less than 6 Hours'
        WHEN s.TotalMinutesAsleep <= 480 THEN '6-8 Hours'
        ELSE 'More than 8 Hours'
    END AS sleep_segment

FROM daily_activity AS a

LEFT JOIN sleep_day_clean AS s
    ON a.Id = s.Id
    AND STR_TO_DATE(a.ActivityDate, '%m/%d/%Y')
        = STR_TO_DATE(s.SleepDay, '%m/%d/%Y');
        
        SELECT *
FROM tableau_dashboard_data
LIMIT 20;

USE strava_analytics;

SELECT *
FROM tableau_dashboard_data;
   
