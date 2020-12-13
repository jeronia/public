stw(C://)

nei <- readRDS('summarySCC_PM25.rds')
scc <- readRDS8('Source_Classification_Code.rds')

cnames <- readLines('', 1)
cnames <- strsplit(cnames, '|', fixed=TRUE)

names() <- make.names(cnames[[1]])

dates <- pm1$Date ##change pm1 for data
dates <- as.Date(as.character(dates), '%Y%m%d'

#deal with NAs

#Plot 1


#Mean by state
mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm = TRUE)
d1 <- data.frame(state = names(mn1), mean =mn1)
d <- merge(d0, d1, by='state')

with(mrg, plot(rep(1999, 52), mrg[,2], xlim =(1998, 2013))
with(mrg, plot(rep(2012, 52), mrg[,3], xlim =(1998, 2013))
with(mrg, points(rep(2012, 52), mrg[,3]))
segments(rep(1999, 52), mrg[,2], rep(2012, 52), mrg[,3])


#Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using base plotting system, make a plot showing total PM2.5  emissions from all sources for each of the years 1999, 2002, 2005 and 2008.

a <- with(data, tapply(emissions, year, sum, na.rm = TRUE)
with(a, plot(year, sum xlim =(1998, 2009))

#Q2: Have total emissions from PM2.5 decreased in the Baltimore City (fips=='24510') from 1999 to 2008?
Use base plotting  system to make a plot answering this question

b <- data[a$flips=='24510',]
b <- with(b, tapply(emissions, year, sum, na.rm = TRUE)
with(b, plot(year, sum xlim =(1998, 2009))

#Q3: Which type of source  have seen decreases in emissions from 1999-2008? Use ggplot2 plotting system to make a plot answering this question

c <- with(data, tapply(emissions, year & type, sum, na.rm = TRUE)

library(dplyr)
data %<%
  ggplot(aes(y=year,x=source, fill=emissions) +
  geom_bar()
  )

#Q4: Across the United States, how have emissions from coal combustion-related sources changed from1999-2008?

#Q5: How have emissions from motor vehicles sources changed from 1999-2008 in baltimore city?

#Q6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicles sources in los angeles county (fips== '06037'). Which city has seen greater changes over time in motor vehicle emissions?
