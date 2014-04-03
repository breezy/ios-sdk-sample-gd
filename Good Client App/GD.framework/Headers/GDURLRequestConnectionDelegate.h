/*
 * © 2013 Good Technology. All Right Reserved.
 */

#ifndef __GD_URL_REQUEST_CONNECTION_DELEGATE_H__
#define __GD_URL_REQUEST_CONNECTION_DELEGATE_H__

#import <Foundation/Foundation.h>

/** \defgroup gdurlconnectionmanagmentconstants GD URL Connection Management Constants
 * Use these constants in a GD URL connection management delegate. See the
 * \link GDURLRequestConnectionDelegate GDURLRequestConnectionDelegate class
 * reference\endlink for details.
 * 
 * \{
 */

extern NSString* GDRouteInternet;
/**< Routing specifier for direct connection to the Internet.
 * Routing specifier for URL requests that will be, or have been, sent over a
 * direct Internet connection and <EM>not </EM>via the Good Dynamics proxy
 * infrastructure.
 */

extern NSString* GDRouteGoodProxy;
/**< Routing specifier for connection via the Good Dynamics proxy
 *   infrastructure.
 * Routing specifier for URL requests that will be, or have been, sent via the
 * Good Dynamics proxy infrastructure.
 */

/** \}
 */

/** Delegate for managing the URL connections associated with a UIWebView control.
 * Connections for URL requests issued by a <TT>UIWebView</TT> control can be
 * managed by creating a class that implements this protocol.
 *
 * This protocol enables the application to specify whether a connection will be
 * made direct to the Internet or via the Good Dynamics proxy infrastructure,
 * or that a connection is to be blocked. The application will be notified
 * separately before and after each connection is made.
 *
 * Use this protocol when the application requires finer control over routing
 * and filtering than is offered by Good Control client connection
 * configuration. But note that this protocol does not enable routing to an
 * application server that is behind the enterprise firewall and that has not
 * been configured in the enterprise Good Control console.
 * 
 * Call the <TT>GDSetRequestConnectionDelegate:</TT> function in the
 * \link UIWebView(GDNET)\endlink category to set the delegate for a particular
 * <TT>UIWebView</TT> instance. The delegate callbacks will be executed on the
 * same thread in which the delegate was set.
 *
 * The callbacks in this protocol utilize an <TT>NSURLRequest</TT> object to
 * represent the request to which the callback invocation relates. See the <A
 *     HREF="https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSURLRequest_Class/Reference/Reference.html"
 *     target="_blank"
 * >NSURLRequest class reference</A> in the iOS Developer Library on apple.com
 * for details of how to access its attributes.
 *
 * \see \ref GC and the online help available in the Good Control console.
 */
@protocol GDURLRequestConnectionDelegate <NSObject>

@optional

- (BOOL)GDRequest:(NSURLRequest*)request willConnectVia:(NSString**)route;
/**< Invoked before a request is sent.
 * This callback is invoked when a request is about to be sent and a connection
 * is about to be established. A specifier for the routing that is going to be
 * used for the connection is passed as a parameter.
 *
 * The specifier is passed as the location of a pointer to <TT>NSString</TT>, i.e. a
 * pointer to a pointer. The function that is invoked can check the routing
 * specified by comparing the pointed-to value with the
 * \link gdurlconnectionmanagmentconstants GD URL Connection Management
 * Constants\endlink.
 *
 * The function that is invoked can specify a different route by overwriting the
 * pointer with the address of an <TT>NSString</TT> of its own. The value of the
 * <TT>NSString</TT> must be the same as one of the connection management constants.
 *
 * The function that is invoked can also block the connection from being
 * established by doing either of the following:
 * - Overwriting the pointer with <TT>nil</TT>.
 * - Returning <TT>NO</TT>.
 *
 * \param request <TT>NSURLRequest</TT> representing the request that will be
 *                sent.
 * \param route location of a pointer to <TT>NSString</TT> specifying the
 *              routing of the request. The value will be one of the
 *              \link gdurlconnectionmanagmentconstants GD URL Connection
 *              Management Constants\endlink.
 * \return <TT>YES</TT> to allow establishment of the connection, via the original
 *                  or changed route.
 * \return <TT>NO</TT> to block the connection.
 */

- (void)GDRequest:(NSURLRequest*)request didConnectVia:(NSString*)route;
/**< Invoked after a request has been sent.
 * This callback is invoked after a URL request has been sent and a new
 * connection was established. A specifier for the routing that was used for the
 * request is passed as a parameter.
 *
 * \param request <TT>NSURLRequest</TT> representing the request that was sent.
 * \param route <TT>NSString</TT> specifying the route of the connection. The
 *              value will be one of the \link gdurlconnectionmanagmentconstants
 *              GD URL Connection Management Constants\endlink.
 */

@end

#endif