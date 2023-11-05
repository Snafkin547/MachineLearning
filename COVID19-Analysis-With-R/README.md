# COVID19-Analysis

## Project Overview
This project aims to visualize the progress of vaccinations against the notoriously prevailing COVID-19.

Instead of showing just pure numbers of doses administered to citizens in various countries, this analysis considers their population, types of vaccines/combination vaccines, geographical regions (such as Asia, America, etc.), and income levels (high, middle, etc.).

To accomplish this, I have combined the following three different datasets/data sources into one dataframe:

- World Vaccination Progress (as of February 19) from Kaggle
- Population by Country from Datahub
- Income Levels from the World Bank

Additionally, we will explore more statistical experiments on the data in the dataset as the report progresses.


## Data Visualisation
Using the datasets mentioned above, this section visualizes vaccination progress from several perspectives to uncover more relevant insights.

The following histogram and pie chart show the numbers/percentages of countries using each vaccine combination - similar to the data presented in the last table. Visually, we can see that Pfizer/BioNTech and the combination of Moderna/AstraZeneca/Pfizer/BioNTech are neck-and-neck, and the Oxford/AstraZeneca vaccine is used in many countries as of February 19.

However, when it comes to doses administered to people, the data paints a different picture. This bar chart indicates that the Moderna + Pfizer vaccines are most administered, while the Sinopharm + Sinovac vaccines come in second place. The latter might be surprising because this combination is adopted by only one country in the world, China, and it alone is surpassing the rest of the combinations in the number of doses administered. This highlights the rapid pace of China's vaccination efforts.

The following chronological bar graph shows the global vaccination progress to date.

The progress mentioned above has been driven largely by the USA, China, the UK, India, and Israel, as the data shows.

It is also crucial to consider vaccination progress relative to population size because achieving herd immunity is one of the major goals of these vaccination efforts. The higher the percentage of the population that is immune to the virus in a society, the less widespread the virus will be, broadly speaking.

In this context, smaller countries like Gibraltar, Israel, Seychelles, and the UAE are prominent and outstanding.

I hypothesize that this contrast is rooted in the availability of vaccine production. The larger the population, the more challenging it presumably is to secure vaccines for the entire population.


<div align="center">
<table width="100%">

 <tr>
    <td align = "center" width="(100/x)%">
      <img height="200" align="center" alt="image" src="https://user-images.githubusercontent.com/62607343/130643540-059551ac-4e34-4f4b-b2d3-81c96df30766.png">  
    </td>
    <td align = "center" width="(100/x)%">
      <img height="200" align="center" alt="image" src="https://user-images.githubusercontent.com/62607343/130643658-f6380d88-c0c7-4f6a-a835-12c355122174.png">  
    </td>
    <td align = "center" width="(100/x)%">
      <img height="200" align="center" alt="image" src="https://user-images.githubusercontent.com/62607343/130643658-f6380d88-c0c7-4f6a-a835-12c355122174.png">
    </td>
 </tr>
 <tr>
    <td align = "center" width="(100/x)%">
      <img height="200" align="center" alt="image" src="https://user-images.githubusercontent.com/62607343/130643780-f0fdb967-f97b-4c46-84f4-27d322f1fcd2.png">  
    </td>
    <td align = "center" width="(100/x)%">
      <img height="200" align="center" alt="image" src="https://user-images.githubusercontent.com/62607343/130643992-f5b860ed-5fac-4dae-90cc-c9ee9e196c1b.png">  
    </td>
    <td align = "center" width="(100/x)%">
      <img height="200" align="center" alt="image" src="https://user-images.githubusercontent.com/62607343/130644081-cd6b9aaa-3830-496d-82ad-e4d1ceed28e5.png">
    </td>
 </tr>
 
</table>
</div>



## Random Sampling & Central Limit Theorem
The following histograms demonstrate the Central Limit Theorem using three datasets: Total Vaccinations, Vaccination Progress, and the Population of each country.

They visually prove that as more samples are taken, the standard deviations become narrower, while the mean value remains the same.

<div align="center">
<table width="100%">

 <tr>
    <th>Random Sampling on Total Vaccination</th>
    <th>Random Sampling on Vaccination Progress</th>
    <th>Random Sampling on Population(in 10ks)</th>
 </tr>

 <tr>
    <td align = "center" width="(100/x)%">
      <img align="center" alt="image" src="https://user-images.githubusercontent.com/62607343/130644399-490d340f-c057-4d45-82db-790a2565a5d6.png">
    </td>
    <td align = "center" width="(100/x)%">
      <img align="center" alt="image" src="https://user-images.githubusercontent.com/62607343/130644509-6a138916-5611-4bd3-8fd4-2f0e34d08ba0.png">
    </td>
    <td align = "center" width="(100/x)%">
      <img align="center" alt="image" src="https://user-images.githubusercontent.com/62607343/130644559-6c6ff7b5-7dea-447e-b6ba-f5543e964223.png">
    </td>
 </tr>
 
</table>
</div>





### Sampling methods
In this section, we will execute four sampling methods: Simple Random Sampling with replacement, Systematic Sampling, Stratified Sampling with replacement, and Cluster Sampling. We will then compare the resulting distributions with the original histogram.

From this analysis, we can infer that even if these samples were used instead of the entire dataset, the mean of the samples would have remained consistent, while the standard deviation would have been narrower compared to that of the entire original dataset.

<div align="center">
  <img height="300" align="center" alt="image" src="https://user-images.githubusercontent.com/62607343/130644689-3221762b-63ff-4ade-be49-e67416078332.png">
</div>

### Bootstrap estimate of the bias
Lastly, I conducted an analysis of the bootstrap estimate of the bias.

As the sample size increased, the bias decreased, while the standard deviation remained within a relatively similar range.

<div align="center">
  <img height="300" align="center" alt="image" src="https://user-images.githubusercontent.com/62607343/130644735-4fddef7a-2ec6-4483-aef6-b3659e7ca711.png">
</div>
