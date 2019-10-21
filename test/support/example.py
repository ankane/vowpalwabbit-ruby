from vowpalwabbit import pyvw
vw = pyvw.vw(quiet=True)
ex = vw.example('1 | a b c')
vw.learn(ex)
print(vw.predict(ex))
