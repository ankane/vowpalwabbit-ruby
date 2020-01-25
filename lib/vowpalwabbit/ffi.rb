module VowpalWabbit
  module FFI
    extend ::FFI::Library

    begin
      ffi_lib VowpalWabbit.ffi_lib
    rescue LoadError => e
      raise e #if ENV["VOWPALWABBIT_DEBUG"]
      raise LoadError, "Could not find Vowpal Wabbit"
    end

    # https://github.com/VowpalWabbit/vowpal_wabbit/blob/master/vowpalwabbit/vwdll.h
    # keep same order

    attach_function :VW_InitializeA, %i[string], :pointer
    attach_function :VW_InitializeWithModel, %i[string pointer size_t], :pointer
    attach_function :VW_SeedWithModel, %i[pointer string], :pointer
    attach_function :VW_Finish_Passes, %i[pointer], :void
    attach_function :VW_Finish, %i[pointer], :void
    attach_function :VW_ImportExample, %i[pointer string pointer size_t], :pointer
    attach_function :VW_ReadExampleA, %i[pointer string], :pointer
    attach_function :VW_StartParser, %i[pointer], :void
    attach_function :VW_EndParser, %i[pointer], :void
    attach_function :VW_GetExample, %i[pointer], :pointer
    attach_function :VW_FinishExample, %i[pointer pointer], :void
    attach_function :VW_GetLabel, %i[pointer], :float
    attach_function :VW_GetFeatureNumber, %i[pointer], :size_t
    attach_function :VW_GetFeatures, %i[pointer pointer pointer], :pointer
    attach_function :VW_HashSpaceA, %i[pointer string], :size_t
    attach_function :VW_Learn, %i[pointer pointer], :float
    attach_function :VW_Predict, %i[pointer pointer], :float
    attach_function :VW_PredictCostSensitive, %i[pointer pointer], :float
    attach_function :VW_Get_Weight, %i[pointer size_t size_t], :float
    attach_function :VW_Set_Weight, %i[pointer size_t size_t float], :void
    attach_function :VW_Num_Weights, %i[pointer], :size_t
    attach_function :VW_Get_Stride, %i[pointer], :size_t
    attach_function :VW_SaveModel, %i[pointer], :void
    attach_function :VW_CopyModelData, %i[pointer pointer pointer pointer], :void
    attach_function :VW_FreeIOBuf, %i[pointer], :void
  end
end
