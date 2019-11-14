# Vowpal Wabbit

[Vowpal Wabbit](https://vowpalwabbit.org) - fast online machine learning - for Ruby

:fire: Uses the C API for blazing performance

[![Build Status](https://travis-ci.org/ankane/vowpalwabbit.svg?branch=master)](https://travis-ci.org/ankane/vowpalwabbit)

## Installation

First, install the [Vowpal Wabbit C++ library](https://vowpalwabbit.org/start.html). For Homebrew, use:

```sh
brew install vowpal-wabbit
```

Add this line to your application’s Gemfile:

```ruby
gem 'vowpalwabbit'
```

## Getting Started

Prep your data

```ruby
x = [[1, 2], [3, 4], [5, 6], [7, 8]]
y = [1, 2, 3, 4]
```

Train a model

```ruby
model = VowpalWabbit::Regressor.new(learning_rate: 100)
model.fit(x, y)
```

Use `VowpalWabbit::Classifier` for classification and `VowpalWabbit::Model` for other models

Make predictions

```ruby
model.predict(x)
```

Save the model to a file

```ruby
model.save_model("model.bin")
```

Load the model from a file

```ruby
model.load_model("model.bin")
```

Train online

```ruby
model.partial_fit(x, y)
```

Get the intercept and coefficients

```ruby
model.intercept
model.coefs
```

Score - R-squared for regression and accuracy for classification

```ruby
model.score(x, y)
```

## Parameters

Specify parameters

```ruby
model = VowpalWabbit::Model.new(cb: 4)
```

Supports the same parameters as the [CLI](https://github.com/VowpalWabbit/vowpal_wabbit/wiki/Command-Line-Arguments)

## Data

Data can be an array of arrays

```ruby
[[1, 2, 3], [4, 5, 6]]
```

Or a Numo NArray

```ruby
Numo::DFloat.new(3, 2).seq
```

Or an array of strings

```ruby
[
  "0 | price:.23 sqft:.25 age:.05 2006",
  "1 2 'second_house | price:.18 sqft:.15 age:.35 1976",
  "0 1 0.5 'third_house | price:.53 sqft:.32 age:.87 1924"
]
```

Or a path to a file

```ruby
model.fit("train.txt")
model.partial_fit("train.txt")
model.predict("train.txt")
model.score("train.txt")
```

Files can be compressed

```ruby
model.fit("train.txt.gz")
```

Read more about the [input format](https://github.com/VowpalWabbit/vowpal_wabbit/wiki/Input-format)

## History

View the [changelog](https://github.com/ankane/vowpalwabbit/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/vowpalwabbit/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/vowpalwabbit/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development and testing:

```sh
git clone https://github.com/ankane/vowpalwabbit.git
cd vowpalwabbit
bundle install
bundle exec rake test
```
