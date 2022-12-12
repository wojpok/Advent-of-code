-- configuration
iteration = 20
div = 3

-- level 2
if(true) then
    iteration = 10000
    div = 1
end

function createMonke (st, op, md, ift, iff)
   return { 
        stack = st, 
        inspections = 0,

        operation = op,

        modulus = md,
        iftrue = ift,
        iffalse = iff,
    }
end

function pass(mk, el)
    mk.stack[#mk.stack + 1] = el
end

function consumeQueue (mk, monkes)
    mk.inspections = mk.inspections + #mk.stack

    --print(#mk.stack)

    for i = 1, #mk.stack, 1 do
        v = mk.stack[i]

        value = (mk.operation(v)) // div

        if (value % mk.modulus) == 0 then
            pass(monkes[mk.iftrue + 1], value)
        else
            pass(monkes[mk.iffalse + 1], value)
        end
    end

    mk.stack = {}
end

arr = {}

monk = createMonke(
    {91, 54, 70, 61, 64, 64, 60, 85},
    function(old) return old * 13 end,
    2, 5, 2
)
arr[#arr + 1] = monk

monk = createMonke(
    {82},
    function(old) return old + 7 end,
    13, 4, 3
)
arr[#arr + 1] = monk

monk = createMonke(
    {84, 93, 70},
    function(old) return old + 2 end,
    5, 5, 1
)
arr[#arr + 1] = monk

monk = createMonke(
    {78, 56, 85, 93},
    function(old) return old * 2 end,
    3, 6, 7
)
arr[#arr + 1] = monk

monk = createMonke(
    {64, 57, 81, 95, 52, 71, 58},
    function(old) return old * old end,
    11, 7, 3
)
arr[#arr + 1] = monk

monk = createMonke(
    {58, 71, 96, 58, 68, 90},
    function(old) return old + 6 end,
    17, 4, 1
)
arr[#arr + 1] = monk

monk = createMonke(
    {56, 99, 89, 97, 81},
    function(old) return old + 1 end,
    7, 0, 2
)
arr[#arr + 1] = monk

monk = createMonke(
    {68, 72},
    function(old) return old + 8 end,
    19, 6, 0
)
arr[#arr + 1] = monk

--for i = 1, 8, 1 do print(arr[i].iftrue) end

arr2 = {
    createMonke(
        {79, 98},
        function(old) return old * 19 end,
        23, 2, 3
    ),
    createMonke(
        {54, 65, 75, 74},
        function(old) return old + 6 end,
        19, 2, 0
    ),
    createMonke(
        {79, 60, 97},
        function(old) return old * old end,
        13, 1, 3
    ),
    createMonke(
        {74},
        function(old) return old + 3 end,
        17, 0, 1
    ),
}




for i = 1, 10000, 1 do

    for j = 1, 8, 1 do
        consumeQueue(arr[j], arr)
    end
end

top1 = 0
top2 = 0

for i = 1, 8, 1 do
    insp = arr[i].inspections

    if(insp > top1) then
        t = top1
        top1 = insp
        insp = t
    end

    if(insp > top2) then
        top2 = insp
    end
end

print(top1)
print(top2)
print(top1 * top2)

for i = 1,4,1 do
    --print(i)

    for j = 1,#arr2[i].stack,1 do
        --print((arr2[i].stack)[j])
    end
end

--for i = 1,4,1 do
    --consumeQueue(arr2[1], arr2)
    --consumeQueue(arr2[2], arr2)
    --consumeQueue(arr2[3], arr2)
    --consumeQueue(arr2[4], arr2)
--end
--print("=====")
for i = 1,4,1 do
    ---print(i)

    for j = 1,#arr2[i].stack,1 do
       -- print(arr2[i].stack[j])
    end
end


for i = 1, 1000, 1 do

    for j = 1, 4, 1 do
        consumeQueue(arr2[j], arr2)
    end
end

top1 = 0
top2 = 0

for i = 1, 4, 1 do
    insp = arr2[i].inspections
    print(insp)

    if(insp > top1) then
        t = top1
        top1 = insp
        insp = t
    end

    if(insp > top2) then
        top2 = insp
    end
end


print(top1)
print(top2)
print(top1 * top2)