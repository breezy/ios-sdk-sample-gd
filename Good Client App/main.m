//
//  main.m
//  Good Client App
//
//  Created by team breezy on 2/6/13.
//  Copyright (c) 2013 team breezy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GD/GDiOS.h>

#import "GoodClientAppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        [GDiOS initialiseWithClassConformingToUIApplicationDelegate:[GoodClientAppDelegate class]];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([GoodClientAppDelegate class]));
        [GDiOS finalise];
    }
}
