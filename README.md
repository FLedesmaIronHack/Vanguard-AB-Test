Project Summary: Vanguard Digital Experiment Analysis

Presentation link - https://docs.google.com/presentation/d/1wIbC1poVdTNviQEQ2tMvVbMQ8GvfEOXAS7-hUyQV7Dw/edit#slide=id.g24b86493603_0_204

Introduction
In this project, we applied the skills and knowledge about EDA and data cleaning, performance metrics, hypothesis testing, experiment evaluation, and Tableau visualizations.

Context
As newly employed data analyst in the Customer Experience (CX) team at Vanguard, we were tasked with analyzing the results of a digital experiment. The experiment aimed to evaluate if a new, more intuitive User Interface (UI) with in-context prompts would lead to a better user experience and higher process completion rates compared to the traditional UI.

The Digital Challenge
Objective: Determine if the new UI design improves user experience and completion rates.
Experiment Duration: 3/15/2017 - 6/20/2017 (3 months)

Groups:
Control Group: Clients interacted with the traditional UI.
Test Group: Clients experienced the new UI.



Data Tools
We utilized three datasets:
Client Profiles (df_final_demo): Demographics of clients.
Digital Footprints (df_final_web_data): Client interactions online.
Experiment Roster (df_final_experiment_clients): List of clients in the experiment.

Datasource link:
https://www.dropbox.com/scl/fi/8qff47htxopyku3k8u1lo/df_final_experiment_clients.csv?rlkey=nepmdruop6dmtko0dbomv8zla&dl=1
https://www.dropbox.com/scl/fi/ibyqzf7ppqpyixl6yy0qm/df_final_demo.csv?rlkey=rnxuqtw9myo9j6xm2z7h6aslo&st=b2392lte&dl=1
https://www.dropbox.com/scl/fi/z6jeur8hnu7i7ckajnwuo/df_final_web_data_pt_1.txt?rlkey=jk1ux1ut5fsx8831ntd3bb3nb&st=awnzel22&dl=1
https://www.dropbox.com/scl/fi/vb1zpc1v249r145vbu3az/df_final_web_data_pt_2.txt?rlkey=x4uooym9ssxa3l1ejabhkrux2&st=wzsz600a&dl=1

Project Setup and Execution
We worked as a pair, created a Kanban board for project management, and divided the work efficiently. Python (Google Colab) and SQL were used for data cleaning and analysis. The project was executed over two weeks, with specific tasks allocated for each day.

Analysis and Methodology
Data Preparation:
Merged and cleaned datasets.
Dropped unnecessary columns and null values.
Categorized age groups.

Client Behavior Analysis:
Frequency and proportion tables for client ages were prompted.
Histogram of client ages were created.

KPIs and Metrics:
Completion Rate: Proportion of users who completed the process.
Repeated Step Count: Average number of times a client repeated a step.

Hypothesis Testing:
- Completion Rate:
Null: No significant difference between the control and test groups.
Alternate: Significant improvement in the test group.
- Repeated Steps:
Null: No significant difference in repeated steps between the groups.
Alternate: Significant reduction in repeated steps for the test group.

Used proportions z-test and two-sample t-test.

Results:
Test Group has a higher completion rate (68%) compared to the Control Group (65%).
Younger clients (17-34) have a better completion rate.
Older clients (61+) have the lowest completion rate and highest repeated steps.
Step 1 has the most repetitions.
Vanguard's clients are mostly in their late 50s, with a considerable number in their late 20s.

Potential Biases:
Selection Bias - the selection of clients might not be representative of Vanguards clients
Behavioral Bias - some clients might know they are part of an experiment
Technological Bias - the devices the clients used could indicate some performance difference

Recommendations
User Interface Improvements:
- Enhance Step 1 to reduce repetitions.
- Tailor the UI to better suit older clients.

Target Audience:
- Focus on engaging younger clients while addressing the needs of older clients.

Potential Further Data Collection:
Collect more detailed demographic data, income levels, and geographic locations for deeper insights.

Teamwork and Project Management
Collaborative effort throughout the project.
Used Zoom and Trello for communication and project tracking.
Python and SQL were used for data analysis, while individual tasks focused on Tableau visualizations and presentation preparation.

Conclusion
The new UI design led to a significant improvement in completion rates. However, it did not significantly reduce repeated steps. These insights can guide future design improvements and targeted client engagement strategies.