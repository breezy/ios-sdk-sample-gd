//
//  GoodClientViewController.h
//  Good Client App
//
//  Created by team breezy on 2/6/13.
//  Copyright (c) 2013 team breezy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GD/GDiOS.h>
#import <GD/GDServices.h>
#import <GD/GDFileSystem.h>
#import "Protocols.h"

@interface GoodClientViewController : UIViewController <GDServiceClientDelegate, ServiceControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (nonatomic, assign) GDServiceClient *gdsc;
@property (nonatomic, assign) GDiOS *gdLibrary;
@property (nonatomic, assign) id <GDServiceClientDelegate> delegate;
@property (nonatomic, assign) id <GoodClientViewControllerDelegate> gcvcDelegate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fileTypeSegmentedControl;

- (IBAction)sendPressed:(UIButton *)sender;

@end