//
//  GoodClientViewController.h
//  Good Client App
//
//  Created by team breezy on 2/6/13.
//  Copyright (c) 2013 team breezy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ServiceController.h"
#import <GD/GDiOS.h>

#import <GD/GDFileSystem.h>

@interface GoodClientViewController : UIViewController <ServiceControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *printButton;
@property (strong, nonatomic) IBOutlet UIButton *transferButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fileTypeSegmentedControl;

- (IBAction)printPressed:(id)sender;
- (IBAction)transferPressed:(id)sender;

@end