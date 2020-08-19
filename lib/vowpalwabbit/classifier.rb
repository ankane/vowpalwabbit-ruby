module VowpalWabbit
  class Classifier < Model
    def initialize(**params)
      super(loss_function: "logistic", **params)
    end

    def predict(x)
      predictions = super
      predictions.map { |v| v >= 0 ? 1 : -1 }
    end

    def score(x, y = nil)
      y_pred, y = predict_for_score(x, y)
      y_pred.map! { |v| v >= 0 ? 1 : -1 }
      y_pred.zip(y).select { |yp, yt| yp == yt }.count / y.count.to_f
    end
  end
end
