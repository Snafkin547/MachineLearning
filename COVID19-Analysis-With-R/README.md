# COVID19-Analysis

### Project Overview
This project aims to visualize the progress of vaccinations against notoriously prevailing COVID-19.

Instead of showing just pure numbers of doses given to citizens in those countries, this analysis factors in their population, vaccination/combination types, geographical regions (Asia/America etc.), and income levels (High/middle etc.).

To do so, I combined the following three different datasets/data-sources into a dataframe:

World Vaccination Progress (As of 19 Feb) from Kaggle
Population-by-Country from Datahub
Income Level from World Bank
In addition, we will see more statistical experiments on data in the dataset, as the report progress toward the end of the report.

### Data Profile
In this analysis, we will look into vaccination progress of 86 countries of countries from 7 regions
![image](https://user-images.githubusercontent.com/62607343/130643226-5044be55-9315-465b-9343-28cb4d101323.png)


Amongst those who started vaccinating, there are three groups of income level; High income, Upper middle income, and Lower middle income. This also shows that countries of low income profile have not been able to start vaccinating yet.

![image](https://user-images.githubusercontent.com/62607343/130643319-5a092edc-8b2d-4398-aa2b-c6bad0bc8450.png)

Following table demonstrates the number of countries that adopted each vaccine combination. Each country chose their own combination of vacine types - Some chose just one type; others chose even 5 different types. The most popular combination is Pfizer/BioNTech, followed by the combination of Moderna, Oxford/AstraZeneca, Pfizer/BioNTech just by 1 country.

![image](https://user-images.githubusercontent.com/62607343/130643405-cae4ecec-6b75-40bf-b842-ff98e27bacd5.png)

### Data Visualisation
Using the above mentioned datasets, this section will visualize vaccination progresses from several angles to find out more relevant facts.

The following histogram and pie chart are to show the numbers/% of countries using each of those vaccine combinations - same as the last table. It visually shows that Pfizer/BioNTech and Moderna/AstraZeneca/Pfizer/BioNTech are neck-to-neck and Oxfort/Astra Zeneca vaccine is used in many countries, as of 19 Feb.

![image](https://user-images.githubusercontent.com/62607343/130643540-059551ac-4e34-4f4b-b2d3-81c96df30766.png)
![image](https://user-images.githubusercontent.com/62607343/130643658-f6380d88-c0c7-4f6a-a835-12c355122174.png)

In terms of the doses provided to people, on the other hand, the data shows a different landscape. In this bar chart, you can see that Moderna + Pfizer vaccines are given to people most, and Sinopharm + Sinovac vaccines came in the second place. The latter combination must surprise you because this combination is adopted only by 1 country in the world, China, and it, standalone is beating the rest of the combinations in the numbers of doses given. This appears to me how fast China's action toward vaccinations has been so far.

![image](https://user-images.githubusercontent.com/62607343/130643780-f0fdb967-f97b-4c46-84f4-27d322f1fcd2.png)


The following chronological bar graph shows the global vaccination progress so far.

![image](https://user-images.githubusercontent.com/62607343/130643992-f5b860ed-5fac-4dae-90cc-c9ee9e196c1b.png)


The above-mentioned progress has been driven largely by USA, China, UK, India, and Israel, as the data shows.

It is also crucial to be mindful of vaccination progress in a ratio to population size, because obtainment of social immunity is one of major reasons of this human effort to vaccinate their citizens. The more people get immunity against the virus in a society, the less would the virus spread be, broadly speaking.

In this context, those small countries like Gibraltar, Israel, Seychelles, and UAE, are prominent and outstanding.

I hypothesized that this contrast rooted in the shortage of vaccine productions/availabilities. The bigger the population is, the more difficult presumably would the security of vaccines for their entire population.

![image](https://user-images.githubusercontent.com/62607343/130644081-cd6b9aaa-3830-496d-82ad-e4d1ceed28e5.png)

![image](https://user-images.githubusercontent.com/62607343/130644145-d382b2a6-98b8-4e20-b6bc-adae238fb45e.png)

![image](https://user-images.githubusercontent.com/62607343/130644289-14500871-38a3-42ba-94dd-d6f09e3e9e8d.png)

### Random Sampling & Central Limit Theorem
The following histograms are to demonstrate the Central Limit Theorem, using three datasets; Total Vaccination, Vaccination Progress, and Population of each countries.

It visually proves that the more samples are taken, the narrower would the standard deviations be, whilst mean value stay the same.

#### Random Sampling on Total Vaccination
![image](https://user-images.githubusercontent.com/62607343/130644399-490d340f-c057-4d45-82db-790a2565a5d6.png)

#### Random Sampling on Vaccination Progress
![image](https://user-images.githubusercontent.com/62607343/130644509-6a138916-5611-4bd3-8fd4-2f0e34d08ba0.png)

#### Random Sampling on Population(in 10ks)
![image](https://user-images.githubusercontent.com/62607343/130644559-6c6ff7b5-7dea-447e-b6ba-f5543e964223.png)

### Sampling methods
In this section, we will run four sampling methods, Simple Random Sampling WITH replacement, Systematic Sampling, Stratified Sampling WITH replacement, and Cluster Sampling, and compare the distributions with original histogram.

We can infer from this analysis that, even if these samples were used, instead of the whole dataset, the average of samples would have stayed the same, whereas the standard deviation would have been narrower than the whole original dataset.
![image](https://user-images.githubusercontent.com/62607343/130644689-3221762b-63ff-4ade-be49-e67416078332.png)

### Bootstrap estimate of the bias
Lastly, I ran analysis of Bootstrap estimate of the bias.

As the sample size grew, bias decreased, whereas standard deviation stayed in a relatively same range.

![image](https://user-images.githubusercontent.com/62607343/130644735-4fddef7a-2ec6-4483-aef6-b3659e7ca711.png)





