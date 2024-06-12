CREATE VIEW vw_PercentageOverall AS
SELECT *, 
       CONVERT(decimal(10, 2), Completed_Process_Count) / Record_Count AS PassPercent
FROM Pass_VS_not_Pass;
----------------
CREATE VIEW vw_ProcessSuccessPercentagePerAgeGroup AS
SELECT 
    r.variation,
    r.age_Category,
    pass.Completed_Process_Count AS Pass_count,
    r.Record_Count AS total_Client_ID,
    CONVERT(decimal(10, 2), pass.Completed_Process_Count) / r.Record_Count AS Percentage
FROM Pass_Per_Age_Group pass
INNER JOIN 
(
    SELECT 
        Variation,
        Age_Category,
        COUNT(DISTINCT Client_ID) AS Record_Count 
    FROM CombinedDataSet_Cleaned 
    GROUP BY Age_Category, Variation
) r
ON r.variation = pass.variation 
   AND r.Age_Category = pass.Age_Category
--ORDER BY r.age_Category, r.variation;


------------------
CREATE VIEW vw_PerformancePerGeneration AS
SELECT 
    r.age_Category,
    SUM(pass.Completed_Process_Count) AS Pass_count,
    SUM(r.Record_Count) AS total_Client_ID,
    SUM(CONVERT(decimal(10, 2), pass.Completed_Process_Count)) / SUM(r.Record_Count) AS Percentage
FROM Pass_Per_Age_Group pass
INNER JOIN 
(
    SELECT 
        Variation,
        Age_Category,
        COUNT(DISTINCT Client_ID) AS Record_Count 
    FROM CombinedDataSet_Cleaned 
    GROUP BY Variation, Age_Category
) r
ON r.variation = pass.variation 
   AND r.Age_Category = pass.Age_Category
GROUP BY r.age_Category
--ORDER BY r.age_Category;
-----------------
CREATE VIEW vw_StepsDifficultyPerAgeCategory AS
SELECT 
    Variation,
    Age_Category,
    Process_Step,
    COUNT(Process_Step) AS Process_Step_Count,
    COUNT(DISTINCT Client_ID) AS User_Count,
    CONVERT(decimal(10, 2), ROUND(CONVERT(decimal(10, 2), COUNT(Process_Step)) / CONVERT(decimal(10, 2), COUNT(DISTINCT Client_ID)), 2)) AS AVG_Repeated_Step
FROM CombinedDataSet_Cleaned 
GROUP BY variation, Process_Step, Age_Category
HAVING Process_Step NOT IN ('confirm', 'Start')
--ORDER BY CONVERT(decimal(10, 2), ROUND(CONVERT(decimal(10, 2), COUNT(Process_Step)) / CONVERT(decimal(10, 2), COUNT(DISTINCT Client_ID)), 2)) DESC;
-------------------
CREATE VIEW vw_StepsDifficultyPerVariation AS
SELECT 
    Variation,
    Process_Step,
    COUNT(Process_Step) AS Process_Step_Count,
    COUNT(DISTINCT Client_ID) AS User_Count,
    CONVERT(decimal(10, 2), ROUND(CONVERT(decimal(10, 2), COUNT(Process_Step)) / CONVERT(decimal(10, 2), COUNT(DISTINCT Client_ID)), 2)) AS AVG_Repeated_Step
FROM CombinedDataSet_Cleaned 
GROUP BY variation, Process_Step
HAVING Process_Step NOT IN ('confirm', 'Start')
--ORDER BY CONVERT(decimal(10, 2), ROUND(CONVERT(decimal(10, 2), COUNT(Process_Step)) / CONVERT(decimal(10, 2), COUNT(DISTINCT Client_ID)), 2)) DESC;

------------------------
CREATE VIEW vw_SessionCountPerVariation AS
SELECT variation, 
       AVG(CONVERT(decimal(10, 2), Session_Count)) AS AVG_Session_Count 
FROM (
    SELECT Variation,
           Client_ID,
           COUNT(DISTINCT visit_ID) AS Session_Count 
    FROM CombinedDataSet_Cleaned 
    GROUP BY Variation, Client_ID
) AVG_Session_Per_Variation
GROUP BY variation;

--------------
CREATE VIEW vw_SessionCountPerVariationPerAgeGroup AS
SELECT variation, 
       Age_Category, 
       AVG(CONVERT(decimal(10, 2), Session_Count)) AS AVG_Session_Count 
FROM (
    SELECT Variation,
           Client_ID,
           Age_Category,
           COUNT(DISTINCT visit_ID) AS Session_Count 
    FROM CombinedDataSet_Cleaned 
    GROUP BY Variation, Client_ID, Age_Category
) AVG_Session_Per_Variation
GROUP BY variation, Age_Category
--ORDER BY AVG(CONVERT(decimal(10, 2), Session_Count)) DESC;

---------------

CREATE VIEW vw_SessionCountPerAgeGroup AS
SELECT Age_Category, 
       AVG(CONVERT(decimal(10, 2), Session_Count)) AS AVG_Session_Count 
FROM (
    SELECT Variation,
           Client_ID,
           Age_Category,
           COUNT(DISTINCT visit_ID) AS Session_Count 
    FROM CombinedDataSet_Cleaned 
    GROUP BY Variation, Client_ID, Age_Category
) AVG_Session_Per_Variation
GROUP BY Age_Category
--ORDER BY AVG(CONVERT(decimal(10, 2), Session_Count)) DESC;

