# text_preprocessing
Text Pre-processing tools

# Setup
## Clone this repo
git clone https://github.com/Snafkin547/text_preprocessing.git

## Install Dependencies and Import method
from text_preprocessing import text_preprocessing

## How to Use
Search with Year as the second Parameter (This way you can get 30 titles for each year)

### Input
input: dataframe
col: target col name
```
df = text_preprocessing.preprocess(input, col)
```

### Output
original columns, target column with only reular expression, without stop words, lemmatized target column


## Example
```
df = text_preprocessing.preprocess(df, "tagline")
df.head()
```
![image](https://user-images.githubusercontent.com/62607343/165346026-31121c44-aee1-4be9-8284-afe1e65325fb.png)
