//
//  ServiceController.h
//  Good Client App
//
//  Created by team breezy on 2/18/13.
//  Copyright (c) 2013 team breezy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GD/GDServices.h>

@class ViewController;
@class RootViewController;

typedef enum {
    PrintFile,
    BringServiceAppToFront,
} ClientRequestType;

@protocol ServiceControllerDelegate <NSObject>

-(void)showAlert:(id)serviceReply;

@end

@interface ServiceController : NSObject <GDServiceClientDelegate, GDServiceDelegate>

@property (nonatomic) id <ServiceControllerDelegate> delegate;
@property (strong, nonatomic) GDServiceClient *goodServiceClient;
@property (strong, nonatomic) GDService *goodServiceServer;

- (BOOL) sendRequest:(NSError**)error requestType:(ClientRequestType)type sendTo:(NSString*)appId;

@end
