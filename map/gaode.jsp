<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page isELIgnored="false"%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>高德实时路况图层</title>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
   <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=1994ba35a603f806df16000f3799b1da"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
      <script src="http://webapi.amap.com/maps?v=1.3&key=1994ba35a603f806df16000f3799b1da&&plugin=AMap.Scale,AMap.OverView,AMap.ToolBar"></script>
</head>
<body>
<div id="container"></div>
<div class="button-group">
 	<input type="button" class="button" value="距离量测" onClick="javascript:startRuler1()"/>
    <input type="button" class="button" id="control" value="显示/隐藏实时路况"/>
</div>
<script>
    var map = new AMap.Map('container', {
        resizeEnable: true,
        center:[111.934, 27.388],
        zoom:7,
        zooms: [7,18]
    });
    var scale = new AMap.Scale({
        visible: false
    });
    map.addControl(scale);
    scale.show();
   
    var trafficLayer = new AMap.TileLayer.Traffic({
        zIndex: 10
    });
    trafficLayer.setMap(map);
	
    var isVisible = true;
    AMap.event.addDomListener(document.getElementById('control'), 'click', function() {
        if (isVisible) {
            trafficLayer.hide();
            isVisible = false;
        } else {
            trafficLayer.show();
            isVisible = true;
        }
    }, false);
    var ruler1;
    map.plugin(["AMap.RangingTool"], function() {
    	ruler1 = new AMap.RangingTool(map);     
    });
    AMap.event.addListener(ruler1, "end", function(e) {
        ruler1.turnOff();
    });
    //实时路况图层
     addShadow();
    function addShadow() {
        //加载行政区划插件
        AMap.service('AMap.DistrictSearch', function() {
            var opts = {
                subdistrict: 1,   //返回下一级行政区
                extensions: 'all',  //返回行政区边界坐标组等具体信息
                level: 'city'  //查询行政级别为 市
            };           
            //实例化DistrictSearch
            district = new AMap.DistrictSearch(opts);
            district.setLevel('district');
            var noSite = ["江西","重庆","湖北","贵州","广东","广西","四川","福建","云南","浙江","安徽","河南","山西","江苏","上海","香港","山东","陕西","甘肃","河北","天津","北京","台湾","海南","内蒙古","宁夏"];
    		for(var i=0;i<noSite.length;i++){
    		     //行政区查询
                district.search(noSite[i], function(status, result) {
                    var bounds = result.districtList[0].boundaries;
                    var polygons = [];
                    if (bounds) {
                        for (var i = 0, l = bounds.length; i < l; i++) {
                            //生成行政区划polygon
                            var polygon = new AMap.Polygon({
                                map: map,
                                strokeWeight: 3,
                                path: bounds[i],
                                fillOpacity: 0.6,
                                fillColor: '#FFFFFF',
                                strokeColor: '#FFFFFF',
                                strokeStyle :'dashed'
                            });
                            polygons.push(polygon);
                        }
//                        map.setFitView();//地图自适应
                    }
                });
    		}
    		  district.search('湖南', function(status, result) {
    	            var bounds = result.districtList[0].boundaries;
     	            var polygons = [];
    	            if (bounds) {
    	                for (var i = 0, l = bounds.length; i < l; i++) {
    	                    //生成行政区划polygon
    	                    var polygon = new AMap.Polygon({
    	                        map: map,
    	                        strokeWeight: 5,
    	                        path: bounds[i],
    	                        fillOpacity: 0,
    	                        strokeColor: '#0000C6',
    	                        strokeStyle :'dashed'
    	                    });
    	                    polygons.push(polygon);
    	                }
//    	                map.setFitView();//地图自适应
    	            }
    	        }); 
     
    });
   }

    //启用自定义样式测距
    function startRuler1() {
    	  ruler1.turnOn();
    }
</script>
</body>
</html>