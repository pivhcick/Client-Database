# ===============================================
# Flutter Local Notifications ProGuard Rules
# ===============================================
# CRITICAL: These rules prevent R8 from removing generic type information
# that flutter_local_notifications needs for Gson serialization

# 1. Keep ALL flutter_local_notifications classes completely untouched
-keep,allowobfuscation class com.dexterous.** { *; }
-keepnames class com.dexterous.** { *; }

# 2. Keep ALL Gson classes and their generic signatures
-keep class com.google.gson.** { *; }
-keepnames class com.google.gson.** { *; }
-keep class com.google.gson.reflect.TypeToken { *; }
-keep class * extends com.google.gson.reflect.TypeToken { *; }
-keep public class * implements java.lang.reflect.Type { *; }

# 3. CRITICAL: Keep all generic signatures in entire app
# Without this, TypeToken cannot work
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes InnerClasses

# 4. Keep all Gson annotations
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
    @com.google.gson.annotations.Expose <fields>;
}

# 5. Keep model classes that might be serialized
-keep class com.dexterous.flutterlocalnotifications.models.** { *; }
-keepclassmembers class com.dexterous.flutterlocalnotifications.models.** { *; }

# 6. Prevent R8 from removing fields with @SerializedName
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# 7. Gson internal classes
-dontwarn sun.misc.**
-keep class sun.misc.Unsafe { *; }

# 8. Keep generic signatures for ALL classes that might be serialized
# This is a broad rule but necessary for TypeToken to work
-keepattributes Signature
-keep class * implements java.io.Serializable { *; }

# 9. Additional safety: Keep all constructors for classes that might be deserialized
-keepclassmembers class * {
    <init>(...);
}
