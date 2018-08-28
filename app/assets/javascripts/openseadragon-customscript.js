function showOpenseadragon(id, data){
	console.log("data:", data)
	//$.get(data.image_url.scheme + "://" + data.image_url.authority + data.image_url.path + "/info.json", function(infojson){
		// this change is due to some odd change, possible in the RDF library, such that .scheme, .authority,
		//and .path are not longer being returned but only value
	$.get(data.image_url.value + "/info.json", function(infojson){
		infojson["tiles"] = [{"scaleFactors": [1, 2, 4, 8], "width": 300}]
		var viewer = OpenSeadragon({
			id: "openseadragon-" + id,
	    prefixUrl: "/openseadragon/images/",
	    preserveViewport: true,
			visibilityRatio:    1,
			minZoomLevel:       1,
			defaultZoomLevel:   1,
			/*tileSources: [{"@context":"http://iiif.io/api/image/2/context.json",
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
									}]*/

				/*tileSources: [{"profile": ["http://iiif.io/api/image/2/level2.json", {"supports": ["canonicalLinkHeader", "profileLinkHeader", "mirroring", "rotationArbitrary", "sizeAboveFull"], "qualities": ["default", "color", "gray", "bitonal"], "formats": ["jpg", "png", "gif", "webp"]}], "protocol": "http://iiif.io/api/image", "sizes": [], "height": 2884, "width": 2212, "@context": "http://iiif.io/api/image/2/context.json",
				"@id": data.image_url}] */
				tileSources: [infojson]
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
	});
}

//like above image_url should be replaced with "data" which contains the image url; data results from a previous call to a manifest which finds the canvas and gets the desire image url
function showOpenseadragonFolio(id, data){
	$.get(data.image_url + "/info.json", function(infojson){
		infojson["tiles"] = [{"scaleFactors": [1, 2, 4, 8], "width": 300}]
		var viewer = OpenSeadragon({
			id: "openseadragon-" + id,
	    prefixUrl: "/openseadragon/images/",
	    preserveViewport: true,
			visibilityRatio:    1,
			minZoomLevel:       1,
			defaultZoomLevel:   1,
			/*tileSources: [{"@context":"http://iiif.io/api/image/2/context.json",
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
										"tiles": [infojson],
									}] */
				tileSources: [infojson]
		});

	console.log(viewer);
	});
}
