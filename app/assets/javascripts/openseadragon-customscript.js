function showOpenseadragon(id){
	var viewer = OpenSeadragon({
		id: "openseadragon-" + id,
    prefixUrl: "/openseadragon/images/",
    preserveViewport: true,
		visibilityRatio:    1,
		minZoomLevel:       1,
		defaultZoomLevel:   1,
		tileSources: [{"@context":"http://iiif.io/api/image/2/context.json",
									"@id":"http://images.scta.info:3000/pg-lon/L51r.jpg", 
									"height":2862, 
									"width": 2070, 
									"profile": [
										"http://iiif.io/api/image/2/level2.json", 
										{
											"formats": ["gif", "tif", "pdf"], 
											"qualities": ["color", "gray"], 
											"supports": ["canonicalLinkHeader", "profileLinkHeader", "mirroring", "rotationArbitrary", "sizeAboveFull"]
										}
									], 
									"protocol": "http://iiif.io/api/image", 
									"tiles": [{"scaleFactors": [1, 2, 4, 8], "width": 300}], 
								}]
							});


	viewer.addHandler("open", function() {
	  var scale = .5
		var bottom = 1288 * scale,
				right = 1634 * scale,
				top = 636 * scale,
				left = 8 * scale,
				width = right - left, 
				height = bottom - top,
				totalW = 2070 * scale,
				totalH = 2862 * scale,
				aspectratio = totalH / totalW,
				xcomp = left / totalW,
				ycomp = (top / totalH) * aspectratio,
				heightcomp = (height / totalH) * aspectratio,
				widthcomp = width / totalW;
		
		
		var rect = new OpenSeadragon.Rect(xcomp, ycomp, widthcomp, heightcomp)
		
		var myBounds = viewer.viewport.fitBounds(rect, false);

		//this helps to keep the viewer in the same spot when toggling full screen
		viewer.preserveViewport = true;

		/* this resets the home tool tip to the rectangle focused on
			i'm not sure what contentSize.x does -- but it's important for this reset of home to work correctly
			this below line kind of works, but it prevents someone from being able to move around and navigate away from Home.
			
		*/
		viewer.viewport.setHomeBounds(rect, viewer.viewport.contentSize.x);

		
	});
}