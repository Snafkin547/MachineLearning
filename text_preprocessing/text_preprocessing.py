import nltk
nltk.download('stopwords')
nltk.download('wordnet')
from nltk.stem import WordNetLemmatizer
from nltk.corpus import wordnet
import re
from nltk.corpus import stopwords


def lowerCase(input,col):
  input[col]=input[col].str.lower()

def clean_df(input, col):
  input[col].dropna(axis=0, inplace=True)
  lowerCase(input, col)

def listToString(slist): 
    new_str=""
    for word in slist:
        new_str+=word+" "    
    if not len(new_str)==0:
      return new_str.rstrip(new_str[-1])
    else:    
      return new_str

def lemmatize_words(words):
    lemmatize_words = [WordNetLemmatizer().lemmatize(word, 'v') for word in words]
    return lemmatize_words

def remove_stop_words(string):
  lemma_english_stopwords = lemmatize_words(stopwords.words('english'))
  new_str=""
  for word in string.split():
      if word not in lemma_english_stopwords:
        new_str+=word+" "    

  if not len(new_str)==0:
    return new_str.rstrip(new_str[-1])
  else:    
    return new_str

def preprocess(input, col):
  clean_df(input, col)
  word_pattern = re.compile('\w+')
  new_title=str(col+"_Regex")
  print(new_title)
  input[new_title]=list(map(lambda t : listToString(word_pattern.findall(str(t))), input[col]))
  no_stop=col+str("_no_stopwords")
  input[no_stop]=list(map(lambda x: remove_stop_words(x), input[new_title]))
  lemmatize=col+str("_lemmatized")
  input[lemmatize]=list(map(lambda t : lemmatize_words(word_pattern.findall(t)), input[no_stop]))
  return input