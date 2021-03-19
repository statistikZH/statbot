# Creative Challenge, NLP-Hackathon, Uni Berne 24th/25th March

## Problem description
Publically available data, for example, about the inhabitants of the Canton of Zurich, are not always easy to find. In Switzerland, data and information provided by the government are not only spread vertically over different federal levels. They are also horizontally spread within these federal levels over different offices and sometimes even there over different sites/channels with different formats. Looking for the needle in the haystack seems comparatively easy. 
Furthermore, even search engines are only of limited help as they follow an indexing logic that excludes information stored in databases or files.
A complicated search process for data and information can also pose a risk to democratic processes: the harder it is for citizens to access information, the easier it is to spread fake news. 
Against this background, the Statistical Office of the Canton of Zurich, in collaboration with other organizations, plans to develop a Swiss Statistical Bot (STATBOT.CH) which provides citizens with data and statistical information as quickly and easily as possible.

## The aim of the Challenge with «creative character»

The way we see it, we do not need to be able to chat with the bot (as can be seen on many commercial websites), but we would like the bot to provide people with specific answers in the form of data. 

For example:  
Question: *"Wie viele Leute lebten per 31.12.2020 im Kanton Zürch?"*  
Anwer: *"Der Kanton Zürich hatte per 31.12.2020 1'551'342 Einwohner/innen (zivilirechtliche Bevölkerung)."*  

While this seems like a fairly straightforward process, it requires a couple of rather complicated operations behind the scenes. For example, statistical information is commonly structured in tables. However, the information people need is often not readily available in the tables but requires statistical aggregations across cells such as computing averages by different groups, sums, or counts. 

In a classical chatbot approach, textbased questions and answers are commonly fed into a pre-trained model and used in a Q&A-Scheme. We think that such an appraoch is not suitable for our purposes, mainly because of the vast number of possible Q&A-pairs. The number increases exponentially with growing sizes and soures of tables (imagine all possible combinations in a table with "only" 500 rows times 20 columns -- and then multiply this by at least 200 different data sources).

We believe there are two large components to the development of the bot. First, the bot needs to be able to "understand" the questions. Second, the bot needs to provide an answer to the data query. In this challenge, we would like to focus on the first component.
- The primary aim of this challenge is to find a way to extract the most important pieces of information from a given question such that the bot is able to work with them further down the pipeline.  
- The secondary aim is to train a useful model for this “information extraction”. 


## Possible solutions
You are completely free to choose any approach that you consider suitable. In order to support you as much as possible, we have collected our thoughts, resources, and research we deem relevant in the file ['possible solutions.md'](02_possible_solutions.md). However, bear in mind that we are no NLP-experts and might be totally wrong in our assumptions -- we are very curious to hear your thoughts and ideas.

## Data
The data that the statbot will be based on is publicly and openly available as so called Open Government Data (OGD). The philosophy behind OGD is that government data should be openly and freely accessible for all whenever possible. The publication of high-quality official statistics in the form of OGD promotes the reuse of high quality information bases and therefore increases their reach. You can find a JSON-file of the Statistical Office of the Canton Zurich containing meta information and links to all of our openly available OGD sources: https://www.web.statistik.zh.ch/data/zhweb.json

The data follows the so called Data Catalogue Vocabulary (DCAT), a common standard of meta information. It enables producers of data to share them more easily. Since other statistical offices or data sharing authorities use the same DCAT standard, they may eventually also make use of the statbot -- at least that is part of our vision. Therefore, we think it makes sense to use a modular approach with which data from other regions or even countries could be easily added. Therefore, you can also use other data sources for training purposes, for example data from opendata.swiss, the Swiss open data repository.

## Participants by the Statistical Office of the Canton of Zurich
During the hackathon we will try to stand by your side and help as much as possible. 

- Christian Ruiz (christian.ruiz@statistik.ji.zh.ch 076/4487500)
- Corinna Grobe
- Manuela Paganini
- Michelle Donzallaz
- Thomas Lo Russo


