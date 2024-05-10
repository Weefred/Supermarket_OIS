--1) Number of meal-types

SELECT DISTINCT [Type_of_Meal]
FROM [dbo].[Invoices]

--2) Number of sales representatives

SELECT COUNT(DISTINCT [Sales_Rep]) AS 'No. of Sales Reps'
FROM [dbo].[SalesTeam]

--3) Total orders

SELECT FORMAT(COUNT( DISTINCT i.[Order_Id]), 'N0') AS Total_orders
FROM [dbo].[Invoices] i
JOIN[dbo].[OrderLeads] o
ON i.[Order_Id]=o.Order_Id

--4) Participants by meal type

SELECT[Type_of_Meal],COUNT([No_of_participants]) AS Num_of_particpants
FROM[dbo].[Invoices]
GROUP BY[Type_of_Meal]
ORDER BY Num_of_particpants DESC

--5) No. of converted orders by meal type

SELECT[Type_of_Meal], COUNT([No_of_participants]) AS converted_orders
FROM[dbo].[Invoices] i
JOIN[dbo].[OrderLeads] o
ON i.Order_Id=o.Order_Id
WHERE [Converted]='converted'
GROUP BY[Type_of_Meal]
ORDER BY  converted_orders DESC

--6) No. of 'not converted' orders by meal type

SELECT[Type_of_Meal], COUNT([No_of_participants]) AS orders_not_converted
FROM[dbo].[Invoices] i
JOIN[dbo].[OrderLeads] o
ON i.Order_Id=o.Order_Id
WHERE [Converted]='not converted'
GROUP BY[Type_of_Meal]
ORDER BY  orders_not_converted DESC

--7) Total revenue generated from meal sales

SELECT FORMAT (SUM([Order_Value]), 'N0') AS Total_revenue
FROM [dbo].[OrderLeads] o
JOIN[dbo].[Invoices] i
ON o.Order_Id=i.Order_Id
WHERE [Converted]='converted'

--8) How does revenue vary over the different meal types?

SELECT [Type_of_Meal],FORMAT (SUM([Order_Value]), 'N0') AS Revenue
FROM [dbo].[Invoices] i
JOIN [dbo].[OrderLeads] O
ON i.[Order_Id]=o.[Order_Id]
WHERE [Converted]='converted'
GROUP BY [Type_of_Meal]
ORDER BY revenue DESC

--9) Total revenue for each year

SELECT i.[Year],SUM([Order_Value]) AS Revenue
FROM [dbo].[Invoices] i
JOIN [dbo].[OrderLeads] O
ON i.[Order_Id]=o.[Order_Id]
WHERE [Converted]='converted'
GROUP BY i.[Year] 
ORDER BY revenue DESC

--10) How does the number of participants in meals vary over time?

SELECT [Year_DOM], SUM([No_of_participants]) AS Num_of_participants
FROM [dbo].[Invoices] i
JOIN [dbo].[OrderLeads] o
ON i.Order_Id=o.Order_Id
WHERE [Converted]= 'converted'
GROUP BY [Year_DOM]
ORDER BY Num_of_participants DESC

--11) How does conversion numbers vary overtime

SELECT i.[Year], COUNT([Converted]) AS Num_of_coversions
FROM[dbo].[Invoices] i
JOIN [dbo].[OrderLeads] o
ON i.[Order_Id]=o.[Order_Id]
WHERE [Converted]= 'converted'
GROUP BY I.[Year]
ORDER BY Num_of_coversions DESC

--12) Which day of the week recorded the highest revenue?

SELECT [day_of_week],SUM([Order_Value]) AS Revenue
FROM [dbo].[Invoices] i
JOIN [dbo].[OrderLeads] O
ON i.[Order_Id]=o.[Order_Id]
WHERE [Converted]='converted'
GROUP BY[day_of_week] 
ORDER BY revenue DESC

--13) Trends or patterns in the conversion rates over time

SELECT
    i.[Year],
    COUNT(i.Order_Id) AS TotalOrders,
    SUM(CASE WHEN [Converted]= 'Converted' THEN 1 ELSE 0 END) AS ConvertedOrders,
    CAST(SUM(CASE WHEN [Converted] = 'Converted' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(i.Order_Id) AS ConversionRate
FROM [dbo].[Invoices] i
JOIN[dbo].[OrderLeads] o
ON i.Order_Id=o.Order_Id
--WHERE i.[Year]= 2014
GROUP BY i.[Year]
ORDER BY ConvertedOrders DESC

--14) What is the conversion rate of leads to orders?

SELECT
    CAST(SUM(CASE WHEN [Converted] = 'Converted' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(Order_Id) AS ConversionRate
FROM [dbo].[OrderLeads]
    
--15) Which sales representative has the highest num of conversions 

SELECT [Sales_Rep], COUNT([Converted]) AS Num_of_conversions
FROM [dbo].[SalesTeam] s
JOIN[dbo].[OrderLeads] O
ON s.Company_Id=o.Company_Id
WHERE [Converted]= converted
GROUP BY[Sales_Rep]
ORDER BY Num_of_conversions DESC






