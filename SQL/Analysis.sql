
DROP TABLE Pass_VS_not_Pass

--Select * from CombinedDataSet_Cleaned

--> Client_ID that completed the steps per variation vs client count per Variation 
Select 
ctc.Variation
,Count(ctc.client_ID)as Completed_Process_Count
,Case when variation ='Control' then
(Select Count(distinct Client_ID) from CombinedDataSet_Cleaned where variation ='Control') --as record_count_Control
Else (Select Count(distinct Client_ID) from CombinedDataSet_Cleaned where variation ='Test') -- as record_count_test
End as Record_Count
into Pass_VS_not_Pass --> new Table
from 
(
Select
Client_ID
,Variation 
,Count (Distinct process_step)as Unique_Process_Step_Count 
from[CombinedDataSet_Cleaned] 
group by Client_ID,Variation
having Count (Distinct process_step)=5--> this will let us know the exact number of participant that pass the test

) ctc
Group by ctc.variation
--
--> Percentage Overall <--
Select *,convert(decimal,Completed_Process_Count)/Record_Count as PassPercent from Pass_VS_not_Pass
----------------------------------------------------------------------------


Drop table Pass_Per_Age_Group
----- AGE Category Data Completed test---
Select 
ctc.Variation
,ctc.Age_category
,Count(ctc.client_ID)as Completed_Process_Count
into Pass_Per_Age_Group
from 
(
Select 

Client_ID
,Variation
,Age_category
,Count (Distinct process_step)as Unique_Process_Step_Count 
from[CombinedDataSet_Cleaned] 
group by Client_ID,Variation,Age_category
having Count (Distinct process_step)=5 --> this will let us know the exact number of participant that pass the test
) ctc
Group by ctc.variation,Age_Category
-- --Select * from  Pass_Per_Age_Group order by variation, Age_Category

--> Process sucess Percentage per Age group 

Select 
r.variation
,r.age_Category
,Completed_Process_Count as Pass_count
,Record_Count as total_Client_ID
,CONVERT(decimal,Completed_Process_Count)/Record_Count as Percentage

from Pass_Per_Age_Group pass
inner join 
(
Select Variation,Age_Category,Count(Distinct Client_ID)as Record_Count from CombinedDataSet_Cleaned group by Age_Category,Variation --order by Variation,Age_category
) r
on r.variation=pass.variation and r.Age_Category=pass.Age_Category
--order by r.age_Category,r.variation
order by r.variation,r.age_Category

---->  performance per generation
Select 
--r.variation
 r.age_Category
,sum(Completed_Process_Count) as Pass_count
,Sum(Record_Count) as total_Client_ID
,Sum(CONVERT(decimal,Completed_Process_Count))/Sum(Record_Count) as Percentage

from Pass_Per_Age_Group pass
inner join 
(
Select Variation,Age_Category,Count(Distinct Client_ID)as Record_Count 
from CombinedDataSet_Cleaned group by Variation,Age_Category
) r
on 
r.variation=pass.variation 
and 
r.Age_Category=pass.Age_Category
Group by r.age_Category
order by r.age_Category--,r.variation

--------------------------------------------------------------
-- Steps dificulty per Age Category
Select 
 Variation
,Age_Category
,Process_Step
,Count(Process_Step)Process_Step_Count
,Count(distinct Client_ID) User_Count
,Convert(decimal(10,2),Round(Convert(decimal(10,2),Count(Process_Step))/Convert(decimal(10,2),Count(distinct Client_ID)),2)) as AVG_Repeated_Step
from CombinedDataSet_Cleaned 
Group by variation,Process_Step,Age_Category
having process_Step not in ('confirm','Start')
--and variation in ('Test') --and Age_Category='17-30'
--order by Process_Step,Age_Category,variation
order by --Age_Category,
Convert(decimal(10,2),Round(Convert(decimal(10,2),Count(Process_Step))/Convert(decimal(10,2),Count(distinct Client_ID)),2)) desc

-- Step dificulty per variation
Select 
 Variation
--,Age_Category
,Process_Step
,Count(Process_Step)Process_Step_Count
,Count(distinct Client_ID) User_Count
,Convert(decimal(10,2),Round(Convert(decimal(10,2),Count(Process_Step))/Convert(decimal(10,2),Count(distinct Client_ID)),2)) as AVG_Repeated_Step
from CombinedDataSet_Cleaned 
Group by variation,Process_Step--,Age_Category
having process_Step not in ('confirm','Start')
--and variation in ('Control') and Age_Category='17-30'
--order by Process_Step,Age_Category,variation
order by Convert(decimal(10,2),Round(Convert(decimal(10,2),Count(Process_Step))/Convert(decimal(10,2),Count(distinct Client_ID)),2)) desc

--> Session Count per variation

Select variation, AVG(Convert(decimal,Session_Count)) AVG_Session_Count from (
Select Variation,Client_ID,Count(distinct visit_ID)Session_Count from CombinedDataSet_Cleaned 
Group by Variation,Client_ID
--order by Variation,Client_ID
) AVG_Session_Per_Variation
group by variation

--> Session Count per variation per Age Group
Select variation,Age_Category, AVG(Convert(decimal,Session_Count)) AVG_Session_Count from (
Select Variation,Client_ID,Age_Category,Count(distinct visit_ID)Session_Count from CombinedDataSet_Cleaned 
Group by Variation,Client_ID,Age_Category
--order by Variation,Client_ID
) AVG_Session_Per_Variation
group by variation,Age_category
order by AVG(Convert(decimal,Session_Count)) desc

--> Session Count per Age Group
Select Age_Category, AVG(Convert(decimal,Session_Count)) AVG_Session_Count from (
Select Variation,Client_ID,Age_Category,Count(distinct visit_ID)Session_Count from CombinedDataSet_Cleaned 
Group by Variation,Client_ID,Age_Category
--order by Variation,Client_ID
) AVG_Session_Per_Variation
group by Age_category
order by AVG(Convert(decimal,Session_Count)) desc

--Select * from CombinedDataSet_Cleaned 
--where client_ID in
--(
-- '1028'
--,'1104'
--,'1186'
--)
--order by Client_ID,visit_ID

--Select Distinct 
--client_ID,Variation,Age,Age_category 
--from[CombinedDataSet_Cleaned]

