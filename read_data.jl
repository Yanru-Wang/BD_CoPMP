using Printf
include("./utilities.jl")


# julia read_data.jl testset=1 fname_demand=./dataset1_test/ds1_H_300_1.conpmp fname_distance=./dataset1_test/ds1_D_300_1.conpmp
# julia read_data.jl testset=2 fname_real=Gaz_counties_national.txt size=1000
# julia read_data.jl testset=3 fname_real=Gaz_places_national.txt size=5000



function GetData(param)
"""
    Read demand and distance information from files or generate data.

    Arguments:
        - param: a struct containing instance information

    Returns:
        - vec_h: demand vector
        - mat_d: distance matrix
"""	
    if param.testset == 1
        vec_h, mat_d = ReadDemand(param.fname_demand), ReadDistance(param.fname_distance)
    else
        vec_h, mat_d = GetData_Dependent(param.fname_real, param.size)
    end
    return vec_h, mat_d
end



mutable struct Param
"""
    Struct to store information related to test sets and data files.

    Components:
        - testset::Int, indicates which test set the instance belongs to
        - fname_demand::String, file name for the demand file (only required for testset T1)
        - fname_distance::String, file name for the distance file (only required for testset T2)
        - fname_real::String, file name of the source data (only required for testsets T2 and T3)
        - size::Int, size of the instance (only required for testsets T2 and T3)
"""
    testset::Int  
    fname_demand::String 
    fname_distance::String
    fname_real::String
    size::Int
end

param = Param(0, "", "", "", 0)

saveFname = ""

for i in eachindex(ARGS)
    str = split(ARGS[i], "=")
    if str[1] == "testset"
        param.testset = parse(Int, str[2])
    elseif str[1] == "fname_demand"
        param.fname_demand = str[2]
        m = match(r"(T1_H_[0-9]+_[0-9].copmp)", str[2])
        println(str[2])
        name = split(m.match, "_")
        global saveFname = name[1] * "_" * name[3] * "_" * name[4]
    elseif str[1] == "fname_distance"
        param.fname_distance = str[2]
    elseif str[1] == "fname_real"
        param.fname_real = str[2]
        global saveFname = "T" * string(param.testset) * "_"
    elseif str[1] == "size"
        param.size = parse(Int, str[2])
        global saveFname *= str[2] * ".copmp"
    end
end

vec_h, mat_d = GetData(param)

open(saveFname, "w") do f
    for h in vec_h
        write(f, "$h ")
    end
    write(f, "\n")
    for i in 1:length(vec_h)
        for d in mat_d[i, :]
            write(f, "$d ")
        end
        write(f, "\n")
    end
end

