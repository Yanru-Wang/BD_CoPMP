
# Testset 1
for s in 300 500 800 1000
do
    for r in 0.2 0.5 0.8
    do
        for i in {1..5}
        do
            echo $i
            julia read_data.jl testset=1 fname_demand=testset1/T1_H_${s}_${i}.copmp fname_distance=testset1/T1_D_${s}_${i}.copmp m=$s Dmax=12 p=15 gamma=$r num=$i
        done
    done
done

# T2

# T3