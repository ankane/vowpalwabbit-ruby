module VowpalWabbit
  module FFI
    extend Fiddle::Importer

    libs = VowpalWabbit.ffi_lib.dup
    begin
      dlload libs.shift
    rescue Fiddle::DLError => e
      retry if libs.any?
      raise e if ENV["VOWPALWABBIT_DEBUG"]
      raise LoadError, "Could not find Vowpal Wabbit"
    end

    typealias "VW_HANDLE", "void**"
    typealias "VW_EXAMPLE", "void**"
    typealias "VW_LABEL", "void**"
    typealias "VW_FEATURE_SPACE", "void**"
    typealias "VW_FEATURE", "void**"
    typealias "VW_IOBUF", "void**"

    # https://github.com/VowpalWabbit/vowpal_wabbit/blob/master/vowpalwabbit/vwdll.h
    # keep same order

    extern "VW_HANDLE VW_CALLING_CONV VW_InitializeA(char* pstrArgs)"
    extern "VW_HANDLE VW_CALLING_CONV VW_InitializeWithModel(char* pstrArgs, char* modelData, size_t modelDataSize)"
    extern "VW_HANDLE VW_CALLING_CONV VW_SeedWithModel(VW_HANDLE handle, char* extraArgs)"
    extern "void* VW_CALLING_CONV VW_Finish_Passes(VW_HANDLE handle)"
    extern "void* VW_CALLING_CONV VW_Finish(VW_HANDLE handle)"
    extern "VW_EXAMPLE VW_CALLING_CONV VW_ImportExample(VW_HANDLE handle, char* label, VW_FEATURE_SPACE features, size_t len)"
    extern "VW_FEATURE_SPACE VW_CALLING_CONV VW_InitializeFeatureSpaces(size_t len)"
    extern "VW_FEATURE_SPACE VW_CALLING_CONV VW_GetFeatureSpace(VW_FEATURE_SPACE first, size_t index)"
    extern "VW_FEATURE_SPACE VW_CALLING_CONV VW_ExportExample(VW_HANDLE handle, VW_EXAMPLE e, size_t* plen)"
    extern "void* VW_CALLING_CONV VW_ReleaseFeatureSpace(VW_FEATURE_SPACE features, size_t len)"
    extern "VW_EXAMPLE VW_CALLING_CONV VW_ReadExampleA(VW_HANDLE handle, char* line)"
    extern "void* VW_CALLING_CONV VW_StartParser(VW_HANDLE handle)"
    extern "void* VW_CALLING_CONV VW_EndParser(VW_HANDLE handle)"
    extern "VW_EXAMPLE VW_CALLING_CONV VW_GetExample(VW_HANDLE handle)"
    extern "void* VW_CALLING_CONV VW_FinishExample(VW_HANDLE handle, VW_EXAMPLE e)"
    extern "float VW_CALLING_CONV VW_GetLabel(VW_EXAMPLE e)"
    extern "float VW_CALLING_CONV VW_GetImportance(VW_EXAMPLE e)"
    extern "float VW_CALLING_CONV VW_GetInitial(VW_EXAMPLE e)"
    extern "float VW_CALLING_CONV VW_GetPrediction(VW_EXAMPLE e)"
    extern "float VW_CALLING_CONV VW_GetCostSensitivePrediction(VW_EXAMPLE e)"
    extern "void** VW_CALLING_CONV VW_GetMultilabelPredictions(VW_EXAMPLE e, size_t* plen)"
    extern "float VW_CALLING_CONV VW_GetTopicPrediction(VW_EXAMPLE e, size_t i)"
    extern "float VW_CALLING_CONV VW_GetActionScore(VW_EXAMPLE e, size_t i)"
    extern "size_t VW_CALLING_CONV VW_GetActionScoreLength(VW_EXAMPLE e)"
    extern "size_t VW_CALLING_CONV VW_GetTagLength(VW_EXAMPLE e)"
    extern "char* VW_CALLING_CONV VW_GetTag(VW_EXAMPLE e)"
    extern "size_t VW_CALLING_CONV VW_GetFeatureNumber(VW_EXAMPLE e)"
    extern "float VW_CALLING_CONV VW_GetConfidence(VW_EXAMPLE e)"
    extern "size_t VW_CALLING_CONV VW_SetFeatureSpace(VW_HANDLE handle, VW_FEATURE_SPACE feature_space, char* name)"
    extern "void* VW_CALLING_CONV VW_InitFeatures(VW_FEATURE_SPACE feature_space, size_t features_count)"
    extern "VW_FEATURE VW_CALLING_CONV VW_GetFeature(VW_FEATURE_SPACE feature_space, size_t index)"
    extern "void* VW_CALLING_CONV VW_SetFeature(VW_FEATURE feature, size_t index, size_t feature_hash, float value)"
    extern "VW_FEATURE VW_CALLING_CONV VW_GetFeatures(VW_HANDLE handle, VW_EXAMPLE e, size_t* plen)"
    extern "void* VW_CALLING_CONV VW_ReturnFeatures(VW_FEATURE f)"
    extern "size_t VW_CALLING_CONV VW_HashSpaceA(VW_HANDLE handle, char* s)"
    extern "size_t VW_CALLING_CONV VW_HashSpaceStaticA(char* s, char* h)"
    extern "size_t VW_CALLING_CONV VW_HashFeatureA(VW_HANDLE handle, char* s, size_t u)"
    extern "size_t VW_CALLING_CONV VW_HashFeatureStaticA(char* s, size_t u, char* h, unsigned int num_bits)"
    extern "float VW_CALLING_CONV VW_Learn(VW_HANDLE handle, VW_EXAMPLE e)"
    extern "float VW_CALLING_CONV VW_Predict(VW_HANDLE handle, VW_EXAMPLE e)"
    extern "float VW_CALLING_CONV VW_PredictCostSensitive(VW_HANDLE handle, VW_EXAMPLE e)"
    extern "float VW_CALLING_CONV VW_Get_Weight(VW_HANDLE handle, size_t index, size_t offset)"
    extern "void* VW_CALLING_CONV VW_Set_Weight(VW_HANDLE handle, size_t index, size_t offset, float value)"
    extern "size_t VW_CALLING_CONV VW_Num_Weights(VW_HANDLE handle)"
    extern "size_t VW_CALLING_CONV VW_Get_Stride(VW_HANDLE handle)"
    extern "void* VW_CALLING_CONV VW_SaveModel(VW_HANDLE handle)"
    extern "void* VW_CALLING_CONV VW_CopyModelData(VW_HANDLE handle, VW_IOBUF* bufferHandle, char** outputData, size_t* outputSize)"
    extern "void* VW_CALLING_CONV VW_FreeIOBuf(VW_IOBUF bufferHandle)"
  end
end
