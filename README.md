# BD_CoPMP

This repository contains instances of testsets T1, T2, and T3 of the paper "Benders decomposition for coverage constrained $p$-median problems" by Yan-Ru Wang, Jie Liang, Cheng-Yang Yu, Wei Lv, Wei-Kun Chen, and Yu-Hong Dai.


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


Running `read_data.jl` gives the corresponding CoPMP instance file. 
> The format of the resulting instance file:   
> line 1: number of customers $n$, maximum covering distance $D_{\text{max}}$, number of open facilities $p$, maximum uncovered demand $H$.  
> line 2: the demand of each customer.     
> line i + 2: the distance of customer i to each facility (i = 1, ..., n). n is the size of the instance.


> Suppose files `Gaz_counties_national.txt` and `Gaz_places_national.txt` (after being uncompressed) exist at current directory (`BD_CoPMP/`).

A (linux) command line example example to obtain the instance of size 1000 in teset T2: 
```julia 
julia read_data.jl testset=2 fname_real=./Gaz_counties_national.txt n=1000 Dmax=130 p=10 gamma=0.2
```

A (linux) command line example example to obtain the instance of size 5000 in teset T3: 
```julia
julia read_data.jl testset=3 fname_real=./Gaz_places_national.txt n=5000 Dmax=50 p=100 gamma=0.2
```
