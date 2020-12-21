//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<background_geolocation_firebase/BackgroundGeolocationFirebasePlugin.h>)
#import <background_geolocation_firebase/BackgroundGeolocationFirebasePlugin.h>
#else
@import background_geolocation_firebase;
#endif

#if __has_include(<background_fetch/BackgroundFetchPlugin.h>)
#import <background_fetch/BackgroundFetchPlugin.h>
#else
@import background_fetch;
#endif

#if __has_include(<firebase_auth/FLTFirebaseAuthPlugin.h>)
#import <firebase_auth/FLTFirebaseAuthPlugin.h>
#else
@import firebase_auth;
#endif

#if __has_include(<firebase_core/FLTFirebaseCorePlugin.h>)
#import <firebase_core/FLTFirebaseCorePlugin.h>
#else
@import firebase_core;
#endif

#if __has_include(<flutter_autofill/FlutterAutofillPlugin.h>)
#import <flutter_autofill/FlutterAutofillPlugin.h>
#else
@import flutter_autofill;
#endif

#if __has_include(<flutter_background_geolocation/FLTBackgroundGeolocationPlugin.h>)
#import <flutter_background_geolocation/FLTBackgroundGeolocationPlugin.h>
#else
@import flutter_background_geolocation;
#endif

#if __has_include(<shared_preferences/FLTSharedPreferencesPlugin.h>)
#import <shared_preferences/FLTSharedPreferencesPlugin.h>
#else
@import shared_preferences;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [BackgroundGeolocationFirebasePlugin registerWithRegistrar:[registry registrarForPlugin:@"BackgroundGeolocationFirebasePlugin"]];
  [BackgroundFetchPlugin registerWithRegistrar:[registry registrarForPlugin:@"BackgroundFetchPlugin"]];
  [FLTFirebaseAuthPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseAuthPlugin"]];
  [FLTFirebaseCorePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseCorePlugin"]];
  [FlutterAutofillPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterAutofillPlugin"]];
  [FLTBackgroundGeolocationPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTBackgroundGeolocationPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
}

@end
