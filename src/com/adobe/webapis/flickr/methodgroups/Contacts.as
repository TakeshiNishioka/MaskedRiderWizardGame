/*
Adobe Systems Incorporated(r) Source Code License Agreement
Copyright(c) 2005 Adobe Systems Incorporated. All rights reserved.
	
Please read this Source Code License Agreement carefully before using
the source code.
	
Adobe Systems Incorporated grants to you a perpetual, worldwide, non-exclusive,
no-charge, royalty-free, irrevocable copyright license, to reproduce,
prepare derivative works of, publicly display, publicly perform, and
distribute this source code and such derivative works in source or
object code form without any attribution requirements.
	
The name "Adobe Systems Incorporated" must not be used to endorse or promote products
derived from the source code without prior written permission.
	
You agree to indemnify, hold harmless and defend Adobe Systems Incorporated from and
against any loss, damage, claims or lawsuits, including attorney's
fees that arise or result from your use or distribution of the source
code.
	
THIS SOURCE CODE IS PROVIDED "AS IS" AND "WITH ALL FAULTS", WITHOUT
ANY TECHNICAL SUPPORT OR ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING,
BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE ARE DISCLAIMED. ALSO, THERE IS NO WARRANTY OF
NON-INFRINGEMENT, TITLE OR QUIET ENJOYMENT. IN NO EVENT SHALL MACROMEDIA
OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOURCE CODE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package com.adobe.webapis.flickr.methodgroups {
	
	import com.adobe.webapis.flickr.events.FlickrResultEvent;
	import com.adobe.webapis.flickr.*;
	import flash.events.Event;
	import flash.net.URLLoader;
	
		/**
		 * Broadcast as a result of the getList method being called
		 *
		 * The event contains the following properties
		 *	success	- Boolean indicating if the call was successful or not
		 *	data - When success is true, contains a "contacts" array of User instances
		 *		   When success is false, contains an "error" FlickrError instance
		 *
		 * @see #getList
		 * @see com.adobe.service.flickr.FlickrError
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		[Event(name="contactsGetList", 
			 type="com.adobe.webapis.flickr.events.FlickrResultEvent")]
			 
		/**
		 * Broadcast as a result of the getPublicList method being called
		 *
		 * The event contains the following properties
		 *	success	- Boolean indicating if the call was successful or not
		 *	data - When success is true, contains a "contacts" array of User instances
		 *		   When success is false, contains an "error" FlickrError instance
		 *
		 * @see #getPublicList
		 * @see com.adobe.service.flickr.FlickrError
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		[Event(name="contactsGetPublicList", 
			 type="com.adobe.webapis.flickr.events.FlickrResultEvent")]	
	
	/**
	 * Contains the methods for the Contacts method group in the Flickr API.
	 * 
	 * Even though the events are listed here, they're really broadcast
	 * from the FlickrService instance itself to make using the service
	 * easier.
	 */
	public class Contacts {
			 
		/** 
		 * A reference to the FlickrService that contains the api key
		 * and logic for processing API calls/responses
		 */
		private var _service:FlickrService;
	
		/**
		 * Construct a new Contacts "method group" class
		 *
		 * @param service The FlickrService this method group
		 *		is associated with.
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function Contacts( service:FlickrService ) {
			_service = service;
		}
	
		/**
		 * Get a list of contacts for the calling user.
		 *
		 * This method requires authentication with READ permission.
		 *
		 * @see http://www.flickr.com/services/api/flickr.contacts.getList.html
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getList( ):void {
			// Let the Helper do the work to invoke the method			
			MethodGroupHelper.invokeMethod( _service, getList_result, "flickr.contacts.getList", false );
		}
		
		/**
		 * Capture the result of the getList call, and dispatch
		 * the event to anyone listening.
		 *
		 * @param event The complete event generated by the URLLoader
		 * 			that was used to communicate with the Flickr API
		 *			from the invokeMethod method in MethodGroupHelper
		 */
		private function getList_result( event:Event ):void {
			// Create a CONTACTS_GET_LIST event
			var result:FlickrResultEvent = new FlickrResultEvent( FlickrResultEvent.CONTACTS_GET_LIST );

			// Have the Helper handle parsing the result from the server - get the data
			// from the URLLoader which correspondes to the result from the API call
			MethodGroupHelper.processAndDispatch( _service, 
												  URLLoader( event.target ).data, 
												  result,
												  "contacts",
												  MethodGroupHelper.parseContactList );
		}
		
		/**
		 * Get the contact list for a user.
		 *
		 * @param user_id The NSID of the user to fetch the contact list for
		 * @see http://www.flickr.com/services/api/flickr.contacts.getPublicList.html
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getPublicList( user_id:String ):void {
			// Let the Helper do the work to invoke the method			
			MethodGroupHelper.invokeMethod( _service, getPublicList_result, 
								   "flickr.contacts.getPublicList", 
								   false,
								   new NameValuePair( "user_id", user_id ) );
		}
		
		/**
		 * Capture the result of the getPublicList call, and dispatch
		 * the event to anyone listening.
		 *
		 * @param event The complete event generated by the URLLoader
		 * 			that was used to communicate with the Flickr API
		 *			from the invokeMethod method in MethodGroupHelper
		 */
		private function getPublicList_result( event:Event ):void {
			// Create a CONTACTS_GET_PUBLIC_LIST event
			var result:FlickrResultEvent = new FlickrResultEvent( FlickrResultEvent.CONTACTS_GET_PUBLIC_LIST );

			// Have the Helper handle parsing the result from the server - get the data
			// from the URLLoader which correspondes to the result from the API call
			MethodGroupHelper.processAndDispatch( _service, 
												  URLLoader( event.target ).data, 
												  result,
												  "contacts",
												  MethodGroupHelper.parseContactList );
		}
		
	}	
	
}