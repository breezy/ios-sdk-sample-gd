//
//  ServiceController.m
//  Good Client App
//
//  Created by team breezy on 2/18/13.
//  Copyright (c) 2013 team breezy. All rights reserved.
//

#import "ServiceController.h"
#import "GoodClientAppDelegate.h"
#import <GD/GDFileSystem.h>
#import <GD/GDSecureDocs.h>
#import <GD/GDAppDetail.h>


@implementation ServiceController {
    NSString *fileType;
    NSString *fileToPrint;
}

@synthesize goodServiceClient = _goodServiceClient;
@synthesize delegate = _delegate;
@synthesize goodServiceServer = _goodServiceServer;

// error descriptions relating to the front request service
NSString* const kServiceNotImplementedDescription = @"The requested service is not implemented.";
NSString* const kMethodNotImplementedDescription = @"The requested method is not implemented.";

// TransferServiceId and TransferServiceVersion
NSString* const kTransferServiceId = @"com.good.gdservice.transfer-file";
NSString* const kTransferServiceVersion = @"1.0.0.0";

- (id) init
{
    
    self = [super init];
    fileToPrint = [[NSString alloc] init];
    _goodServiceClient = [[GDServiceClient alloc] init];
    _goodServiceClient.delegate = self;
    
    _goodServiceServer = [[GDService alloc] init];
    _goodServiceServer.delegate = self;
    
    return self;
}

/*
 * This method will test the service ID of an incoming request and consume a front request. Although the current service
 * definition only has one method we should check anyway as later versions may add methods.
 *
 */

+ (void) sendErrorTo:(NSString*)application withError:(NSError*)error
{
    NSError* goodError = nil;
    BOOL didSendErrorResponse = [GDService replyTo:application
                                        withParams:error
                                bringClientToFront:GDEPreferMeInForeground
                                   withAttachments:nil
                                         requestID:nil
                                             error:&goodError];
    if (!didSendErrorResponse)
    {
        if(goodError != nil)
        {
            // A Good run-time error occured while sending either a success or error response.
            // Display the Good run-time error.
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[goodError localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}


+ (BOOL)consumeFrontRequestService:(NSString*) serviceID forApplication:(NSString*) application forMethod:(NSString*) method withVersion:(NSString*)version
{
    if([serviceID isEqual:GDFrontRequestService] && [version isEqual:@"1.0.0.0"])
    {
        if([method isEqual:GDFrontRequestMethod])
        {
            [GDServiceClient bringToFront:application error:nil];
        }
        else
        {
            // method not supported so return an error
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue: kMethodNotImplementedDescription forKey:NSLocalizedDescriptionKey];
            NSError* serviceError = [[NSError alloc] initWithDomain:GDServicesErrorDomain
                                                               code:GDServicesErrorMethodNotFound
                                                           userInfo:errorDetail];
            
            [ServiceController sendErrorTo:application withError:serviceError];
            
        }
        return YES;
    }
    return NO;
}

- (BOOL) printFile:(NSString *)file withError:(NSError**)error
{
    // Set file from GD Container to transfer and print
    fileToPrint = file;
    
    // GD Service Framework: Search for Transfer Service
    GoodClientAppDelegate *appDelegate = (GoodClientAppDelegate *)[UIApplication sharedApplication].delegate;
    NSArray* transferSvc = [appDelegate.gdLibrary getApplicationDetailsForService:kTransferServiceId andVersion:kTransferServiceVersion];
    NSString *appId = nil;
    for (GDAppDetail *appDetail in transferSvc) {
        if ([appDetail.applicationId isEqualToString:@"com.breezy.good.ios"])
            appId = appDetail.applicationId;
    }
    NSLog(@"%@",appId);
    
    BOOL didSendRequest = [self sendRequest:error requestType:PrintFile sendTo:appId];
    
    return didSendRequest;
}

- (BOOL) sendRequest:(NSError**)error requestType:(ClientRequestType)type sendTo:(NSString*)appId
{
    BOOL result = NO;
    switch(type){
        case PrintFile:
        {
            result = [self sendPrintReqeust:error sendTo:appId];
        }break;
        case BringServiceAppToFront:
        {
            result = [self bringServiceAppToFront:error sendTo:appId];
        }break;
            
        default:
            NSAssert(false, @"Invalid request");
            break;
    }
    return result;
}

- (BOOL) sendPrintReqeust:(NSError**)error sendTo:appId
{
    NSMutableArray *fileArray = [[NSMutableArray alloc] initWithObjects:fileToPrint, nil];
    
    GDFileStat myStat;
    NSError *statErr = nil;
    BOOL statOK = [GDFileSystem getFileStat:[fileArray objectAtIndex:0]
                                         to:&myStat
                                      error:&statErr];
    if (statOK) {
        NSDate *lastModified =
        [NSDate dateWithTimeIntervalSince1970:myStat.lastModifiedTime];
        NSLog( @"Stat OK. Length: %lld. Last modified: %@\n",
              myStat.fileLen, [lastModified description] );
    }
    
    // Send a 'fileTransfer' request to Breezy for Good...
    return [GDServiceClient sendTo:appId
                       withService:kTransferServiceId
                       withVersion:kTransferServiceVersion
                        withMethod:@"transferFile"
                        withParams:nil
                   withAttachments:fileArray
               bringServiceToFront:GDEPreferPeerInForeground
                         requestID:nil
                             error:error];
}

- (BOOL) bringServiceAppToFront:(NSError**)error sendTo:appId
{
    
    return [GDServiceClient bringToFront:appId error:error];
}



#pragma mark - GDServiceClientDelegate
- (void) GDServiceClientDidReceiveFrom:(NSString*)application
                            withParams:(id)params
                       withAttachments:(NSArray*)attachments
              correspondingToRequestID:(NSString*)requestID
{
    
    if([params isKindOfClass:[NSString class]] || [params isKindOfClass:[NSError class]])
    {
        if(_delegate && [_delegate respondsToSelector:@selector(showAlert:)])
        {
            [_delegate showAlert:params];
        }
    }
}

- (void) GDServiceClientDidFinishSendingTo:(NSString*)application withAttachments:(NSArray*)attachments withParams:(id)params correspondingToRequestID:(NSString*)requestID
{
    /*
     * The message associated with this application and request ID now has no
     * dependency on any files in the attachments list or the params object.
     * This call can therefore be used for resource cleanup.
     */
}

#pragma mark - GDServiceDelegate
/*
 * A request for Service has been received. We only support the front request service so check for that. If
 * its not then return an error as this is all we can process.
 */
- (void) GDServiceDidReceiveFrom:(NSString*)application
                      forService:(NSString*)service
                     withVersion:(NSString*)version
                       forMethod:(NSString*)method
                      withParams:(id)params
                 withAttachments:(NSArray*)attachments
                    forRequestID:(NSString*)requestID
{
    dispatch_async(dispatch_get_main_queue(),
                   ^{[self processRequestForApplication:application
                                             forService:service
                                            withVersion:version
                                              forMethod:method
                                             withParams:params
                                        withAttachments:attachments
                                           forRequestID:requestID
                      ];});
}

- (void)processRequestForApplication:(NSString*)application
                          forService:(NSString*)service
                         withVersion:(NSString*)version
                           forMethod:(NSString*)method
                          withParams:(id)params
                     withAttachments:(NSArray*)attachments
                        forRequestID:(NSString*)requestID
{
    
    // Check for and possibly consume a front request
    if(![ServiceController consumeFrontRequestService:service forApplication:application forMethod:method withVersion:version])
    {
        // send error reply
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        [errorDetail setValue: kServiceNotImplementedDescription
                       forKey:NSLocalizedDescriptionKey];
        NSError* serviceError = [[NSError alloc] initWithDomain:GDServicesErrorDomain
                                                           code:GDServicesErrorServiceNotFound
                                                       userInfo:errorDetail];
        
        [ServiceController sendErrorTo:application withError:serviceError];
    }
}

@end

