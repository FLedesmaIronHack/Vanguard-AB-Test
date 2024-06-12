--Combined DF
IF OBJECT_ID('tempdb..#CombinedDataSet') IS NOT NULL
BEGIN
    DROP TABLE #CombinedDataSet;
END

IF OBJECT_ID('tempdb..#CombinedDataSet_Cleaned') IS NOT NULL
BEGIN
    DROP TABLE #CombinedDataSet_Cleaned ;
END

SELECT 
	   pt1.[client_id] -- FK
	  ,fec.Variation
      ,[visitor_id]
      ,[visit_id]
      ,[process_step]
      ,[date_time]
	 into #CombinedDataSet -- > New Datase Combined
  FROM [dbo].[df_final_web_data_pt_1] pt1
inner join  [dbo].[df_final_experiment_clients] fec
on pt1.client_id=fec.client_id
  where Variation !='NA' --> Exclude NA

  Union all 
SELECT 
	   pt2.[client_id] --> Fk
	  ,fec.Variation
      ,[visitor_id]
      ,[visit_id]
      ,[process_step]
      ,[date_time]
  FROM [dbo].[df_final_web_data_pt_2] pt2
  inner join  [dbo].[df_final_experiment_clients] fec
on pt2.client_id=fec.client_id
  where Variation !='NA' --> Exclude NA
  --> Combined Data Frame added Columns (Age_Category)
  
  Select Distinct
	  s.[client_id] --> Fk
	  ,Convert(int,d.clnt_age) Age
	  ,Case 
	  when convert(int,clnt_age) between 17 and 30 then '17-30'
	  when convert(int,clnt_age) between 31 and 50 then '31-50' 
	  when convert(int,clnt_age) between 51 and 70 then '51-70' 
	  when convert(int,clnt_age) >=71 then '71+' 
	  end as Age_Category
	  ,variation
      ,[visitor_id]
      ,[visit_id]
      ,[process_step]
      ,[date_time] 
	  into #CombinedDataSet_Cleaned 
	  from #CombinedDataSet s
	  inner join df_final_demo d
	  on s.client_id = d.client_id
	  -- Select * from #CombinedDataSet_Cleaned order by Client_ID,visit_id,visitor_id, date_Time desc

--Identify Records with more than one entries with the process step = Confirm	  
Select 
client_id
,Variation
,visitor_id
,visit_id
,Process_step
--,Date_time -- Need to eliminate
,count(Process_Step) Process_Step_Count_Per_Session
from #CombinedDataSet_Cleaned 
Group by
client_id
,Variation
,visitor_id
,visit_id
,Process_step
--,Date_time -- need to eliminate
having process_step='confirm' and count(Process_Step)>1
order by visitor_id,visit_ID desc

--> Create table to identify the records that need to be deleted Row_Number Function
Select 
client_id
,Variation
,visitor_id
,visit_id
,Process_step
,date_Time
,Row_Number() over( partition by client_id,Variation,visitor_id,visit_id,Process_step
order by visitor_id,visit_id, Date_time asc
)as Record_Number
into #Records_Number
from #CombinedDataSet_Cleaned --> New table
Where process_step='confirm'
order by visitor_id,visit_ID desc

Select * from #Records_Number
--> 5057 records duplicated
 Delete c 
--Select *

from #CombinedDataSet_Cleaned c
inner join #Records_Number r
on c.client_id=r.client_id 
and c.visit_id=r.visit_id 
and c.visitor_id=r.visitor_id 
and c.date_time=r.date_time 
where r.Record_Number>1
