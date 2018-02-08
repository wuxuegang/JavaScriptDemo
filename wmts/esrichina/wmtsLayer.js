dojo.provide("esrichina.wmtsLayer");

dojo.require("esri.layers.TiledMapServiceLayer");
dojo.require("esri.SpatialReference");
dojo.require("esri.geometry.Extent");
dojo.require("esri.layers.TileInfo");



dojo.declare("esrichina.wmtsLayer", esri.layers.TiledMapServiceLayer, {
    constructor: function(options) {
        this.spatialReference = new esri.SpatialReference({
            wkid: 4326
        });

        this.url = options.url;
        this.style = options.style || "default";
        this.tileMatrixSet = options.tileMatrixSet || "c";
        this.layer = options.layer || "vec";
        this.format  = options.layer || "image/jpgpng";



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
            "lods": [{
                "level": 0,
                "scale": 295497593.05875003,
                "resolution": 0.70312500000000022
            }, {
                "level": 1,
                "scale": 147748796.52937502,
                "resolution": 0.35156250000000011
            }, {
                "level": 2,
                "scale": 73874398.264687508,
                "resolution": 0.17578125000000006
            }, {
                "level": 3,
                "scale": 36937199.132343754,
                "resolution": 0.087890625000000028
            }, {
            "level":4, "resolution":0.043945312500000014, "scale":18468599.566171877
            }, {
            "level":5, "resolution":0.021972656250000007, "scale":9234299.7830859385
            }, {
            "level":6, "resolution":0.010986328125000003, "scale":4617149.8915429693
            }, {
            "level":7, "resolution":0.0054931640625000017, "scale":2308574.9457714846
            }, {
            "level":8, "resolution":0.0027465820312500009, "scale":1154287.4728857423
            }, {
            "level":9, "resolution":0.0013732910156250004, "scale":577143.73644287116
            }, {
            "level":10, "resolution":0.00068664550781250022, "scale":288571.86822143558
            }, {
            "level":11, "resolution":0.00034332275390625011, "scale":144285.93411071779
            }, {
            "level":12, "resolution":0.00017166137695312505, "scale":72142.967055358895
            }, {
            "level":13, "resolution":0.000085830688476562527, "scale":36071.483527679447
            }, {
            "level":14, "resolution":0.000042915344238281264, "scale":18035.741763839724
            }, {
            "level":15, "resolution":0.000021457672119140632, "scale":9017.8708819198619
            }, {
            "level":16, "resolution":0.000010728836059570316, "scale":4508.9354409599309
            }, {
            "level":17, "resolution":0.0000053644180297851579, "scale":2254.4677204799655
            }, {
            "level":18, "resolution":0.000002682209014892579, "scale":1127.2338602399827
            }, {
            "level":19, "resolution":0.0000013411045074462895, "scale":563.61693011999137
            }

            ]

        });
        this.loaded = true;
        this.onLoad(this);
    },

    getTileUrl: function(level, row, col) {
        //return "http://v2.suite.opengeo.org/geoserver/gwc/service/wmts" + "?SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile" + "&LAYER=medford:zoning" + "&STYLE=_null" + "&FORMAT=image/png" + "&TILEMATRIXSET=EPSG:900913" + "&TILEMATRIX=EPSG:900913:" + level + "&TILEROW=" + row + "&TILECOL=" + col;


        var url= this.url
            + "?SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile" + "&FORMAT=" + this.format
            + "&TILEMATRIXSET=" + this.tileMatrixSet
            + "&STYLE=" + this.style
            + "&LAYER=" + this.layer
            + "&TILEMATRIX=" + level
            + "&TILEROW=" + row
            + "&TILECOL=" + col;

        return url;

    }
});