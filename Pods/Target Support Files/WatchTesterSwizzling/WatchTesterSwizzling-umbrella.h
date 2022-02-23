#ifdef __OBJC__
#import <Foundation/Foundation.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GREYDefines.h"
#import "GREYFatalAsserts.h"
#import "GREYSurrogateDelegate.h"
#import "GREYSwizzler.h"
#import "Macros.h"
#import "CMMotionManager+Additions.h"
#import "CMAccelerometerData+Additions.h"
#import "CMDeviceMotion+Additions.h"
#import "HKWorkoutSession+Additions.h"
#import "HKWorkoutSessionDelegateProxy.h"
#import "UNNotificationSettings+Additions.h"
#import "UNUserNotificationCenter+Additions.h"
#import "UNUserNotificationCenterDelegateProxy.h"
#import "WKInterfaceController+Additions.h"
#import "WKInterfaceDevice+Additions.h"
#import "MockupsFactory.h"
#import "WatchTesterSwizzling.h"

FOUNDATION_EXPORT double WatchTesterSwizzlingVersionNumber;
FOUNDATION_EXPORT const unsigned char WatchTesterSwizzlingVersionString[];

