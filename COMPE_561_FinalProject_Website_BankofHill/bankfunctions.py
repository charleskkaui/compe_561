

def getTransaction(a, b):
    return a-b

def getCreditPayment():
    pass



cardapr = "Get From Highest Value in the CC page Based on Card?"
if credit>=900:
    apr = 0.5 * cardapr
elif credit<900:
    apr = 0.6 * cardapr
elif credit < 800:
    apr = 0.7 * cardapr
elif credit < 700:
    apr = 0.8 * cardapr
else:
    apr = 0.9 * cardapr