# TensorFlow Lite GPU
-keep class org.tensorflow.lite.gpu.** { *; }
-keep class org.tensorflow.lite.gpu.GpuDelegateFactory$Options { *; }
-keep class org.tensorflow.lite.gpu.GpuDelegate$Options { *; }

# Suppress warnings for the missing class
-dontwarn org.tensorflow.lite.gpu.GpuDelegateFactory$Options
