
ny = read.csv('new_york_city.csv')
wash = read.csv('washington.csv')
chi = read.csv('chicago.csv')

head(ny)

head(wash) # washington lack data on gender

head(chi)

library(dplyr)

library (ggplot2)

library(lubridate)

#computing the average trip duration according to gender

chi%>% 
  group_by(Gender)%>%
  summarise_at(vars(Trip.Duration),
              list (average=mean))

# Plotting trip duration by Gender in Chicago using a boxplot. **The average trip duration was represented by the blue points on the graph.** 

plot1<-ggplot(chi,aes(x=Gender, y=Trip.Duration))
       plot1 + 
           geom_boxplot()+
           scale_y_continuous(name="Trip duration", 
                              breaks= seq(0,4000,500), 
                              limit= c(0,4000)) +
           ggtitle("Boxplot of the trip duration by gender in Chicago with the mean values")+
           stat_summary(fun.y=mean,
                       geom="point",
                       size=3,
                       color="steelblue")+
                   theme_classic()

# Adding new column "month" to Chicago data. 

chi$month<-month(chi$Start.Time)

head(chi)

# Counts of rides per month

chi%>%
count(month, sort = TRUE)

ggplot(chi, aes(x=month))+
geom_bar()+
labs(title="Numers of Rides by month",x="Months",y="Number of rides")

max(chi$Trip.Duration)
min(chi$Trip.Duration)
mean(chi$Trip.Duration)
sd(chi$Trip.Duration)

#Plotting trip duration distribution 

ggplot(chi,aes(x=Trip.Duration)) + 
   geom_histogram(binwidth=300,color="blue")+
   coord_cartesian(xlim=c(60,5000))+
   ylab("Number of riders")+
   ggtitle("Histogram of the distribution of trip duration in Chicago")

system('python -m nbconvert Explore_bikeshare_data.ipynb')
