function showOpenseadragon(id, data){
	var viewer = OpenSeadragon({
		id: "openseadragon-" + id,
    prefixUrl: "/openseadragon/images/",
    preserveViewport: true,
		visibilityRatio:    1,
		minZoomLevel:       1,
		defaultZoomLevel:   1,
		tileSources: [{"@context":"http://iiif.io/api/image/2/context.json",
										//"@context": "http://iiif.io/api/image/1/context.json", # use for plaoul sorb text
									"@id": data.image_url, 
									"height":2862, 
									"width": 2070, 
									"profile": [
										"http://iiif.io/api/image/2/level2.json", 
										//"http://iiif.io/api/image/1/level2.json", //use for plaoul sorb text 
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
	 
		
		console.log(data);
		
		var rect = new OpenSeadragon.Rect(data.xcomp, data.ycomp, data.widthcomp, data.heightcomp)
		
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

function showOpenseadragonFolio(id, image_url){
	var viewer = OpenSeadragon({
		id: "openseadragon-" + id,
    prefixUrl: "/openseadragon/images/",
    preserveViewport: true,
		visibilityRatio:    1,
		minZoomLevel:       1,
		defaultZoomLevel:   1,
		tileSources: [{"@context":"http://iiif.io/api/image/2/context.json",
										//"@context": "http://iiif.io/api/image/1/context.json", # use for plaoul sorb text
									"@id": image_url, 
									"height":2862, 
									"width": 2070, 
									"profile": [
										"http://iiif.io/api/image/2/level2.json", 
										//"http://iiif.io/api/image/1/level2.json", //use for plaoul sorb text 
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
	console.log(viewer);
}