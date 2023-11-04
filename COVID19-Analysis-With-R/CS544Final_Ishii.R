#Final Project

'Preparing the data
Import the data set into R.
Document the steps for the import process and any preprocessing had to be done prior to or after the import. 
Any R code used in the processshould be included.
'

install.packages("scales")
install.packages("sampling")
install.packages("cluster")
install.packages("zoo")
install.packages("plotly")

library(scales)
library(sampling)
library(cluster)
library(zoo)
library(boot)
library(plotly)

set.seed(44)

'	 Import Dataset of Covid-19 Vaccination Process ###
	https://www.kaggle.com/gpreda/covid-world-vaccination-progress
'
	df <- read.csv("F:\\Boston\\R\\FinalProject\\country_vaccinations.csv")
	head(df,10)
	df_clean<-df 
	df_clean[is.na(df)]<-0

#		 Clean Data
  	#Eliminate 0 data in Total columns
		for(i in 2:length(df_clean[,1])){
			if(df_clean$total_vaccinations[i]==0 && df_clean$country[i]==df_clean$country[i-1]) df_clean$total_vaccinations[i]<-df_clean$total_vaccinations[i-1]
		}

		df_clean$progress[1]<-0
		head(df_clean)

 	 #Create a progress column in df
		for(i in 2:length(df_clean[,1])){
			if(df_clean$country[i]==df_clean$country[i-1]) df_clean$progress[i]<-df_clean$total_vaccinations[i]-df_clean$total_vaccinations[i-1]
		}


#		Create a new df 

	#Country-wise chronological df(vaccination progress for all countries from date 2020-12-13)
		df_countrywise<-data.frame(date=seq(as.Date(min(df$date)), as.Date(max(df$date)), by="day"))
 		con<-names(table(df_clean[,1]))
		df_countrywise[con]<-0
		rownames(df_countrywise)<-df_countrywise[,1]
		df_countrywise<-df_countrywise[,-1]
		head(df_countrywise)

		#add data
			for(i in 1:length(df_clean[,1])){
				df_countrywise[df_clean[i,3],df_clean[i,1]]<-df_clean[i,4]
			}
			head(df_countrywise)
			tail(df_countrywise)

		#If 0, replace with a previous value
			df_countrywise[df_countrywise==0]<-NA
			df_countrywise        <- na.locf(df_countrywise,na.rm=FALSE)
			df_countrywise[is.na(df_countrywise)]<-0
			head(df_countrywise)
			tail(df_countrywise)

		#Total Vaccination/combined sum of all the countries
			df_countrywise$TTL<-rowSums(df_countrywise)
			head(df_countrywise)
			tail(df_countrywise)

#	 Country-wise latest data frame(vaccination progress as of xx/xx)
	
		latest<-max(df$date)
		df_latest<-df_countrywise[latest,]
		df_latest<-data.frame(t(df_latest))
		colnames(df_latest)<-"TTL_Vaccinated"
		head(df_latest)

		#Plug in Income Level indicator	
			#https://datahelpdesk.worldbank.org/knowledgebase/articles/906519-world-bank-country-and-lending-groups
			class <- read.csv("F:\\Boston\\R\\FinalProject\\country_classification.csv")
			df_latest$class<-with(class, Income.group[match(rownames(df_latest), Economy)])
			df_latest<-df_latest[!is.na(df_latest$class),]
			head(df_latest)

		#Plug in populations
#			https://datahub.io/JohnSnowLabs/population-figures-by-country#data
			population<-read.csv("F:\\Boston\\R\\FinalProject\\population.csv")
			head(population)
			population<-population[,c(colnames(population)[1],"X2019")]
			head(population)
			colnames(population)<-c("country","X2019")
			head(population)		
			df_latest$population<-with(population, X2019[match(rownames(df_latest), country)])

		#Plug in vaccine types
			df_latest$vaccine<-with(df, vaccines[match(rownames(df_latest), country)])
	
		#Vaccination Progress by Ratio against population
			df_latest$progress<-round(df_latest$TTL_Vaccinated/df_latest$population,8)

		#Plug in Region
			df_latest$region<-with(class, Region[match(rownames(df_latest), Economy)])

		#Check NA Values
			df_latest[is.na(df_latest)]


###					Analyzing the data

# Do the analysis as in Module3 for at least one categorical/Qualitative variable and at least one
#	numerical/Quantitative variable. Show appropriate plots for your data.


#				Categorical/Qualitative : Vaccine Combination

	# Data Demography


	table(df_latest$region)
	table(df_latest$class)
	table(df_latest$vaccine)

   	# Histogram - How many countries use which vaccines/combination
		par(mar=c(5,22,3,3))
		x<-table(df_latest$vaccine)
		x<-x[order(x,decreasing=TRUE)]
		k<-data.frame(x)
		colnames(k)<-c('Vaccine', 'Freq')
 		plot_ly(k, x=~Vaccine, y=~Freq, name= ~Vaccine, type="bar")

		
	#Pie chart with labels
		par(mar=c(5,22,5,3))
		plot_ly(k, labels=~Vaccine, values=~Freq, type="pie")

####  			Numerical/Quantitative : Vaccination Progress

	# Vaccination progress by vaccine types
		y<-xtabs(TTL_Vaccinated~vaccine, df_latest)
   		y<-y[order(y,decreasing=TRUE)]
		j<-data.frame(y)
		colnames(j)<-c("Vaccine", "doses")
		plot_ly(j, x=~Vaccine, y=~doses, name= ~Vaccine, type="bar")  %>% layout(showlegend = FALSE)

	# Vaccination progress by date

		plot_ly(x=rownames(df_countrywise), y=df_countrywise$TTL/1000, type="bar")

	# Vaccination progress by country
			z<-df_latest
			z<-z[order(z$TTL_Vaccinated,decreasing=TRUE),]

			plot_ly(z, x=reorder(rownames(z),z$TTL_Vaccinated), y=~TTL_Vaccinated/1000, type="bar")%>% layout(font=list(size=10))

	# Vaccination progress as ratio to its population by country		
			x<-df_latest[order(df_latest$progress,decreasing=TRUE),]
			plot_ly(x, x=reorder(rownames(x),x$progress), y=~progress, type="bar")%>% layout(font=list(size=10))


	# boxplot - Vaccination progress as ratio to its population by country
			par(mfrow=c(1,1))
			boxplot(df_latest$progress, col=hcl(0), main="Vaccination Progress against Population", horizontal=TRUE)
			text(df_latest$progress[df_latest$progress>fivenum(df_latest$progress)[4]], 
				rep(1.2,5), srt=90, adj=0, 
				labels=rownames(df_latest[df_latest$progress>fivenum(df_latest$progress)[4],]), cex=0.9)
		
# Do the analysis as in Module3 for at least one set of two or more variables. Show appropriate plots for your data.

	# Population vs progress

		plot(df_latest$population/10000, df_latest$progress, xlim=c(1, max(df_latest$population)*1.1/10000),
			main="Plot of population vs Vaccination Progress", xlab="population in thousands", ylab="Progress(vaccination/Capita)")	
		text(df_latest$population/10000+15000, df_latest$progress, labels=rownames(df_latest), cex=0.75, font=1)

# Draw various random samples of the data and show the applicability of the Central Limit Theorem for this variable

	# TTL Vaccination
		samples<-10000
		x<-df_latest$TTL_Vaccinated/1000; mu<-mean(df_latest$TTL_Vaccinated/1000); std<-sd(df_latest$TTL_Vaccinated/1000)
		sample.size<-c(5,25,125,625)
		h<-numeric()
		for(i in 1:length(sample.size)){
			par(mar=c(2,2,2,2))
			xbar<-numeric(samples)
			xsd<-numeric(samples)
			for(k in 1:samples){
				xbar[k]<-mean(sample(x, size=sample.size[i], replace=TRUE))
			}
			h[i]<-plot_ly(x=xbar, type="histogram", name=paste("sample size=", sample.size[i]))
		}
		subplot(h, nrows=2)


	# Vaccination Progress
		samples<-10000
		x<-df_latest$progress; mu<-mean(df_latest$progress); std<-sd(df_latest$progress)
		sample.size<-c(5,25,125,625)
		h<-numeric()
		for(i in 1:length(sample.size)){
			par(mar=c(2,2,2,2))
			xbar<-numeric(samples)
			xsd<-numeric(samples)
			for(k in 1:samples){
				xbar[k]<-mean(sample(x, size=sample.size[i], replace=TRUE))
			}
			h[i]<-plot_ly(x=xbar, type="histogram", name=paste("sample size=", sample.size[i]))
		}
		subplot(h, nrows=2)

	# Population
		samples<-10000
		x<-df_latest$population/10000; mu<-mean(df_latest$population/10000); std<-sd(df_latest$population/10000); xl<-max(x)
		sample.size<-c(5,25,125,625)
		h<-numeric()
		for(i in 1:length(sample.size)){
			par(mar=c(2,2,2,2))
			xbar<-numeric(samples)
			xsd<-numeric(samples)
			for(k in 1:samples){
				xbar[k]<-mean(sample(x, size=sample.size[i], replace=TRUE))
			}
			h[i]<-plot_ly(x=xbar, type="histogram", name=paste("sample size=", sample.size[i]))
		}
		subplot(h, nrows=2)

# Show how various sampling methods can be used on your data. 
# What are your conclusions if these samples are used instead of the whole dataset.

		par(mfrow=c(2,3))
		br<-seq(0,1,0.2)
		h<-""
		h[1]<-plot_ly(x=df_latest$progress, type="histogram", name="Original")

## 		Simple Random Sampling WITH replacement
		s<-srswr(50, nrow(df_latest))
		s[s!=0]
	      rows<-(1:nrow(df_latest))[s!=0]
	      rows<-rep(rows, s[s!=0])
    		# The data of selected samples and frequencies
		h[2]<-plot_ly(x=df_latest[rows, ]$progress, type="histogram", name="Simple Random Sampling")


##		Systematic Sampling
	   pik<-inclusionprobabilities(df_latest$progress, 70)
	   length(pik)
	   sum(pik)

	  #"UPsystematic" uses systematic method with unequal probabilities
 	    s<-UPsystematic(pik)
	    obj.2<-df_latest[s!=0,]
	    h[3]<-plot_ly(x=obj.2$progress, type="histogram", name="Systematic Sampling")



##		Stratified Sampling WITH replacement
	    #sample size of 3 from each section is sampled without replacement with "strata" function:

		order.index<-order(df_latest$class)
		data<-df_latest[order.index,]

	 	freq<-table(data$class)
		st.sizes<-20*freq/sum(freq)
 	      st1<-strata(data, stratanames="class", size=st.sizes, method="srswor", description=TRUE)
		st.sample1<-getdata(data, st1)
    h[4]<-plot_ly(x=st.sample1$progress, type="histogram", name="Stratified Sampling")


##		Cluster Sampling
		order.index<-order(df_latest$class)
		data<-df_latest[order.index,]
		cl<-cluster(data, c("class"), size=2, method="srswor")
		cl.sample1<-getdata(df_latest, cl)
	  h[5]<-plot_ly(x=cl.sample1$progress, type="histogram", name="Clustered Sampling")

		subplot(h, nrows=2)

# Implementation of any feature(s) not mentioned in the above specification

###bootstrap estimate of the bias
	
	samplemedian<-function(x, indices){
			return (median(x[indices]))
			}

	boot_model<-function(data, R){
			b<-boot(data=data, statistic=samplemedian, R=R)
			resample.A<-replicate(R, sample(data, replace=TRUE), simplify=FALSE)
			medians.star<-sapply(resample.A, median, simplify=TRUE)
			h<-hist(medians.star, col="cyan", prob=FALSE, main=paste("Histogram of Sample size ",R), xlab="sample median")
			h
			text(median(df_latest$progress)*1.1,max(h$counts)*1.01,col="red","Original Median", lwd=3, lty=2)
			abline(v=median(df_latest$progress), col="red", lwd=3, lty=2)
			text(median(df_latest$progress)*0.80,max(h$counts),col="black",
				paste("bias: ",round(mean(b$t)-b$t0, digits=5),"std: ", round(sd(medians.star),digits=5)), lwd=3, lty=2)
	}
	par(mfrow=c(1,3))
	boot_model(df_latest$progress, 10)
	boot_model(df_latest$progress, 100)
	boot_model(df_latest$progress, 1000)

