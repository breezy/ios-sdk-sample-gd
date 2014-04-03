/*
 * (c) 2014 Good Technology Corporation. All rights reserved.
 */

#ifndef GD_C_PACUTILITIES_H
#define GD_C_PACUTILITIES_H

/** \addtogroup capilist
 * @{
 */

/** Good Proxy IP address retrieval completion callback.
 * Pass a reference to a function of this type as the <TT>callback</TT>
 * parameter to the GD_myipaddress() function.
 *
 * The callback receives one parameter.
 * \param myIP <TT>char *</TT> containing an IP address, or an empty string, or
 *             NULL. See GD_myipaddress() for details.
 */
typedef void (*completionCallback)(const char *myIP);

#ifdef __cplusplus
extern "C" {
#endif
    
#ifndef GD_C_API
# define GD_C_API
#endif
    
#ifndef GD_C_API_EXT
# define GD_C_API_EXT
#endif
    
        
GD_C_API void GD_myipaddress(const char* host, unsigned int port, completionCallback callback);
/**< Get the IP address of the Good Proxy for a specified host.
 * Call this function to retrieve the IP address of the Good Proxy for a
 * specified host.
 *
 * Only hosts that are listed for client connection in the enterprise Good
 * Control server will have a Good Proxy.
 * 
 * Retrieval is asynchronous. When retrieval completes, a completion callback
 * will be invoked.\n
 * The callback will be passed a <TT>char *</TT> pointing to a buffer containing
 * the IP address if retrieval was successful. The callback must copy the
 * contents of the buffer if the IP address is to be used later. The memory for
 * the passed buffer will be released when the callback completes.\n
 * If the specified host is not listed for client connection in the enterprise
 * Good Control server then an empty string is passed to the callback instead.
 * If an error occurred then <TT>NULL</TT> is passed.
 *
 * \param host <TT>char *</TT> containing the server address of the host.
 *
 * \param port <TT>unsigned int</TT> containing the port number of the host.
 *
 * \param callback Function to execute when the retrieval completes. The
 *                 function receives one parameter as described above.
 */
    
#ifdef __cplusplus
}
#endif

/** @}
 */

#endif
