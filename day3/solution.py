f = open("data.in","r")
lines = f.readlines()

def codeOfLetter(letter):
    ascii = ord(letter)
    if 65 <= ascii and ascii <= 90: # is uppercase
        return 27 + ascii - 65
    return 1 + ascii - 97

total = 0

for line in lines:
    #print(line, end="")

    l = len(line)
    h = l // 2
    lower = line[0:(h)]
    upper = line[(h):(l-1)]

    lowerAcc = [0] * 53
    upperAcc = [0] * 53

    for el in lower:
        lowerAcc[codeOfLetter(el)] = 't'

    for el in upper:
        upperAcc[codeOfLetter(el)] = 't'

    sum = 0

    for i in range(53):
        if lowerAcc[i] != 0 and lowerAcc[i] == upperAcc[i]:
            sum += i
    
    total += sum

print(total)

i = 0

total = 0

while i < len(lines):
    acc1 = [False] * 53
    acc2 = [False] * 53
    acc3 = [False] * 53

    line = lines[i]

    for el in line[:len(line)-1]:
        code = codeOfLetter(el)
        acc1[code] = True

    line = lines[i + 1]

    for el in line[:len(line)-1]:
        code = codeOfLetter(el)
        acc2[code] =  True

    line = lines[i + 2]

    for el in line[:len(line)-1]:
        code = codeOfLetter(el)
        acc3[code] = True


    i += 3
    
    for j in range(53):
        if acc1[j] == True and acc2[j] == True and acc3[j] == True:
            total += j

print(total)
