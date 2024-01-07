# BD_CoPMP

This repository contains instances of testset T1, T2, T3 of the paper "Benders decomposition for coverage constrained $p$-median problems" by Yan-Ru Wang, Jie Liang, Cheng-Yang Yu, Wei Lv, Wei-Kun Chen, and Yu-Hong Dai.

## Instances 

Function `GetData(param)` in `read_data.jl` returns a demand vector `vec_h` and a distance matrix `mat_d`.

There are 40 data files (i.e., 20 instances) in `./dataset1`.
The file naming convention in this test case library (`./dataset1`) follows the format "ds1_D_1000_1.conpmp" / "ds1_H_1000_1.conpmp". 
Here's a breakdown of the components:

- "ds1": Indicates that it belongs to dataset 1.
- "D": Represents the distance information, and "H": Represents the demand information.
- "1000": Indicates the number of customers in this instance.
- "1": Represents the first randomly generated instance.

### Testset 1

> An example to obtain the first generated data of size 3000 in testset T1:
> `julia read_data.jl testset=1 fname_demand=./dataset1_test/ds1_H_300_1.conpmp fname_distance=./dataset1_test/ds1_D_300_1.conpmp`


### Testset 2 and Testset 3

The 2010 census data of 3221 counties in the USA is available at `https://www2.census.gov/geo/docs/maps-data/data/gazetteer/Gaz_counties_national.zip`
and the 2010 census data of 29514 Census Designated Places (CDPs) in the USA is available at `https://www2.census.gov/geo/docs/maps-data/data/gazetteer/Gaz_places_national.zip`.

Notice that instances in testset T2 and T3 are obtained by collecting the requested number of items of counties / places of the highest polulations from source data files. Thus the size of instances is need as an input.

> An example to obtain an instance of size 1000 in teset T2: `julia read_data.jl testset=2 fname_real=Gaz_counties_national.txt size=1000`

> An example to obtain an instance of size 5000 in teset T3: `julia read_data.jl testset=3 fname_real=Gaz_places_national.txt size=5000`

