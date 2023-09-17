#import "SyntonicComponentsPlugin.h"
#if __has_include(<syntonic_components/syntonic_components-Swift.h>)
#import <syntonic_components/syntonic_components-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "syntonic_components-Swift.h"
#endif

@implementation SyntonicComponentsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSyntonicComponentsPlugin registerWithRegistrar:registrar];
}
@end
