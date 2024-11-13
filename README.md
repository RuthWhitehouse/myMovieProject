# MyMovieProject

## Directory

| Folder      | Content |
| ----------- | ----------- |
| code      | ipynb, SQL, and twb files |
| data      | xlsx and csv files |

## Links

I obtained the data from [Kaggle](https://www.kaggle.com/datasets/danielgrijalvas/movies) on October 23rd, 2024.

Link to Tableau Public Dashboard is [here](https://public.tableau.com/app/profile/ruth.whitehouse/viz/myMovieProject/Dashboard1).

## Objective

To answer a series of questions that came to mind when looking over the dataset

1. Does a director's movie gross more later on in their career?
2. How does score change over time?
3. What quarter of the year has the heighest average grossing movies?
4. What country averages the highest revenue? 

## Tools used

* Anaconda
* Jupyter Notebook
* SQL Server Management Studio
* Tableau Public

## The Process

1. Download the data
2. Clean the data using Jupyter Notebook
3. Export the data to a xlsx file
4. Write queries & create views on the data in SQL Server Managent Studio
5. Utilize the views to create xlsx files
6. Create Visualization in Tableau
7. Make a dashboard for the visualizations
8. Make the dashboard available for public view

## My findings
1. The data shows that a director's most recent movie will gross more than their first movie 58% of the time
2. The data shows a pretty consistent score for the movies over time, but with a noticeable drop in score in the year 2020
3. The quarter of the year that grosses the most is Q2, which contains the summer months. Q4, with the holiday months, is runner up
4. According to the data, the top 3 are Malta, New Zealand, and China
	* Upon a quick query, I discovered Malta had one movie, Murder on the Orient Express, whilst New Zealand and China had many. In the future, I would instead indicate grand total gross by country in order to gain more effective insights.