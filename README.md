# FreetownSpatialAnalysis
Freetown - characterizing a city in a data sparse environment

The advent of the Big data exploitation has led to an increased focus on data-driven decision making. These changes have created giant leaps in technology for  different sectors including health care, supply chains, agriculture,online retailing among others. However, in developing regions, the implementation and performance of many of  these methods are stunted due to the limitations in available data sets. 

The problem with data in many developing countries is three fold. The data is usually either restricted, very incomplete or nonexistent. Data restrictions can be addressed by creating collaborations with governments and companies that can allow access to the data. However, these restricted data sets are still few and far between. The data needed to implement the bulk of the available technologies to solve problems lie in the second and third categories. As a result, researchers need to make active efforts to obtain and populate existing data sources. In addition, working in data sparse environments requires the use of creative techniques that can allow researchers to make useful  inferences using approximations to the data.

In a recent project, I worked in a team of 4 graduate students to characterize the Freetown Peninsula in Sierra Leone under data spare Conditions.[1] Freetown is plagued by several natural hazards particularly landslides due to its proximity to the ocean and mountainous topography. Understanding the vulnerability such a city presents is essential for infrastructure and social welfare investments. Throughout our analysis, we used population density data obtained from Landscan ( a global population distribution data set)  and the location of popular attractions scrapped from google maps.

Some of the techniques we used were as follows:

**Population Dynamics:**

In order to assess the population spread within Freetown, Sierra Leone by applying **Clustering and Percolation techniques** on population density data. 

![image](https://user-images.githubusercontent.com/36086489/217408807-67050312-6c68-4a2d-a34e-9fd763e4b265.png)


The information from the percolation analysis allowed us to create a bare bones structure to characterise the city growth using population density. This analysis is an important preliminary step in order to better understand how the population is distributed spatially in Freetown. These results would serve as a basis for further research that involves providing resources to the population  and understanding the market in Freetown. 

Estimating Movement and Travel:
 The distribution for the number of trips within the city of Freetown was generated using an extended radiation model.

![image](https://user-images.githubusercontent.com/36086489/217409022-b7587380-b582-4161-afd0-1e15c143f816.png)


       


Lumley Beach is one of the most famous attractions in Freetown. The reason why it will attract most trips is the dense distribution of tourist destinations like restaurants or clubs around, which results in the high POI around it.



![image](https://user-images.githubusercontent.com/36086489/217409067-96edf151-04c3-4a8b-95f1-404a28b46ca7.png)


In addition a route network model was also developed with keep metrics such as measures of centrality calculated and used to investigate the city’s susceptibility to natural hazards and accessibility to key locations such as schools and hospitals. In the future, we plan to fit our model to historical data to observe whether or not our growth model captures the city spreading accurately.

**References**

Nelson, Andrew, Elimbi Moudio, Marie Pelagie, Tian, Yuan and Halpern,Jeremy,. Freetown - Characterizing a City in a Data- Scarce Environment. Freetown - Characterizing a City in a Data- Scarce Environment.








