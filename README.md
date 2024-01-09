# BD_CoPMP

This repository contains instances of testset T1, T2, T3 of the paper "Benders decomposition for coverage constrained $p$-median problems" by Yan-Ru Wang, Jie Liang, Cheng-Yang Yu, Wei Lv, Wei-Kun Chen, and Yu-Hong Dai.


In all instances of testsets T1, T2, and T3, the number of customers and facilities are set to be equal.

### Testset T1 

There are 60 instance files in `./T1`.
The file naming convention in this test case library (`./T1`) follows the format "T1_1000_12_15_0.2_1.copmp". 
Here's a breakdown of the components:

- "T1": indicates that it belongs to testset 1.
- "1000": indicates both the number of customers and the number of facilities.
- "12": indicates the distance $D_{\text{max}}$, i.e., the maximum covering distance.
- "15": indicates the number of open facilities $p$.
- "0.2": indicates the value of weight $w$, i.e., how large the maximum uncovered demand $H$ is.
- "1": Represents the first randomly generated instance.


### Testsets T2 and T3

--- 

Source data of testset T2, i.e., the 2010 census data of 3221 counties in the USA is available at https://www2.census.gov/geo/docs/maps-data/data/gazetteer/Gaz_counties_national.zip

Source data of testset T3, i.e., the 2010 census data of 29514 Census Designated Places (CDPs) in the USA is available at https://www2.census.gov/geo/docs/maps-data/data/gazetteer/Gaz_places_national.zip.


---


Running `read_data.jl` gives the corresponding instance file. 
> The format of the resulting instance file:   
> line 1: number of customers $n$, maximum covering distance $D_{\text{max}}$, number of open facilities $p$, maximum uncovered demand $H$.  
> line 2: the demand of each customer.     
> line i + 2: the distance of customer i to each facility (i = 1, ..., n). n is the size of the instance.


> Suppose we have `Gaz_counties_national.txt` and `Gaz_places_national.txt` (after uncompressing) at current directory (`BD_CoPMP/`).

A (linux) command line example example to obtain the instance of size 1000 in teset T2: 
```julia 
julia read_data.jl testset=2 fname_real=./Gaz_counties_national.txt n=1000 Dmax=130 p=10 gamma=0.2
```

A (linux) command line example example to obtain the instance of size 5000 in teset T3: 
```julia
julia read_data.jl testset=3 fname_real=./Gaz_places_national.txt n=5000 Dmax=50 p=100 gamma=0.2
```
---
PS: 
Instances in testset T2 and T3 are obtained by collecting the requested number of items (i.e., population (column `POP10`), latitude (column `INTPTLAT`), and longitude (column `INTPTLONG`)) of counties / places of the highest polulations from source data files. Thus the size of instances is need as an input.       
Each place is viewed as both customer and facility.    
Demand of a customer takes the value of the population of the corresponding place.    
Distance between two places (i.e., a customer and a facility) is computed using the Harvesine formula: 

$$
d_{ij} = 2R \arcsin \left( \sqrt{\sin^2  \left( \frac{\phi_i -\phi_j}{2} \right) + \cos(\phi_i) \cos(\phi_j)\sin^2  \left( \frac{\lambda_i -\lambda_j}{2} \right)} \right)
$$

where $R = 6731$ (km) is the radius of the earth, $\phi_i$ and $\lambda_i$ (respectively $\phi_j$ and $\lambda_j$) are the latitude and longitude of place $i$ (respectively, place $j$);
the demand $h_i$, $i \in \[n\]$ is the set as the population of the corresponding place.
