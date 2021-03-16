# Creative Challenge, NLP-Hackathon, Uni Berne 24th/25th March

## Problem description
If you are searching for some form of statistical information, it is not always easy to find it in the shortest time possible. Particularly in Switzerland, the data and information are not only spread vertically over different federal levels. They are also spread within these federal levels horizontally over different offices and even there sometimes over different sites/channels with different formats. Looking for the needle in the haystack looks comparably easy next to that. 
Further, even search engines are only of limited help, as they follow an indexing logic that excludes information stored in databases or files.
The background of a more difficult search for facts, is also a risk for democratic processes: The harder it is for the average citizen to find truthful information, the easier it is to spread fake news. 
Therefore, the Statistical Office of the Canton of Zurich, together with other organizations, would like to develop a Swiss Statistical Bot (STATBOT.CH), which would provide data and statistical information directly and quickly across all organizations. 

## The aim of the Challenge with «creative character»
In our understanding, we are not looking for a "chatty" classical bot, as it can be seen on many commercial websites. We do not want to start a conversation, but we want to get very specific answers in form of data.

For example: "What is the population of the canton of Zurich?"
"There are X people living in the Canton of Zurich in 2020."  

However, this example does not show the complexity behind the issue. Because statistical data is contained in form of many different tables - one with demographics data, one with housing data, one with economic data and so on. Questions could concern several cells of those tables or could concern aggregates/operations of cells such as averages, sums, counts and so on. 

This makes a classical chatbot approach, where for example text-information is fed into a pre-trained model to be used in a Q&A-Scheme, could possibly not apply, as the text-data to feed such a model increases very quickly exponential with growing sizes of tables (imagine all the combinations possible in a table that is "only" 500 rows times 20 columns - and then multiply this by at least 200 different data sources).

Rather we think that such a statistical bot is based on two large components. On the one hand, there is the «understanding of the question», and on the other hand, there is the data query. In this challenge, we would like to focus on the first part: 
Primary aim: To find a way, to extract the most important information from a question, in order to be able to work with the content further down the pipeline. 
Secondary aim: To train a useful model for this “information extraction”. 

## Possible solutions
You are completely open to chose the approach that you would like to pursue. In order to support you as much as we can, we are sharing a document with our current thoughts and research for [possible solutions](02_possible_solutions.md). We are no NLP-experts and might be totally wrong in our assumptions. We are thus very curious to discuss with you about your thoughts and about possible ways that you see.

## Data
Our data is publicly and openly available as so-called Open Government Data (OGD). It means that Government Data should be openly and freely accessible in the interest of society. You can find a JSON-file of the Statistical Office of the Canton Zurich, that contains all the meta-information and links to all of our openly available Open Government Data sources: https://www.web.statistik.zh.ch/data/zhweb.json

Our data follows the so-called Data Catalog Vocabulay (DCAT). It enables producers of e.g. statistical data to share their data with a common standard of meta-information. This is why after all this statbot solution could probably be used by any other statistical office or data sharing authority that uses the DCAT standard - at least this is part of our vision. Thus a modular approach could be used, so that other data could be loaded in so that the statbot can give back Austrian, French or Australian data. You are thus also welcome, to use any other data for example from opendata.swiss, which is the Swiss open data repository based on DCAT.

## Participants by the Statistical Office of the Canton of Zurich
During the hackathon we will try to stand at your side for all the possible help that we can provide. 

Christian Ruiz
christian.ruiz@statistik.ji.zh.ch
076 / 448 75 00

Corinna Grobe
Manuela Paganini
Michelle Donzallaz
Thomas Lo Russo


