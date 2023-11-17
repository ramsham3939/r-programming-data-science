# Install and load the necessary libraries
install.packages("httr")
library(httr)

# OpenWeatherMap API key (replace 'your_api_key' with your actual API key)
api_key <- "3a7991345218aa23c7ea9cc8f02d9a9a"

# Function to get current weather information using the OpenWeatherMap API
get_weather <- function(city, api_key) {
  base_url <- "http://api.openweathermap.org/data/2.5/weather"
  
  # Construct the API request URL
  request_url <- paste0(base_url, "?q=", city, "&appid=", api_key)
  
  # Make the API request
  response <- GET(request_url)
  
  # Check if the request was successful (status code 200)
  if (http_status(response)$category == "Success") {
    # Parse the JSON response
    weather_data <- content(response, "parsed")
    
    # Extract relevant information
    temperature <- weather_data$main$temp
    humidity <- weather_data$main$humidity
    description <- weather_data$weather[[1]]$description
    
    # Print the weather information
    cat("Current weather in", city, ":\n")
    cat("Temperature:", temperature, "K\n")
    cat("Humidity:", humidity, "%\n")
    cat("Description:", description, "\n")
  } else {
    cat("Error:", http_status(response)$reason, "\n")
  }
}

# Example: Get weather for a specific city (e.g., New York)
get_weather("New York", api_key)
