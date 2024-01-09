# BD_CoPMP

This repository contains instances of testsets T1, T2, and T3 of the paper "Benders decomposition for coverage constrained $p$-median problems" by Yan-Ru Wang, Jie Liang, Cheng-Yang Yu, Wei Lv, Wei-Kun Chen, and Yu-Hong Dai.


In all instances of testsets T1, T2, and T3, the number of customers and facilities are set to be equal.

The format of the instance file:
> line 1: number of customers $n$, maximum covering distance $D_{\text{max}}$, number of open facilities $p$, maximum uncovered demand $H$.  
> line 2: the demand of each customer.     
> line i + 2: the distance of customer i to each facility (i = 1, ..., n). 

### Testset T1 

There are 60 instance files in `./T1`.
The file naming convention in this test case library (`./T1`) follows the format "T1_1000_12_15_0.2_1.copmp". 
Here's a breakdown of the components:

- "T1": indicates that it belongs to testset T1.
- "1000": indicates both the number of customers and the number of facilities are equal to 1000.
- "12": indicates the maximum covering distance $D_{\text{max}}$.
- "15": indicates the number of open facilities $p$.
- "0.2": indicates the value of weight $w$, i.e., how large the maximum uncovered demand $H$ is.
- "1": Represents the first randomly generated instance.


### Testsets T2 and T3

--- 

Source data of testset T2, i.e., the 2010 census data of 3221 counties in the USA is available at https://www2.census.gov/geo/docs/maps-data/data/gazetteer/Gaz_counties_national.zip

Source data of testset T3, i.e., the 2010 census data of 29514 Census Designated Places (CDPs) in the USA is available at https://www2.census.gov/geo/docs/maps-data/data/gazetteer/Gaz_places_national.zip.


---

> Suppose files `Gaz_counties_national.txt` and `Gaz_places_national.txt` (after being uncompressed) exist at current directory (`BD_CoPMP/`).

A (linux) command line example to obtain the instance of size 1000, Dmax 130, p 10 and gamma 0.2 in testset T2: 
```julia 
julia read_data.jl testset=2 fname_real=./Gaz_counties_national.txt n=1000 Dmax=130 p=10 gamma=0.2
```
Then you can obtain an instance file naming `T2_1000_130_10_0.2.copmp`.

A (linux) command line example to obtain the instance of size 5000, Dmax 50, p 100 and gamma 0.2 in testset T3: 
```julia
julia read_data.jl testset=3 fname_real=./Gaz_places_national.txt n=5000 Dmax=50 p=100 gamma=0.2
```
Then you can obtain an instance file naming `T3_5000_50_100_0.2.copmp`.