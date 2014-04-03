/*
 * (c) 2014 Good Technology Corporation. All rights reserved.
 */

#ifndef __GD_APP_DETAIL_H__
#define __GD_APP_DETAIL_H__


#import <Foundation/Foundation.h>
#import <GD/GDiOS.h>

/** Service provider details.
 * This class is used to return information about a service provider. See
 *     \link GDiOS::getApplicationDetailsForService:andVersion:andType:         getApplicationDetailsForService:     (GDiOS)\endlink. An instance of this class either represents an
 * application or a server.
 *
 * The information returned for an application could be used to send a service
 * request to the service provider using Good Inter-Container Communication. See
 * the         \link GDService GDService class reference\endlink for details of the API.
 *
 * The information returned for a server could be used to establish
 * HTTP or TCP socket communications with an instance of the server.
 */
@interface GDAppDetail : NSObject

{
    @public NSString* applicationId;
    /**< Good Dynamics Application ID of the service provider.
     */

    @public NSString* name;
    /**< Display name of the service provider.
     */

    @public NSString* address;
    /**< Native application identifier of the service provider, if it is an
     * application.\ This is the value that would be passed as the
     * <TT>application</TT> parameter in a call to
     *    \link GDServiceClient::sendTo:withService:withVersion:withMethod:withParams:withAttachments:bringServiceToFront:requestID:error: sendTo (GDServiceClient)\endlink.
     */

    @public NSString* versionId;
    /**< Version of the service that the application provides.\ Note that
     * services have versions, in the same way that applications have
     * versions.\ The details of a service's API, as declared in its schema may
     * change from version to version.
     */
    
    @public GDServiceProviderType providerType;
    /**< Indicator of the type of the service provider, either application-based
      * or server-based.\ This is provided for diagnostic purposes only; the
      * original call to     \link GDiOS::getApplicationDetailsForService:andVersion:andType:         getApplicationDetailsForService:     (GDiOS)\endlink will have specified the type
      * of service provider.
     */
    
    @public NSMutableArray* serverList;
    /**< Collection of <TT>GDAppServer</TT> objects, each representing an
     * instance of a server that provides the service.\ If there is more than
     * one then the application should use a server selection algorithm, such as
     * that outlined under the Application Server Selection heading in the
     * \link GDiOS::getApplicationConfig getApplicationConfig (GDiOS)\endlink documentation.
    */
}

@property (nonatomic, retain) NSString* applicationId;
/* GD Application ID. */
@property (nonatomic, retain) NSString* name;
/* Display name. */
@property (nonatomic, retain) NSString* address;
/* Native application identifier, if an application. */
@property (nonatomic, retain) NSString* versionId;
/* Version of the service provided. */
@property (nonatomic) GDServiceProviderType providerType;
/* Indicator of application-based or server-based provider. */
@property (nonatomic, retain) NSMutableArray* serverList;
/* Details of server instances. */
@end

#endif
