//
//  GoodClientAppDelegate.h
//  Good Client App
//
//  Created by team breezy on 2/6/13.
//  Copyright (c) 2013 team breezy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GD/GDiOS.h>

@interface GoodClientAppDelegate : UIResponder <UIApplicationDelegate, GDiOSDelegate>
{
    BOOL started;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) GDiOS *gdLibrary;

@end
