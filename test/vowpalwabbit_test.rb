require_relative "test_helper"

class VowpalWabbitTest < Minitest::Test
  def test_regressor
    x = [[1, 2], [3, 4], [5, 6], [7, 8]]
    y = [1, 2, 3, 4]

    model = VowpalWabbit::Regressor.new(learning_rate: 100, power_t: 1)
    assert_nil model.fit(x, y)

    tempfile = Tempfile.new("vowpal-wabbit")
    assert_nil model.save(tempfile.path)
    model = VowpalWabbit::Regressor.load(tempfile.path)

    assert_in_delta 0.3333333432674408, model.intercept
    assert_equal [1.0, 2.0, 3.0, 4.0], model.predict(x)
    assert_equal 1.0, model.score(x, y)
  end

  def test_classifier
    x = [[1, 2], [3, 4], [5, 6], [7, 8]]
    y = [-1, -1, 1, 1]

    model = VowpalWabbit::Classifier.new(loss_function: "logistic", learning_rate: 0.01, l2: 0.1)
    assert_nil model.fit(x, y)

    tempfile = Tempfile.new("vowpal-wabbit")
    assert_nil model.save_model(tempfile.path)
    model = VowpalWabbit::Classifier.load(tempfile.path)

    assert_equal [-1, -1, -1, -1], model.predict(x)
    assert_equal 0.5, model.score(x, y)
  end

  def test_regressor_file
    model = VowpalWabbit::Regressor.new(learning_rate: 100, power_t: 1)
    assert_nil model.fit("test/support/regressor.txt")
    assert_in_delta 0.3333333432674408, model.intercept
    assert_equal [1.0, 2.0, 3.0, 4.0], model.predict("test/support/regressor.txt")
    assert_equal 1.0, model.score("test/support/regressor.txt")
  end

  def test_classifier_file
    model = VowpalWabbit::Classifier.new(loss_function: "logistic", learning_rate: 0.01, l2: 0.1)
    assert_nil model.fit("test/support/classifier.txt")
    assert_equal [-1, -1, -1, -1], model.predict("test/support/classifier.txt")
    assert_equal 0.5, model.score("test/support/classifier.txt")
  end

  def test_compressed_file
    model = VowpalWabbit::Regressor.new(l: 100, power_t: 1)
    assert_nil model.fit("test/support/regressor.txt.gz")
    assert_in_delta 0.3333333432674408, model.intercept
    assert_equal [1.0, 2.0, 3.0, 4.0], model.predict("test/support/regressor.txt.gz")
    assert_equal 1.0, model.score("test/support/regressor.txt.gz")
  end

  def test_bandit
    x_train = [
      "1:2:0.4 | a c",
      "3:0:0.2 | b d",
      "4:1:0.5 | a b",
      "2:1:0.3 | a b c",
      "3:1:0.7 | a d"
    ]
    x_test = [
      "| b c",
      "| a b",
      "| b b",
      "| a b"
    ]

    model = VowpalWabbit::Model.new(cb: 4)
    model.fit(x_train)
    assert_equal [3.0, 3.0, 3.0, 3.0], model.predict(x_test)
  end

  def test_numo
    skip if RUBY_PLATFORM == "java"

    x = Numo::DFloat.cast([[1, 2], [3, 4], [5, 6], [7, 8]])
    y = Numo::DFloat.cast([1, 2, 3, 4])

    model = VowpalWabbit::Regressor.new(l: 100, power_t: 1)
    assert_nil model.fit(x, y)
    assert_in_delta 0.3333333432674408, model.intercept
    assert_equal [1.0, 2.0, 3.0, 4.0], model.predict(x)
    assert_equal 1.0, model.score(x, y)
  end

  def test_bad_params
    error = assert_raises ArgumentError do
      VowpalWabbit::Model.new(cb: "4 hello").fit([""])
    end
    assert_equal "Invalid parameter", error.message
  end

  def test_file_y
    model = VowpalWabbit::Regressor.new
    error = assert_raises ArgumentError do
      model.fit("test/support/regressor.txt", [1, 2, 3])
    end
    assert_equal "Cannot pass y with file", error.message
  end

  def test_different_sizes
    model = VowpalWabbit::Regressor.new
    error = assert_raises ArgumentError do
      model.fit([[1], [2]], [1])
    end
    assert_equal "x and y must have same size", error.message
  end
end
