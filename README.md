# BD_CoPMP

This repository contains instances of testsets T1, T2, and T3 of the paper "Benders decomposition for coverage constrained $p$-median problems" by Yan-Ru Wang, Jie Liang, Cheng-Yang Yu, Wei Lv, Wei-Kun Chen, and Yu-Hong Dai.


In all instances of testsets T1, T2, and T3, the number of customers and facilities are set to be equal.

The format of the instance file:
> line 1: problem size s, maximum covering distance Dmax, number of open facilities p, maximum uncovered demand H.  
> line 2: demand of all customers.     
> line i + 2: distance of customer i to each facility (i = 1, ..., s). 

### Testset T1 

There are 60 instance files in `./T1`.
The file naming convention in this test case library (`./T1`) follows the format T1_s_Dmax_p_w_num.copmp. 
As an example, for T1_1000_12_15_0.2_1.copmp,


- "T1" indicates that it belongs to testset T1;
- "1000" is the problem size (i.e., the number of customers and facilities are equal to 1000);
- "12" is the maximum covering distance;
- "15" is the number of open facilities;
- "0.2" is the weight reflecting how large the maximum uncovered demand is;
- "1" is the instance number (there are 5 instances for each parameters (s, Dmax, p, w)).


### Testsets T2 and T3


The instances of Testsets T2 and T3 are constructed based on the real-world data:

The 2010 census data of 3221 counties in the USA, which is available at
https://www2.census.gov/geo/docs/maps-data/data/gazetteer/Gaz_counties_national.zip

The 2010 census data of 29514 Census Designated Places (CDPs) in the USA, which is available at
https://www2.census.gov/geo/docs/maps-data/data/gazetteer/Gaz_places_national.zip.

`T2.set` and `T3.set` contain the information of maximum uncovered demand H corresponding to the instances T2_s_Dmax_p_w.copmp and T3_s_Dmax_p_w.copmp.

---

We use `read_data.jl` the construct the instances in Testsets T2 and T3.      
For example, to obtain instance T2_1000_130_10_0.2.copmp, we can run the code:

```julia 
julia read_data.jl testset=2 fname_real=./Gaz_counties_national.txt s=1000 Dmax=130 p=10 w=0.2
```

