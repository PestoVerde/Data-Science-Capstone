library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "bootstrap.min.css",
  
  pageWithSidebar(
  
  # Application title
      titlePanel("Data Science Capstone: Natural Language Processing"),
      
  # Sidebar with a slider input for the number of bins
    sidebarPanel(
      textInput("words",
                h5("Please, type something"),
                "a cup of"),
      radioButtons("radio", 
                   label = h5("Words to predict"),
                   choices = list("1" = 1, 
                                  "2" = 2,
                                  "3" = 3),
                   selected = 3),
      radioButtons("smooth", 
                   label = h5("Smoothing"),
                   choices = list("Kneser-Ney" = 1, 
                                  "Stupid Backoff" = 2),
                   selected = 2),
      
      submitButton("PREDICT")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Prediction",
                 p('Please choose a number of words to predict and 
                   smoothing method, then press PREDICT button.'),
                 p('Notice that Kneser-Ney method is more accurate, 
                   but takes longer time for prediction. Stupid Backoff 
                   is much faster, but less accurate. The suggested input 
                    A CUP OF shows this clearly. See THEORY tab for details.'),
                 p('Most probable word goes first:'),
                  h4(textOutput('text'))
                 ),
        tabPanel("Theory",
                 p('Prediction of the next word is a part of computer science 
                   called Natural Language Processing. The model is based on 
                   frequency analysis of n-grams. Those n-grams are made out of
                   a given corpus of text. The model takes several last words of
                   input and suggests the most frequent continuation.'),
                 p('But what if the frequency of given n-gram is small? Here is
                   the classic example of Dr. Jurafsky. "I can not read without my reading
                   _____." Obvious continuation "glasses" can be missed by model. 
                   Instead the model can use "Francisco", if this word is more 
                   frequent.'),
                 p('Smoothing methods solves this problem. Most effective of them 
                   is Kneser-Ney. "This model uses the concept of absolute-discounting 
                   interpolation which incorporates information from higher and 
                   lower order language models. The addition of the term for 
                   lower order n-grams adds more weight to the overall 
                   probability when the count for the higher order n-grams is zero. 
                   Similarly, the weight of the lower order model decreases when 
                   the count of the n-gram is non zero." (Wikipedia). However,
                   this method need a lot of computations.'),
                 p('Stupid Backoff does not calculate discounting coefficient, instead
                    it uses constant coefficent which is less than 1. All lower
                    frequencies are just multiply consecutively with it.
                   "Stupid Backoff is inexpensive to calculate in 
                   a distributed environment while approaching the quality of 
                   Kneser-Ney smoothing for large amounts of data."
                   (http://www.aclweb.org/anthology/D07-1090.pdf)'),
                 p('Since our corpus is relatively small, the results of those 
                   two methods are different. For supposed input "a cup of"
                   Stupid backoff almost immediately gives most frequent "the", while
                   "coffee" and "tea" take second and third places. Kneser-Ney
                   put those words in a correct order.')
                 ),
        tabPanel("Notes",
                  p('This small application predicts next word of user input. 
                    This kind of applications are useful for small virtual 
                    keyboards of smartphones.'),
                  p('There are several of such applications on the market, 
                    one of the most famous is provided by SwiftKey. 
                    (https://swiftkey.com/en)'),
                  p('The data for prediction is from a corpus called "HC Corpora". 
                    It can be found at www.corpora.heliohost.org')
                 ) 
    )
    )#mainPane
  )#pageWithSidebar
  )#fluidPage
)#shinyUI
