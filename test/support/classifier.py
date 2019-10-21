from vowpalwabbit.sklearn_vw import VWClassifier

X = [[1, 2], [3, 4], [5, 6], [7, 8]]
y = [-1, -1, 1, 1]

model = VWClassifier(loss_function='logistic', l=0.01, l2=0.1)
model.fit(X, y)

print(model.predict(X))
print(model.score(X, y))
