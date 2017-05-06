# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Applications/development application/android-sdk-macosx/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}
-target 1.7
-optimizationpasses 5
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontskipnonpubliclibraryclassmembers
-dontpreverify
-verbose
-dontobfuscate
-dontoptimize
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class com.android.vending.licensing.ILicensingService

-keepclasseswithmembernames class * {
    native <methods>;
}

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

# adding this in to preserve line numbers so that the stack traces
# can be remapped
-renamesourcefileattribute SourceFile
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod

-keep class com.google.gson.** { *; }
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}
##---------------Begin: proguard configuration for Gson  ----------
# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
#-keepattributes Signature
# Gson specific classes
-keep class sun.misc.Unsafe { *; }
#-keep class com.google.gson.stream.** { *; }
# Application classes that will be serialized/deserialized over Gson
-keep class com.google.gson.examples.android.model.** { *; }
-keep class com.oupinwu.o2o.buyer.android.bean.* { *; }
-keep class com.oupinwu.o2o.buyer.android.utils.http.CallbackBean { *; }

-dontwarn retrofit.**
-keep class retrofit.** { *; }
-keep class retrofit.http.** { *; }
-keep class retrofit.client.** { *; }
-keep class com.google.inject.* { *; }
-keep class org.apache.http.* { *; }
-keep class javax.inject.* { *; }
#-keepattributes Signature
#-keepattributes Exceptions

-dontwarn com.squareup.okhttp.**
-keep class com.squareup.okhttp.** { *;}
-dontwarn okio.**

#-libraryjars ../utilsLibrary/libs/libammsdk.jar
-keep class com.tencent.mm.sdk.** { *; }

#-libraryjars ../utilsLibrary/libs/CordovaLib.jar
-dontwarn org.apache.cordova.**
-keep class org.apache.cordova.** {*;}

#-libraryjars ../utilsLibrary/libs/zxing.jar
-dontwarn com.google.zxing.**
-keep class com.google.zxing.** {*;}

#-libraryjars ../utilsLibrary/libs/alipaySDK-20150818.jar
-keep class com.alipay.android.app.IAlixPay{*;}
-keep class com.alipay.android.app.IAlixPay$Stub{*;}
-keep class com.alipay.android.app.IRemoteServiceCallback{*;}
-keep class com.alipay.android.app.IRemoteServiceCallback$Stub{*;}
-keep class com.alipay.sdk.app.PayTask{ public *;}
-keep class com.alipay.sdk.app.AuthTask{ public *;}
-dontwarn com.alipay.**

#-libraryjars ../utilsLibrary/libs/BaiduLBS_Android.jar
-dontwarn com.baidu.**
-keep class com.baidu.** { *; }
-keep class vi.com.gdi.bgl.** { *; }

-dontwarn android.support.v4.**
-keep class android.support.v4.** { *; }
-keep interface android.support.v4.app.** { *; }
-keep public class * extends android.support.v4.**
-keep public class * extends android.app.Fragment

#Javascript
-keepclassmembers class com.yldbkd.www.buyer.android.activity.ZoneJSActivity$JSObject { public *; }

# 以下两行为在Android4.2版本以上的手机必须加入的对注解进行处理的配置
-keepattributes *Annotation*
-keepattributes *JavascriptInterface*

#友盟
-keepclassmembers class * {
   public <init> (org.json.JSONObject);
}
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-keep public class com.yldbkd.www.buyer.android.R$*{
    public static final int *;
}

#个推
-dontwarn com.igexin.**
-keep class com.igexin.** { *; }
