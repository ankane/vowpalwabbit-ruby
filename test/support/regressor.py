from vowpalwabbit.sklearn_vw import VWRegressor

X = [[1, 2], [3, 4], [5, 6], [7, 8]]
y = [1, 2, 3, 4]

model = VWRegressor(l=100)
model.fit(X, y)
print(model.predict(X))
model.save("/tmp/train.model")

model2 = VWRegressor(l=100)
model2.load("/tmp/train.model")
print(model2.predict(X))
