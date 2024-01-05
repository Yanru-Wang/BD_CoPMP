using Printf
include("./utilities.jl")


# julia read_data.jl testset=1 fname_demand=./dataset1_test/ds1_H_300_1.conpmp fname_distance=./dataset1_test/ds1_D_300_1.conpmp
# julia read_data.jl testset=2 fname_real=Gaz_counties_national.txt size=1000
# julia read_data.jl testset=3 fname_real=Gaz_places_national.txt size=5000


function GetData(param)
    if param.testset == 1
        vec_h, mat_d = ReadDemand(param.fname_demand), ReadDistance(param.fname_distance)
    else
        vec_h, mat_d = GetData_Dependent(param.fname_real, param.size)
    end
    return vec_h, mat_d
end

mutable struct Param
    testset::Int
    fname_demand::String
    fname_distance::String
    fname_real::String
    size::Int
end
param = Param(0, "", "", "", 0)
for i in eachindex(ARGS)
    str = split(ARGS[i], "=")
    if str[1] == "testset"
        param.testset = parse(Int, str[2])
    elseif str[1] == "fname_demand"
        param.fname_demand = str[2]
    elseif str[1] == "fname_distance"
        param.fname_distance = str[2]
    elseif str[1] == "fname_real"
        param.fname_real = str[2]
    elseif str[1] == "size"
        param.size = parse(Int, str[2])
    end
end

vec_h, mat_d = GetData(param)

