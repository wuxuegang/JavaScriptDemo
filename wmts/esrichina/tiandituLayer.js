dojo.provide("esrichina.tiandituLayer");

dojo.require("esri.layers.TiledMapServiceLayer");
dojo.require("esri.SpatialReference");
dojo.require("esri.geometry.Extent");
dojo.require("esri.layers.TileInfo");



dojo.declare("esrichina.tiandituLayer", esri.layers.TiledMapServiceLayer, {
    constructor: function(options) {
        this.spatialReference = new esri.SpatialReference({
            wkid: 4326
        });

//        this.url = options.url;
//        this.style = options.style || "default";
//        this.tileMatrixSet = options.tileMatrixSet || "c";
//        this.layer = options.layer || "vec";
//        this.format  = options.layer || "image/jpgpng";



        this.initialExtent = new esri.geometry.Extent(108.51210030213728,28.08509929971451,114.52924109225266,30.987484857299574, this.spatialReference);
        this.fullExtent = new esri.geometry.Extent(-180,-90,180,90, this.spatialReference);
        //
        this.tileInfo = new esri.layers.TileInfo({
            "dpi": "90.71428571427429",
            "format": "image/jpgpng",
            "compressionQuality": 0,
            "spatialReference": {
                "wkid": "4326"
            },
            "rows": 256,
            "cols": 256,
            "origin": {
                "x": -180,
                "y": 90.0
            },








            // Scales in DPI 96
            "lods" : [
                              {"level" : 2, "resolution" : 0.3515625, "scale" : 147748796.52937502},
                              {"level" : 3, "resolution" : 0.17578125, "scale" : 73874398.264687508},
                             {"level" : 4, "resolution" : 0.087890625, "scale" : 36937199.132343754},
                             {"level" : 5, "resolution" : 0.0439453125, "scale" : 18468599.566171877},
                              {"level" : 6, "resolution" : 0.02197265625, "scale" : 9234299.7830859385},
                               {"level" : 7, "resolution" : 0.010986328125, "scale" : 4617149.8915429693},
                               {"level" : 8, "resolution" : 0.0054931640625, "scale" : 2308574.9457714846},
                               {"level" : 9, "resolution" : 0.00274658203125, "scale" : 1154287.4728857423},
                               {"level" : 10, "resolution" : 0.001373291015625, "scale" : 577143.73644287116},
                               {"level" : 11, "resolution" : 0.0006866455078125, "scale" : 288571.86822143558},
                               {"level" : 12, "resolution" : 0.00034332275390625, "scale" : 144285.93411071779},
                               {"level" : 13, "resolution" : 0.000171661376953125, "scale" : 72142.967055358895},
                               {"level" : 14, "resolution" : 8.58306884765625e-005, "scale" : 36071.483527679447},
                               {"level" : 15, "resolution" : 4.291534423828125e-005, "scale" : 18035.741763839724},
                               {"level" : 16, "resolution" : 2.1457672119140625e-005, "scale" : 9017.8708819198619},
                               {"level" : 17, "resolution" : 1.0728836059570313e-005, "scale" : 4508.9354409599309},
                               {"level" : 18, "resolution" : 5.3644180297851563e-006, "scale" : 2254.4677204799655}
                             ]

        });
        this.loaded = true;
        this.onLoad(this);
    },

    getTileUrl: function(level, row, col) {
        //return "http://v2.suite.opengeo.org/geoserver/gwc/service/wmts" + "?SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile" + "&LAYER=medford:zoning" + "&STYLE=_null" + "&FORMAT=image/png" + "&TILEMATRIXSET=EPSG:900913" + "&TILEMATRIX=EPSG:900913:" + level + "&TILEROW=" + row + "&TILECOL=" + col;


//        var url= this.url
//            + "?SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile" + "&FORMAT=" + this.format
//            + "&TILEMATRIXSET=" + this.tileMatrixSet
//            + "&STYLE=" + this.style
//            + "&LAYER=" + this.layer
//            + "&TILEMATRIX=" + level
//            + "&TILEROW=" + row
//            + "&TILECOL=" + col;


        return "http://t" + col%8 + ".tianditu.cn/vec_c/wmts?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=vec&STYLE=default&TILEMATRIXSET=c&TILEMATRIX="+level+"&TILEROW="+row+"&TILECOL="+col+"&FORMAT=tiles";

    }
});