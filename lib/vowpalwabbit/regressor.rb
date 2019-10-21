module VowpalWabbit
  class Regressor < Model
    def score(x, y = nil)
      y_pred, y = predict_for_score(x, y)

      # r2
      sse = y_pred.zip(y).map { |yp, yt| (yp - yt) ** 2 }.sum
      sst = y.map { |yi| yi ** 2 }.sum - (y.sum ** 2) / y.size
      1 - sse / sst
    end

    def intercept
      FFI.VW_Get_Weight(handle, 116060, 0)
    end
  end
end
