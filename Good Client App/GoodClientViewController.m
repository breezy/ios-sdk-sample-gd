//
//  GoodClientViewController.m
//  Good Client App
//
//  Created by team breezy on 2/6/13.
//  Copyright (c) 2013 team breezy. All rights reserved.
//

#import "GoodClientViewController.h"

@interface GoodClientViewController ()

@end

@implementation GoodClientViewController
@synthesize gdsc = _gdsc;
@synthesize textField = _textField;
@synthesize gdLibrary = _gdLibrary;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)sendPressed:(UIButton *)sender
{
    NSError *err = nil;
    
    _gdsc = [GDServiceClient new];
    _gdsc.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
    
    BOOL OKsofar = [GDFileSystem createDirectoryAtPath:@"/Hello/my"
                           withIntermediateDirectories:YES
                                            attributes:nil
                                                 error:&err];
    if (OKsofar) {
        NSLog( @"Directory created OK\n" );
    }
    else {
        NSLog( @"Directory not created \"%@\"\n", [err localizedDescription] );
    }
    
    NSString *helloStr = self.textField.text;
    
    NSData *textFieldStrAsData =
    [helloStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    OKsofar = [GDFileSystem writeToFile:textFieldStrAsData
                                   name:@"/Hello/my/world.txt"
                                  error:&err];
    
    if (OKsofar) {
        NSLog( @"Wrote OK\n" );
    }
    else {
        NSLog( @"Not written \"%@\"\n", [err localizedDescription] );
    }
    
    [GDFileSystem writeToFile:textFieldStrAsData name:@"/Hello/my/world.txt" error:&err];
    
    NSString *textFile = @"/Hello/my/world.txt";
    
    self.gdLibrary = [GDiOS sharedInstance];
    
//    NSArray *clientSVC = [self.gdLibrary getApplicationDetailsForService:<#(NSString *)#> andVersion:@"1.0.0.0"]
//
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"TEXT", 1, nil];
//    
//    NSArray *attachments = [NSArray arrayWithObjects:textFieldStrAsData, nil];
//    
//    [GDServiceClient sendTo:<#(NSString *)#> withService:<#(NSString *)#> withVersion:<#(NSString *)#> withMethod:<#(NSString *)#> withParams:params withAttachments:attachments bringServiceToFront:GDEPreferPeerInForeground requestID:requestId error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
