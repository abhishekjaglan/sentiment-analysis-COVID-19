getwd()
readLines("corona india.txt")
str(readLines("corona india.txt"))
corona_ind <- paste(readLines("corona india.txt"), collapse = " ")
readLines("corona usa.txt")
corona_usa <- paste(readLines("corona usa.txt"), collapse = " ")
readLines("corona italy.txt")
corona_italy <- paste(readLines("corona italy.txt"), collapse = " ")
readLines("corona spain.txt")
corona_spain <- paste(readLines("corona spain.txt"), collapse = " ")
readLines("corona uk.txt")
corona_uk <- paste(readLines("corona uk.txt"), collapse = " ")
country <- c(corona_ind, corona_italy,corona_spain,corona_uk,corona_usa)
country[1]
str(country)
country
install.packages('tm')
install.packages("stringr")
library(tm)
library(stringr)
country2 <- gsub(pattern = "\\W", replacement = " ",country)
country3 <- gsub(pattern = "\\d", replacement = " ",country2)
country4 <- tolower(country3)
country5 <- removeWords(country4,stopwords("english"))
country6 <- gsub(pattern = "\\b[a-z]\\b{1}", replacement = " ",country5)
country6 <- stripWhitespace(country6)
install.packages("wordcloud")
library(wordcloud)
wordcloud(country6)
wordcloud(country6,random.order = F)
wordcloud(country6,random.order = F,colors = rainbow(7))
country7 <- Corpus(VectorSource(country6))
country7
tdm <- TermDocumentMatrix(country7)
tdm
m <- as.matrix(tdm)
colnames(m) <- c("corona_ind","corona_italy","corona_spain","corona_uk","corona_usa")
colnames(m)
comparison.cloud(m, min.words = 200,random.order = F,colors = rainbow(5),title.size = 1)
poswords <- scan('positive words.txt',what = 'character', comment.char = ';')
negwords <- scan('negative words.txt',what = 'character', comment.char = ';')
a <- str_split(country6,pattern = "\\s+")
a
pos_country <- lapply(a, function(x){sum(!is.na(match(x,poswords)))})
neg_country <- lapply(a, function(x){sum(!is.na(match(x,negwords)))})
names <- c("corona_ind","corona_italy","corona_spain","corona_uk","corona_usa")
score <- vector('list',5)
 for(i in 1:5){
    print(names[i])
   print( pos_country[[i]]-neg_country[[i]])
   print('sentiment is negative')
   score[[i]] <- pos_country[[i]]-neg_country[[i]]
   }
score
unlist(score)
mean(unlist(score))
sd(unlist(score))
hist(unlist(score))
boxplot(unlist(score))