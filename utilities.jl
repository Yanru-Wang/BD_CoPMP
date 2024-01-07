function ReadDemand(fname_h)
"""
    Read data (demand) from a file

    Arguments:
        - fname_h: name of the demand file

    Returns:
        - vec_h: demand vector
"""
    println("   @ Read Demand File: ", fname_h)

    data = readlines(fname_h)
    m = parse(Int, data[1])
    vec_h = zeros(m)

    for i in 1:m
        str = split(data[i+1], ' ', keepempty=false)
        client = parse(Int, str[1])
        # Record h_i
        vec_h[client] = parse(Int, str[2])
    end

    return vec_h
end

function ReadDistance(fname_d)
"""
   Read data (distance) from a file
   
    Arguments:
        - fname_d: name of the distance file

    Returns:
        - mat_d: distance matrix
"""
    println("   @ Read Distance File: ", fname_d)

    data = readlines(fname_d)
    str = split(data[1], ' ', keepempty=false)
    n = parse(Int, str[1])
    m = parse(Int, str[2])
    num_edge = parse(Int, str[3])
    mat_d = zeros(Float64, n, m)

    for i in 2:num_edge+1
        str = split(data[i], ' ', keepempty=false)
        client = parse(Int, str[1])
        facility = parse(Int, str[2])
        # Record d_{ij}
        mat_d[client, facility] = parse(Float32, str[3])
    end

    return mat_d
end

function GetDistance(latA, latB, longA, longB)

"""
    Calculate distance (km) from coordinates.

    Arguments:
        - latA: latitude of point A
        - latB: latitude of point B
        - longA: longtitude of point A
        - longB: longtitude of point B

    Returns:
        - dist::Float64         distance between coordinates
"""
    # earch radius is 6371.001 km on average
    Radius = 6371
    # calculate the distance
    delta_long = longA - longB
    delta_lat = latA - latB
    angle = asin(sqrt((sin(delta_lat / 2)^2) + cos(latA) * cos(latB) * (sin(delta_long / 2)^2)))
    dist = 2 * Radius * angle

    return dist
end

# convert Degrees to Radians
rad(theta_deg) = theta_deg * pi / 180


function GetData_Dependent(fname, m, isSorted=false)

"""
    Extract the demand and distance of the m most populous places from source data.

    Arguments:
        - fname: filename of source data
        - m: number of places to be extracted
        - isSorted: whether the demands are sorted or not

    Returns:
        - vec_h: demand vector
        - mat_d: distance matrix
"""
    data = readlines(fname)

    ndata = length(data) - 1
    listLAT = Vector{Float64}(undef, ndata)
    listLONG = Vector{Float64}(undef, ndata)
    # population, treated as demand
    listPOP = Vector{Int}(undef, ndata)

    NumCounty = size(data, 1) - 1
    m = m > NumCounty ? NumCounty : m
    @printf("NumCounty =  %d ; m = %d\n", NumCounty, m)

    # read the population, latitude and longtitude of each place
    for i in 1:NumCounty
        str = split(data[i+1], '\t', keepempty=false)
        listPOP[i] = parse(Int, str[end-7])
        listLAT[i] = parse(Float64, str[end-1])
        listLONG[i] = parse(Float64, str[end])
    end
    # get sorted indice such that the population is decreasing
    SortedI = sortperm(listPOP, rev=true)

    mat_d = zeros(Float64, m, m)
    # places are sorted
    vec_h = listPOP[SortedI[1:m]]
    if isSorted == true
        for i1 in 1:m
            for i2 in i1+1:m
                lat1, lat2, long1, long2 = listLAT[SortedI[i1]], listLAT[SortedI[i2]], listLONG[SortedI[i1]], listLONG[SortedI[i2]]
                mat_d[i1, i2] = round(GetDistance(rad(lat1), rad(lat2), rad(long1), rad(long2)), digits=4)
                mat_d[i2, i1] = mat_d[i1, i2]
            end
        end
    else
        # places are not sorted
        vec_keep = ones(Bool, ndata)
        vec_keep[SortedI[1:m]] .= 0
        deleteat!(listPOP, vec_keep)
        deleteat!(listLAT, vec_keep)
        deleteat!(listLONG, vec_keep)
        vec_h = listPOP
        for i1 in 1:m
            for i2 in i1+1:m
                lat1, lat2, long1, long2 = listLAT[i1], listLAT[i2], listLONG[i1], listLONG[i2]
                mat_d[i1, i2] = round(GetDistance(rad(lat1), rad(lat2), rad(long1), rad(long2)), digits=4)
                mat_d[i2, i1] = mat_d[i1, i2]
            end
        end
    end

    return vec_h, mat_d
end


