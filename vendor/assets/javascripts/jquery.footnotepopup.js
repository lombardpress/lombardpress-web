/**
 * Footnote Popup
 * http://moronicbajebus.com/blog/footnotepopup/
 *   
 * Copyright stuff first,
 *
 * Copyright (c) 2009 Seamus P. H. Leahy
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * Now that is done with, how to use this:
 *
 * This jQuery plugin is a simple solution for being able to 
 * read the footnote without going to the very bottom of the 
 * page. All it takes is simple HTML code, your custom styling
 * and simple jQuery + footnotepopup.
 *
 * Basic directions:
 *   1. Add CSS to style the popup, such as the following:
 *	.footnotepopup-popup {
 *		position: absolute;
 * 		
 *		background-color: #111;
 *      color: white;
 * 	}
 *   2. Install jQuery and Footnotepopup on your page.
 *   3. Make your HTML nice and clean. The footnotes 
 *      are simple links to the footnotes elsewhere (bottom)
 *      on the page:
 * 
 *      <div id="content">
 *        <p>Hi Jufd ndhf juwer<a href="#footnote-1" class="footnote" id="footnote-1-ref">1</a> huwere....</p>
 *        ...
 *        <ol>
 *          <li id="footnote-1">[<a href="footnote-1-ref">1</a>] My first footnote.</li>
 *        ...
 *        </ol>
 *      </div>
 *
 *   4. Add a simple jQuery script:
 *      jQuery( document ).ready( function( ){
 *        jQuery( '#content a.footnote' ).footnotepopup( );
 *      } );
 *   
 *
 *  Usage
 *  
 *  .footnoteup( [command], [options] )
 *  The footnotepopup method takes two optional parameters. The first
 *  is string that is the command to run, by default the command is 'add'.
 *  The second is an object that passes options to the command.
 *
 *  Commands and their options
 *
 *  add
 *    This will add the popups to the elements.
 *    options: popupFilter - A function to modify the popup element: 
 *               function( $popup_element, $footnote_link_element )
 *             appendPopupTo - If set, this will instead add the popup element
 *               to another element specified by appendPopupTo. jQuery object/string selector/DOM elements/etc
 *  
 * remove
 *   This removes the popup elements for the footnote link element.
 *   option: none  
 *  
 */
jQuery.fn.extend( { "footnotepopup": function( action, options ){
	
	// the actions functions
	var fns = {
		'add': function( options ){
			
			options = jQuery.extend( { 'popupFilter': null, 'appendPopupTo': null }, options );
			
			this.each( function( ){
				
				var $this = jQuery( this );
				var hash = this.href.split( '#' ); // Get the ID for the footnote
				
				// ensure that the href goes to an anchor on this page
				if( hash.length <= 1 || hash[ 0 ] !=  pageUrl ){
					return; // error, goes to external page or does not have an anchor
				}
				hash = hash.pop( ); // now the hash is the ID
				
				// record keeping
				$this.data( 'footnotepopup', true ); 
				
				// Wrapper
				$this.wrap( '<span></span>' );
				$this.data( 'footnotepopupWrapper', $this.parent( ) );
				
				// copy the content of the footnote into the popup
				var footnoteContent = jQuery( '#'+hash ).html( );
				var $footnotePopup = jQuery( '<div class="footnotepopup-popup" style="display: none;"><p>'+footnoteContent+'<p></div>' );
				// remove the link from the popup back to the link
				if( this.id ){
					var refFootnote = pageUrl + '#' + this.id;
					$footnotePopup.find( 'a[href="#'+this.id+'"]' ).hide( );
				}
				
				// User option, for where to append the popup 
				var $appendPopupTo = false;
				
				if( options[ 'appendPopupTo' ] ){
					$appendPopupTo = jQuery( options[ 'appendPopupTo' ] );
					if( $appendPopupTo.size( ) ){
						$appendPopupTo.append( $footnotePopup );
					}
				} 
				// default put the popup after the link
				if( !$appendPopupTo || $appendPopupTo.size( ) == 0 ){
					$this.after( $footnotePopup );
				}
				
				$this.data( 'footnotepopupPopup', $footnotePopup );
				// User option, filter of the popup.
				if( jQuery.isFunction( options[ 'popupFilter' ] ) ){
					options[ 'popupFilter' ]( $footnotePopup, $this ); 
				}
				
				// Flags for if focusing or hovering
				var isFocus = false;
				var isHover = false;
				
				$this
					.focus( function( e ){
						isFocus = true;
						$footnotePopup.show( );
					} )
					.blur( function( e ){
						focus = false;
						if( !isHover ){
							$footnotePopup.hide( );
						}
					} )
					.parent( ).hover(
						function( e ){
							isHover = true;
							$footnotePopup.show( );
						},
						function( e ){
							isHover = false;
							if( !isFocus ){
								$footnotePopup.hide( );
							}
						}
					);
				
				
				
			} );
			return this;
		},
		
		'remove': function( ){
			var $this = jQuery( this );
			
			if( $this.data( 'footnotepopup' ) ){
				$this.data( 'footnotepopupPopup' ).remove( );
				var wrapper = $this.data( 'footnotepopupWrapper' );
				var contents = wrapper.contents( )
				wrapper.after( contents );
				wrapper.remove( );
				
			}	
			
			return this;
		}
	}
	
	
	// figure out the parameters
	options = !options && typeof action == 'object'? action: options; 
	
	action = typeof action == 'string'? action: 'add';
	action = action in fns? action: 'add'; 
	
	// other internally needed information
	var pageUrl = ( window.location.protocol + '//' + window.location.host + window.location.pathname + window.location.search );
	
	// keep the chainging going
	return fns[ action ].call( this, options );
} } );

