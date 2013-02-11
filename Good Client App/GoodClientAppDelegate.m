//
//  GoodClientAppDelegate.m
//  Good Client App
//
//  Created by team breezy on 2/6/13.
//  Copyright (c) 2013 team breezy. All rights reserved.
//

#import "GoodClientAppDelegate.h"

@implementation GoodClientAppDelegate
@synthesize window = _window;
@synthesize gdLibrary = _gdLibrary;

NSString* kappId = @"com.breezy.good.test";
NSString* kappVersion = @"1.0";

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.gdLibrary = [GDiOS sharedInstance];
    _gdLibrary.delegate = self;
    [_gdLibrary authorise:kappId andVersion:kappVersion];
    
    return YES;
}

- (UIWindow *)window
{
    return [[GDiOS sharedInstance] getWindow];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark Good Libraries application lifecycle

- (void)onNotAuthorised:(GDAppEvent *)anEvent
{
    // Application is not authorised...
    switch (anEvent.code) {
        case GDErrorActivationFailed:
        case GDErrorProvisioningFailed:
        case GDErrorPushConnectionTimeout:
        case GDErrorProvisioningCancelled: {
            [_gdLibrary authorise:kappId andVersion:kappVersion];
            break;
        }
        case GDErrorSecurityError:
        case GDErrorAppDenied:
        case GDErrorBlocked:
        case GDErrorWiped:
        case GDErrorRemoteLockout:
        case GDErrorPasswordChangeRequired: {
            NSLog(@"onNotAuthorised %@", anEvent.message);
            break;
        }
        case GDErrorIdleLockout: {
            // idle lockout is benign & informational so don't show an alert
            break;
        }
        default:
            NSAssert(false, @"Unhandled authorisation event");
            break;
    }
}

-(void) onAuthorised:(GDAppEvent*)anEvent {
    /* Handle the Good Libraries authorised event. */
    
    switch (anEvent.code) {
        case GDErrorNone: {
            if (!started) {
                // launch application UI here
                started = YES;
            }
            break;
        }
        default:
            NSAssert(false, @"Authorised startup with an error");
            break;
    }
}

-(void)handleEvent:(GDAppEvent*)anEvent {
    // Called from gdLibrary when events occur, such as authorisation.
    switch (anEvent.type) {
        case GDAppEventAuthorised:
        {
            [self onAuthorised:anEvent];
            break;
        }
        case GDAppEventNotAuthorised:
        {
            [self onNotAuthorised:anEvent];
            break;
        }
        default:
        {
            // This app is not interested in any other type of event.
            break;
        }
    }
}

@end
