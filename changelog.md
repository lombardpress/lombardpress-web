Change Log

Version 0.8.0

- pdf link added to lbp service; link currently only viewable on the text/status page
- better handling of workGroup and expression display on the same landing page
- included prototype for review badge retrieval, viewable on the plaoulcommentary landing page
- improved auto scroll in toc navigation
- added button for info at division level, fixes issue 12
- modified text/clean and text/plaintext routes to offer more cleaned up versions of the text with less extraneous whitespace
- several bug fixes


Version 0.7.1
- minor updates over 0.7.0.
- update to search controller to use new url to access scta search service. Search service is still in development so this will likely need to be adjusted again.
- added more informative error messages when images are not available to be loaded.
- made several adjustments to lbp-1.0.0 critical xslt to support enhanced connection when viewing notes and viewing external references
- made adjustments to style sheets to show more publication information at the top of the text file.

Version 0.7.0
- update to use ruby 2.3.1
- adds marginal note display in diplomatic transcriptions
- adds support for sending and receiving data from linked data notification inbox

Version 0.5.0

- moves logic from text controller to new "presentation" methods added to the Lbp library
- updates dependencies libraries
- updates javascript to reflect new requirements of turbolinks 5
- offers experimental support for retrieving files from exist-db service rather than bitbucket or github.
- offers experimental presentation of data collect from distributed sources, like the RCS database, in the author view
