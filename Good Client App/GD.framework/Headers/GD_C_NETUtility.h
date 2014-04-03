/*
 * (c) 2014 Good Technology Corporation. All rights reserved.
 */

#include <stdio.h>
#include <string>

#ifndef GD_C_NETUTILITY_H
#define GD_C_NETUTILITY_H

/** \addtogroup capilist
 * @{
 */

/** Good Dynamics name service lookup completion callback.
 * Pass a reference to a function of this type as the <TT>callback</TT>
 * parameter to the GD_nslookup() function.
 *
 * The callback receives one parameter.
 * \param jsonResponse <TT>char *</TT> containing a JSON string representation
 *                     of the results, or an empty string, or NULL. See
 *                     GD_nslookup() for details.
 */
typedef void (*nslookupCompletionCallback)(const char* jsonResponse);

/** Enumerated constants for use with the Good Dynamics name service.
 * Use these constants to specify the type of results required for a Good
 * Dynamics name service lookup. The type parameter of the GD_nslookup()
 * function always takes one of these values.
 */
typedef enum GD_nslookup_type_t {
    GD_nslookup_CNAME = 0,
    /**< Specify a CNAME lookup.
     */

    GD_nslookup_ARECORD
    /**< Specify an A record lookup.
     */
} GD_nslookup_type;

#ifdef __cplusplus
extern "C" {
#endif
    
#ifndef GD_C_API
# define GD_C_API
#endif
    
#ifndef GD_C_API_EXT
# define GD_C_API_EXT
#endif
    
    
GD_C_API void GD_nslookup(const char* host, GD_nslookup_type type, nslookupCompletionCallback callback);
/**< Execute a Good Dynamics name service lookup.
 * Call this function to execute a Good Dynamics name service lookup. The
 * lookup can be for canonical name (CNAME) or address record (A record).
 *
 * The scope of the lookup is the enterprise Good Dynamics deployment to which
 * the application is connected. Details for servers that are not listed for
 * client connection in the enterprise Good Control server are out of scope of
 * the Good Dynamics name service.
 * 
 * The lookup is asynchronous. When the lookup completes, a completion callback
 * will be invoked. The callback will be passed a <TT>char *</TT> containing the
 * results represented as a JSON string if the lookup was successful. If the
 * specified host is not listed for client connection in the enterprise Good
 * Control server then an empty string is passed to the callback instead. If an
 * error occurred then <TT>NULL</TT> is passed.
 *
 * \param host <TT>NSString</TT> containing the name to look up.
 *
 * \param type <TT>GD_nslookup_type</TT> specifying the type of result required,
 *             either CNAME or A record.
 *
 * \param callback Function to execute when the lookup completes. The function
 *                 receives one parameter as described above.
 */
    
#ifdef __cplusplus
}
#endif

/** @}
 */

#endif /* GD_C_NETUTILITY_H */
