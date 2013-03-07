//
//  ServiceController.m
//  Good Client App
//
//  Created by team breezy on 2/18/13.
//  Copyright (c) 2013 team breezy. All rights reserved.
//

@class ServiceController;
@class GoodClientViewController;

@protocol ServiceControllerDelegate <NSObject>
-(void)showAlert:(id)serviceReply;
@end

@protocol GoodClientViewControllerDelegate <NSObject>
-(void)fileTypeSelected:(NSString *)type;
@end