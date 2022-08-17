# AcademictwitteR Example
# Brian Boyle
# 2022-08-17

# Packages
library(academictwitteR)


## Twitter Academic Track API
# https://developer.twitter.com/en/products/twitter-api/academic-research

## academictwitteR user guide
# https://cran.r-project.org/web/packages/academictwitteR/vignettes/academictwitteR-intro.html

## academictwitteR package documentation
# https://cran.r-project.org/web/packages/academictwitteR/academictwitteR.pdf




# 00 API set up -----------------------------------------------------------

# Set bearer token
bearer_token <- get_bearer()
# See user guide for full outline of creating and setting bearer tokens



# 01 Scrape tweets ---------------------------------------------------

# Search for tweets containing specific query terms, within a certain timeframe
# Hashtags, key words etc

tweets_01 <- 
get_all_tweets(query = c('rstudio', 'rmarkdown'), # search terms
               n = Inf,              # max number of tweets to return
               file = "tweets_01.R",    # can set filepath to save output
               start_tweets = "2020-01-01T00:00:00Z", # start and end date-times
               end_tweets   = "2020-01-02T00:00:00Z",
               bearer_token = bearer_token) # bearer authorisation token

# We can also collect tweets from specific users
# Can use twitter usernames (don't need to include the @)
# Or use the unique twitter IDs ('235261861' for rstudio)

tweets_02 <- 
get_all_tweets(user = 'rstudio', # return tweets from this specific user
               n = Inf,
               file = "tweets_02.R",
               start_tweets = "2020-01-01T00:00:00Z",
               end_tweets   = "2020-01-05T00:00:00Z",
               bearer_token = bearer_token)




# 02 Using loops to scrape tweets -----------------------------------------

# We can also use loops to collect tweets over longer periods of time.
# If we want to scrape tweets for the first week of July 2022, 
# we can run searches 1 day at a time, and export the output in daily intervals.
# We can extend this to getting tweets over multi-year time periods.

# Set up the search terms we want to query
query <- c('#rstudio')

# We could also specify certain accounts we want to focus on
# Vector of twitter usernames
# users <- c('rstudio', 'hadleywickham')
  
  

# We can now specify what time period we are interested in

# Days we want to collect tweets from
days <- seq(as.Date("2022-07-01"), as.Date("2022-07-07"), by="days")

# Paste the days we want with the relevant time information
# 00:00:00 = hours:minutes:seconds
# This would set as midnight for each day as the start point
start_days <- paste0(days, 'T00:00:00Z')
end_days   <- paste0(days + 1, 'T00:00:00Z')
  


# We can also specify the filepaths for where we want each days tweets to be saved
filepaths <- paste0('./', days, '_tweets.R')

# We can create an empty list to save the output to
tweets <- list()
# If you don't assign it to an object, it will still save the data in your chosen filepath.

# Loop through each day
for(i in 1:length(start_days)){
tweets[[i]] <- get_all_tweets(query = query,
                              n = Inf,             
                              file = filepaths[i],   
                              start_tweets = start_days[i], 
                              end_tweets   = end_days[i],
                              bearer_token = bearer_token)
# We can print out the current day as a debug feature in case anything goes wrong
    print(paste0('[', i, ']', start_days[i]))
}



# 03 Output ---------------------------------------------------------------

# We can view the tweets firectly from the list
View(tweets[[1]])

# Or import the data
tweets_df <- readRDS('./2022-07-01_tweets.R')
View(tweets_df)

