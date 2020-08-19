module VowpalWabbit
  class Model
    def initialize(**params)
      # add strict parse once exceptions are handled properly
      # https://github.com/VowpalWabbit/vowpal_wabbit/issues/2004
      @params = {quiet: true}.merge(params)
    end

    def fit(x, y = nil)
      @handle = nil
      partial_fit(x, y)
    end

    def partial_fit(x, y = nil)
      each_example(x, y) do |example|
        FFI.VW_Learn(handle, example)
      end
      nil
    end

    def predict(x)
      out = []
      each_example(x) do |example|
        out << predict_example(example)
      end
      out
    end

    def coefs
      num_weights = FFI.VW_Num_Weights(handle)
      coefs = {}
      num_weights.times.map do |i|
        weight = FFI.VW_Get_Weight(handle, i, 0)
        coefs[i] = weight if weight != 0
      end
      coefs
    end

    def save_model(filename)
      buffer_handle = ::FFI::MemoryPointer.new(:pointer)
      output_data = ::FFI::MemoryPointer.new(:pointer)
      output_size = ::FFI::MemoryPointer.new(:size_t)
      FFI.VW_CopyModelData(handle, buffer_handle, output_data, output_size)
      bin_str = output_data.read_pointer.read_string(output_size.read(:size_t))
      FFI.VW_FreeIOBuf(buffer_handle.read_pointer)
      File.binwrite(filename, bin_str)
      nil
    end

    def load_model(filename)
      bin_str = File.binread(filename)
      model_data = ::FFI::MemoryPointer.new(:char, bin_str.bytesize)
      model_data.put_bytes(0, bin_str)
      @handle = FFI.VW_InitializeWithModel(param_str(@params), model_data, bin_str.bytesize)
      nil
    end

    private

    # TODO clean-up handle
    def handle
      @handle ||= FFI.VW_InitializeA(param_str(@params))
    end

    def param_str(params)
      args =
        params.flat_map do |k, v|
          check_param(k.to_s)
          check_param(v.to_s)

          if v == true
            ["--#{k}"]
          elsif !v
            []
          elsif k.size == 1
            ["-#{k}", v]
          else
            ["--#{k}", v]
          end
        end
      args.join(" ")
    end

    def check_param(v)
      raise ArgumentError, "Invalid parameter" if /[[:space:]]/.match(v)
    end

    def predict_example(example)
      if @params[:cb]
        FFI.VW_PredictCostSensitive(handle, example)
      else
        FFI.VW_Predict(handle, example)
      end
    end

    # get both in one pass for efficiency
    def predict_for_score(x, y)
      if x.is_a?(String) && !y
        y_pred = []
        y = []
        each_example(x) do |example|
          y_pred << predict_example(example)
          y << FFI.VW_GetLabel(example)
        end
        [y_pred, y]
      else
        [predict(x), y]
      end
    end

    def each_example(x, y = nil)
      # path to a file
      if x.is_a?(String)
        raise ArgumentError, "Cannot pass y with file" if y

        file_handle = FFI.VW_InitializeA(param_str(data: x, quiet: true))
        FFI.VW_StartParser(file_handle)
        loop do
          example = FFI.VW_GetExample(file_handle)
          break if example.read_pointer.null?
          yield example
          FFI.VW_FinishExample(file_handle, example)
        end
        FFI.VW_EndParser(file_handle)
        FFI.VW_Finish(file_handle)
      else
        x = x.to_a
        if y
          y = y.to_a
          raise ArgumentError, "x and y must have same size" if x.size != y.size
        end

        x.zip(y || []) do |xi, yi|
          line =
            if xi.is_a?(String)
              xi
            else
              "#{yi} 1 | #{xi.map.with_index { |v, i| "#{i}:#{v}" }.join(" ")}"
            end

          example = FFI.VW_ReadExampleA(handle, line)
          yield example
          FFI.VW_FinishExample(handle, example)
        end
      end
    end
  end
end
