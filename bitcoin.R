library(data.table)
library(ggplot2)
file_path <- file.path("~/Downloads", "BTC.txt")
data <- fread(file_path)

# Convert Date to proper Date format
data$Date <- as.Date(data$Date, format = "%b %d, %Y")

# Sort the data by date
data <- data[order(data$Date), ]

# Create a new feature 'Days_Since_Start' to represent the number of days since the start of the dataset
data$Days_Since_Start <- as.numeric(data$Date - min(data$Date))

# Convert character columns to numeric
cols_to_convert <- c("Open", "High", "Low", "Close", "Adj Close", "Volume")
for (col in cols_to_convert) {
  data[[col]] <- as.numeric(gsub(",", "", data[[col]]))
}

# Split the data into train and test sets
set.seed(42)
train_index <- sample(1:nrow(data), 0.8 * nrow(data))
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Train a linear regression model
model <- lm(Close ~ Days_Since_Start, data = train_data)

# Make predictions
train_data$Predicted <- predict(model, newdata = train_data)
test_data$Predicted <- predict(model, newdata = test_data)

# Evaluate the model
train_rmse <- sqrt(mean((train_data$Close - train_data$Predicted)^2))
test_rmse <- sqrt(mean((test_data$Close - test_data$Predicted)^2))
print(paste("Train RMSE:", train_rmse))
print(paste("Test RMSE:", test_rmse))

# Plot the results
ggplot(data) +
  geom_line(aes(x = Date, y = Close, color = "Actual Price")) +
  geom_line(data = rbind(train_data, test_data), aes(x = Date, y = Predicted, color = "Predicted Price"), linetype = "dashed") +
  labs(x = "Date", y = "Bitcoin Price", title = "Bitcoin Price Prediction") +
  scale_color_manual(values = c("Actual Price" = "blue", "Predicted Price" = "red")) +
  theme_minimal()

# Calculate the number of days since the start of the dataset for May 15th
may_15_date <- as.Date("2024-05-15")
days_since_start_may_15 <- as.numeric(may_15_date - min(data$Date))

# Predict the Bitcoin price on May 15th
predicted_price_may_15 <- predict(model, newdata = data.frame(Days_Since_Start = days_since_start_may_15))

print(paste("Predicted Bitcoin price on May 15th, 2024:", predicted_price_may_15))
