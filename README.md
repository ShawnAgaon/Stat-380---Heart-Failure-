# STAT 380 Final Project: Predicting Heart Disease

**Team:** Tim Smith, Shawn Agaon, Ethan Agaon, Aidan Murphy

We test whether statistical learning models can predict heart disease
significantly better than a baseline, using the
[Heart Failure Prediction dataset](https://www.kaggle.com/datasets/fedesoriano/heart-failure-prediction)
(918 patients, 11 predictors).

## Files

| File | What it is |
|---|---|
| `Stat380HeartFailure.Rmd` | Main report file. **Knit this one** to build the full PDF. |
| `sections/` | One `.Rmd` file per report section (see below) |
| `Stat380HeartFailure.pdf` | Knitted report |
| `heart.csv` | The dataset |
| `heart_disease_model_pipeline.R` | Early draft script (uses the same data preparation as the report) |

## How to work on your section

1. Edit **only your own file** in `sections/`. Uploading a file on GitHub replaces
   it completely, so editing someone else's file can erase their work.
2. Give every code chunk a unique name that starts with your section's prefix
   (for example `logit-fit`, `tree-prune`, `pca-scree`). Two chunks with the same
   name in different files will stop the knit.
3. Use the `train` and `test` objects from `02_data_prep.Rmd`. Don't re-clean or
   re-split the data.
4. To test your work, knit `Stat380HeartFailure.Rmd`. Knitting a section file on
   its own will fail because it needs the data from Data Preparation.
5. Upload your section file to the `sections` folder on GitHub (open the folder,
   then **Add file → Upload files**).

## Report status

| Section | File | Status |
|---|---|---|
| Introduction | `01_introduction.Rmd` | To do |
| Data Preparation | `02_data_prep.Rmd` | Done |
| Exploratory Data Analysis | `03_eda.Rmd` | Done |
| Logistic Regression | `04_logistic.Rmd` | In progress |
| Decision Tree | `05_tree.Rmd` | To do |
| Support Vector Machine | `06_svm.Rmd` | Done |
| PCA | `07_pca.Rmd` | In progress |
| Comparing Results | `08_comparison.Rmd` | To do |
| Conclusion | `09_conclusion.Rmd` | To do |

## Shared setup (use this for every model)

- Cholesterol and RestingBP values of 0 are treated as missing and filled with
  the **training-set** median. A `chol_missing` indicator is kept as a predictor.
- Stratified 80/20 train/test split with `set.seed(380)`.
- Every model uses the `train` and `test` objects from the Data Preparation
  section, so the results are directly comparable.

## How to run

Install the packages once:

```r
install.packages(c("ggplot2", "tidyr", "dplyr", "e1071", "caret", "pROC",
                   "rpart", "rpart.plot"))
```

Then open `Stat380HeartFailure.Rproj` in RStudio and knit
`Stat380HeartFailure.Rmd` (the main file, not a section file). The data loads straight from this repo, so an
internet connection is needed.
