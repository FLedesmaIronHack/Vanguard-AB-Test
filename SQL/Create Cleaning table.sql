-- Cleaning Table Step 2

-- Drop table CombinedDataSet_Cleaned

-- merge these two files prior to a comprehensive data analysis.
  -- 241228
-- March & April Data
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
  where Variation !='NA' -- > Exclude NA

  Union all --- > need to be unified 
  -- May & June Data
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

  -- drop table #CombinedDataSet_Cleaned 
  -- > Records 317235
    Select Distinct
	  s.[client_id] --> Fk
	  ,Convert(int,d.clnt_age) Age
	  ,Case 
	  --when convert(int,clnt_age) between 17 and 30 then '17-30'
	  --when convert(int,clnt_age) between 31 and 50 then '31-50' 
	  --when convert(int,clnt_age) between 51 and 70 then '51-70' 
	  --when convert(int,clnt_age) >=71 then '71+' 
	  when convert(int,clnt_age) between 17 and 34 then '17-34'
	  when convert(int,clnt_age) between 35 and 50 then '35-50' 
	  when convert(int,clnt_age) between 51 and 60 then '51-60' 
	  when convert(int,clnt_age) >=61 then '61+' 
	  end as Age_Category
	  ,variation
      ,[visitor_id]
      ,[visit_id]
      ,[process_step]
      ,[date_time] 
	  into CombinedDataSet_Cleaned 
	  from #CombinedDataSet s
	  inner join df_final_demo d
	  on s.client_id = d.client_id

	  
-- > Deleting records with missing age --> 13 client_ID with a total of 112 records
Delete e 
from CombinedDataSet_Cleaned e
--Select Variation,d.* from df_final_demo d
--inner join df_final_experiment_clients e
--on e. client_id=d.client_id
where e.client_ID in 
(
 '355337'
,'1037867'
,'1227228'
,'2222915'
,'4666211'
,'4876926'
,'5144725'
,'5277910'
,'7402828'
,'7616759'
,'8191345'
,'8412164'
,'8611797'
) 

-- Select Count(*) from CombinedDataSet_Cleaned