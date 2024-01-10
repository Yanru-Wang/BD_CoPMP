using Printf
include("./utilities.jl")


# julia read_data.jl testset=1 fname_demand=testset1/T1_H_300_1.copmp fname_distance=testset1/T1_D_300_1.copmp
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

w = 0.0
Dmax = 0
p = 0
num = 0

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
    elseif str[1] == "s"
        param.size = parse(Int, str[2])
    elseif str[1] == "Dmax"
        global Dmax += parse(Int, str[2])
    elseif str[1] == "p"
        global  p += parse(Int, str[2])
    elseif str[1] == "w"
        global w += parse(Float64, str[2])
    elseif str[1] == "num"
        global num = parse(Int, str[2])
    end
end

saveFname = ""
if param.testset == 1
    m = match(r"(T1_H_[0-9]+_[0-9].copmp)", param.fname_demand)
    name = split(m.match, "_")
    name[4] = split(name[4], ".")[1]
    saveFname = name[1] * "_" * name[3] * "_" * string(Dmax) * "_" * string(p) * "_" * string(w) * "_" * name[4] * ".copmp"
else
    saveFname = "T" * string(param.testset) * "_" * string(param.size) * "_" * string(Dmax) * "_" * string(p) * "_" * string(w) * ".copmp"
end

paraset = ""
if param.testset == 1
    paraset = "T1.set"
elseif param.testset == 2
    paraset = "T2-H.txt"
elseif param.testset == 3
    paraset = "T3-H.txt"
end

H = 0
lines = readlines(paraset)
flag = false
for line in lines[2:end]
    str = split(line, " ", keepempty=false)
    if paraset == "T1.set"
        if str[1] == string(param.size) * "-" * string(num) && str[2] == string(Dmax) && str[3] == string(p)
            global H = w * parse(Float64, str[4]) + (1 - w) * parse(Float64, str[5])
            global flag = true
            break
        end
    else
        if str[1] == string(param.size) && str[2] == string(Dmax) && str[3] == string(p) && str[4] == string(w)
            global H = parse(Float64, str[5])
            global flag = true
            break
        end
    end
end
if !flag
    println("Error: no such instance in the parameter set!")
    exit(0)
end

H = round(H, digits=1)

vec_h, mat_d = GetData(param)

open(saveFname, "w") do f
    write(f, "$(param.size) $(Dmax) $(p) $H\n")
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

