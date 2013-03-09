//
//  GoodClientViewController.m
//  Good Client App
//
//  Created by team breezy on 2/6/13.
//  Copyright (c) 2013 team breezy. All rights reserved.
//

#import <GD/GDiOS.h>

#import "ServiceController.h"
#import "GoodClientViewController.h"

@implementation GoodClientViewController
{
    ServiceController *_serviceController;
}
@synthesize gdLibrary = _gdLibrary;
@synthesize delegate = _delegate;
@synthesize fileTypeSegmentedControl = _fileTypeSegmentedControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set up a ServiceController
    _serviceController = [[ServiceController alloc] init];
    // Set service controller delegate
    [_serviceController setDelegate:self];
    
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clouds.png"]];
}

- (void)GDServiceClientDidFinishSendingTo:(NSString *)application withAttachments:(NSArray *)attachments withParams:(id)params correspondingToRequestID:(NSString *)requestID
{
    
}

- (void)GDServiceClientDidReceiveFrom:(NSString *)application withParams:(id)params withAttachments:(NSArray *)attachments correspondingToRequestID:(NSString *)requestID
{
    
}

#pragma mark - ServiceControllerDelegate Methods
- (void) showAlert:(id)serviceReply
{
    if ([serviceReply isKindOfClass:[NSString class]])
    {
        // The Print Service returned a defined success response...
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:serviceReply
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if ([serviceReply isKindOfClass:[NSError class]])
    {
        NSError* error = (NSError*)serviceReply;
        // The Print Service returned a defined error response...
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[error domain]
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        // The Print Service returned an unexpected response...
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Not implemented."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - Buttons Actions
- (IBAction)sendPressed:(UIButton *)sender
{
    NSError *err = nil;
    NSString *fileToPrint = [self fileInGDContainer];
    
    BOOL didSendRequest = [_serviceController printFile:fileToPrint withError:&err];
    
    if (NO == didSendRequest)
    {
        // The request could not be sent...
        [self showErrorAlert:err];
    }
}

#pragma mark - helpers
- (NSString *)fileInGDContainer
{
    // Getting test docuemtns from main bundle and saving to GD Container
    NSString *fileType = [self.fileTypeSegmentedControl titleForSegmentAtIndex:self.fileTypeSegmentedControl.selectedSegmentIndex];
    
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:fileType ofType:fileType];
    NSString *newFileName = [NSString stringWithFormat:@"test.%@", fileType];
    NSData *dataToSave = [NSData dataWithContentsOfFile:resourcePath];
    
    NSURL *filePathUrl = [NSURL fileURLWithPath:newFileName];
    NSString *filestringpath = [filePathUrl path];
    
    NSURL *savedFilePath = [[NSURL alloc] init];
    
    if([GDFileSystem writeToFile:dataToSave name:filestringpath error:nil])
    {
        savedFilePath = [[NSURL alloc] initWithString:[filestringpath lastPathComponent]];
        NSLog(@"data saved to GD %@",savedFilePath);
    }
    
    return newFileName;
}

- (void) showErrorAlert:(NSError*)goodError
{
    // Show alert with appropriate error message
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"An error occurred."
                                                    message:[goodError localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end

