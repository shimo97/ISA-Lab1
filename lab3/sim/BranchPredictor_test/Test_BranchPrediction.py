import random

outfile = open("input.txt", "w")
branchAddresses = random.sample(range(101, 118), 4)
targetAddresses = random.sample(range(101, 118), 4)
BHT = [0]*4
address = 100
index_delayed = 0
i = 0
branchDetected = False
branchEvaluated = False
PV = False
PV_delayed = False
misprediction = False
misprediction_delayed = False
new_TA = random.randint(101, 118)
TA_changed = False
oldTA = 0
for k in range(0, 199):
    if address == 119:
        nextAddress = 100
    else:
        nextAddress = address + 1
    branch = 0
    outcome = 0
    if misprediction_delayed == False:
        if misprediction == False:
            if branchEvaluated == True:
                branchEvaluated = False
                branch = 1
                outcome = random.randint(0, 1)
                if branchAddresses[index_delayed] == targetAddresses[index_delayed]:
                    outcome = 1
                if outcome == 1:
                    if (TA_changed == True) and (index_delayed == 0):
                        TA_changed = False
                        misprediction = True
                    if (BHT[index_delayed] != 3):
                        BHT[index_delayed] += 1
                else:
                    if (BHT[index_delayed] != 0):
                        BHT[index_delayed] -= 1
                if PV_delayed != outcome:
                    misprediction = True
                    if outcome == True:
                        nextAddress = targetAddresses[index_delayed]
                    else:
                        nextAddress = branchAddresses[index_delayed] + 1
            if misprediction == False:
                if branchDetected == True:
                    branchEvaluated = True
                    PV_delayed = PV
                    index_delayed = i
                    branchDetected = False
                else:
                    if (k > 100) and (targetAddresses[0] != new_TA):
                        oldTA = targetAddresses[0]
                        targetAddresses[0] = new_TA
                        TA_changed = True
                if address in branchAddresses:
                    branchDetected = True
                    i = branchAddresses.index(address)
                    PV = True if BHT[i] > 1 else False
                    if PV == True:
                        if (i == 0) and (TA_changed == True):
                            nextAddress = oldTA
                        else:
                            nextAddress = targetAddresses[i]
                else:
                    branchDetected = False
                    i = 0
            else:
                branchDetected = False
                if address in branchAddresses:
                    i = branchAddresses.index(address)
                    PV = True if BHT[i] > 1 else False
        else:
            misprediction_delayed = True
            misprediction = False
            i = 0
            if address in branchAddresses:
                branchDetected = True
                i = branchAddresses.index(address)
                PV = True if BHT[i] > 1 else False
                if PV == True:
                    if (i == 0) and (TA_changed == True):
                        nextAddress = oldTA
                    else:
                        nextAddress = targetAddresses[i]
    else:
        misprediction_delayed = False
        if branchDetected == True:
            branchEvaluated = True
            PV_delayed = PV
            index_delayed = i
            branchDetected = False
        i = 0
        if address in branchAddresses:
            branchDetected = True
            i = branchAddresses.index(address)
            PV = True if BHT[i] > 1 else False
            if PV == True:
                if (i == 0) and (TA_changed == True):
                    nextAddress = oldTA
                else:
                    nextAddress = targetAddresses[i]
    if address not in branchAddresses:
        PV = 0
    outfile.write("%d %d %d %d %d\n" % (address, branch, outcome, targetAddresses[i], PV))
    address = nextAddress
outfile.close()
