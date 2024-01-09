# BD_CoPMP

This repository contains instances of testset T1, T2, T3 of the paper "Benders decomposition for coverage constrained $p$-median problems" by Yan-Ru Wang, Jie Liang, Cheng-Yang Yu, Wei Lv, Wei-Kun Chen, and Yu-Hong Dai.

## Source Data Files

- In all instances of testsets T1, T2, and T3, the number of customers and facilities are set to be equal.

There are 40 data files (i.e., 20 instances) in `./testset1`.
The file naming convention in this test case library (`./testset1`) follows the format "T1_D_1000_1.copmp" / "T1_H_1000_1.copmp". 
Here's a breakdown of the components:

- "T1": Indicates that it belongs to testset 1.
- "D": Represents the distance information, and "H": Represents the demand information.
- "1000": Indicates the number of customers, which is also the number of facilities,  in this instance.
- "1": Represents the first randomly generated instance.

> The format of demand files (e.g., "T1_H_1000_1.copmp") is:
line 1: number of customers
line 2 to the end of file: the index of customer and the demand of customer

> The format of distance files (e.g., "T1_D_1000_1.copmp") is:   
line 1: number of customers, number of facilities, number of distances for each pair of customer and facility     
line 2 to the end of file: the index of customer, the index of facility, and the distance between customer and facility    


--- 

Sorce data of testset T2, i.e., the 2010 census data of 3221 counties in the USA is available at https://www2.census.gov/geo/docs/maps-data/data/gazetteer/Gaz_counties_national.zip

--- 
Sorce data of testset T3, i.e., the 2010 census data of 29514 Census Designated Places (CDPs) in the USA is available at https://www2.census.gov/geo/docs/maps-data/data/gazetteer/Gaz_places_national.zip.




### Instances 

Function `GetData(param)` in `read_data.jl` returns a demand vector `vec_h` ($\{h_i\}$) and a distance matrix `mat_d` ($\{d_{ij}\}$).

### Testset 1

> A (linux) command line example to obtain the first generated data of size 300 in testset T1:
```julia
julia read_data.jl testset=1 fname_demand=./testset1_test/T1_H_300_1.copmp fname_distance=./testset1_test/T1_D_300_1.copmp
```


### Testset 2 and Testset 3

Instances in testset T2 and T3 are obtained by collecting the requested number of items (i.e., population (column `POP10`), latitude (column `INTPTLAT`), and longitude (column `INTPTLONG`)) of counties / places of the highest polulations from source data files. Thus the size of instances is need as an input.       
Each place is viewed as both customer and facility.    
Demand of a customer takes the value of the population of the corresponding place.    
Distance between two places (i.e., a customer and a facility) is computed using the Harvesine formula: 

$$
d_{ij} = 2R \arcsin \left( \sqrt{\sin^2  \left( \frac{\phi_i -\phi_j}{2} \right) + \cos(\phi_i) \cos(\phi_j)\sin^2  \left( \frac{\lambda_i -\lambda_j}{2} \right)} \right)
$$

where $R = 6731$ (km) is the radius of the earth, $\phi_i$ and $\lambda_i$ (respectively $\phi_j$ and $\lambda_j$) are the latitude and longitude of place $i$ (respectively, place $j$);
the demand $h_i$, $i \in \[n\]$ is the set as the population of the corresponding place.

> Suppose we have `Gaz_counties_national.txt` and `Gaz_places_national.txt` (after uncompressing) at current directory (`BD_CoPMP/`).

A (linux) command line example example to obtain the instance of size 1000 in teset T2: 
```julia 
julia read_data.jl testset=2 fname_real=./Gaz_counties_national.txt size=1000
```

A (linux) command line example example to obtain the instance of size 5000 in teset T3: 
```julia
julia read_data.jl testset=3 fname_real=./Gaz_places_national.txt size=5000
```

