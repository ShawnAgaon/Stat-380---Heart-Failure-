# 1. Load Packages and Dataset


library(rpart)  # Decision tree
library(e1071)  # Support Vector Machine

# Load the dataset
heart <- read.csv("https://raw.githubusercontent.com/ShawnAgaon/Stat-380---Heart-Failure-/main/heart.csv")


# 2. Data Preprocessing


# Cholesterol = 0 and RestingBP = 0 are impossible -> treat as missing
# (same cleaning as the Data Preparation section of Stat380HeartFailure.Rmd)
heart$chol_missing <- as.integer(heart$Cholesterol == 0)
heart$Cholesterol[heart$Cholesterol == 0] <- NA
heart$RestingBP[heart$RestingBP == 0] <- NA

# Convert categorical predictors to factors
heart$Sex <- as.factor(heart$Sex)
heart$ChestPainType <- as.factor(heart$ChestPainType)
heart$RestingECG <- as.factor(heart$RestingECG)
heart$ExerciseAngina <- as.factor(heart$ExerciseAngina)
heart$ST_Slope <- as.factor(heart$ST_Slope)

# Convert FastingBS to a factor (binary category)
heart$FastingBS <- as.factor(heart$FastingBS)

# Keep HeartDisease as numeric (0 or 1)
# 0 = No heart disease
# 1 = Heart disease


# 3. Training and Testing Split


set.seed(380)

# Use 80% for training and 20% for testing
# Stratifed sampling to preserve the proportions of 0s and 1s

no_disease <- which(heart$HeartDisease == 0)
disease <- which(heart$HeartDisease == 1)

train_0 <- sample(no_disease, size = round(0.8 * length(no_disease)))
train_1 <- sample(disease, size = round(0.8 * length(disease)))

# Combine training row indices
train_indices <- c(train_0, train_1)

# Create training and testing datasets
train <- heart[train_indices, ]
test <- heart[-train_indices, ]

# Impute missing values with TRAINING medians only
chol_med <- median(train$Cholesterol, na.rm = TRUE)
bp_med <- median(train$RestingBP, na.rm = TRUE)
train$Cholesterol[is.na(train$Cholesterol)] <- chol_med
test$Cholesterol[is.na(test$Cholesterol)] <- chol_med
train$RestingBP[is.na(train$RestingBP)] <- bp_med
test$RestingBP[is.na(test$RestingBP)] <- bp_med


# 4. Logistic Regression


# Fit logistic regression using all predictors
log_model <- glm(
  HeartDisease ~ .,
  data = train,
  family = binomial
)


# 5. Decision Tree


# Classification trees require factor response
train_tree <- train
train_tree$HeartDisease <- as.factor(train_tree$HeartDisease)

# Fit decision tree using all predictors
tree_model <- rpart(
  HeartDisease ~ .,
  data = train_tree,
  method = "class"
)


# 6. Support Vector Machine (SVM)


# SVM classification requires factor response
train_svm <- train
train_svm$HeartDisease <- as.factor(train_svm$HeartDisease)

# Fit SVM using a radial kernel
svm_model <- svm(
  HeartDisease ~ .,
  data = train_svm,
  kernel = "radial",
  scale = TRUE
)
