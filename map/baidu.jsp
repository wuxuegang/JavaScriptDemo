<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page isELIgnored="false"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
		#allmap{
		position:relative;
		}
		#cjbtn {
			weight:20px;
			height:10px;
			position:absolute;
			margin-top:50px;
			margin-right:30px;
			border:2px solid red;
		}
	</style>
	<link href="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=dWtf7mojfem7an0GBEGcO5H4"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/TrafficControl/1.4/src/TrafficControl_min.js"></script>
	<script type="text/javascript" src="http://api.map.baidu.com/library/DistanceTool/1.2/src/DistanceTool_min.js"></script>
	<title>百度实时路况图层</title>
	<style type="text/css">
		body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	</style>
</head>
<body>
	<div id="allmap"></div>
	<div id="cjbtn" ></div>
</body>
</html>
<script type="text/javascript">
       var map = new BMap.Map("allmap");
      
       map.centerAndZoom(new BMap.Point(111.934, 27.388), 8); 
       var ctrl = new BMapLib.TrafficControl({
           showPanel: false //是否显示路况提示面板
       });      
       map.addControl(ctrl);
       ctrl.setAnchor(BMAP_ANCHOR_TOP_RIGHT);  
    
       map.enableScrollWheelZoom(true); 
       map.setMinZoom(8);
       var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT});// 左上角，添加比例尺
       map.addControl(top_left_control);    
 		
	   var bdary = new BMap.Boundary();
		var noSite = ["江西","重庆","湖北","贵州","广东","广西","四川","福建","云南","浙江","安徽","河南","山西","江苏","上海","香港","山东","陕西","甘肃","河北","天津","北京","台湾","海南","内蒙古","宁夏"];
		for(var i=0;i<noSite.length;i++){
			bdary.get(noSite[i], function(rs){       //获取行政区域
		        //这里是用户自己的函数。
					var count = rs.boundaries.length; //行政区域的点有多少个
					for(var i = 0; i < count; i++){
		            var ply = new BMap.Polygon(rs.boundaries[i], {
					strokeWeight: 3, 
					strokeColor: "#FFFFFF",				
					}); //建立多边形覆盖物
					ply.setFillOpacity(1);
					ply.setStrokeStyle('dashed');
		            map.addOverlay(ply);  //添加覆盖物
					}			
				});
		}
		bdary.get('湖南', function(rs){       //获取行政区域
	        //这里是用户自己的函数。
				var count = rs.boundaries.length; //行政区域的点有多少个
				for(var i = 0; i < count; i++){
	            var ply = new BMap.Polygon(rs.boundaries[i], {
				strokeWeight: 5, 
				strokeColor: "#0000C6",				
				}); //建立多边形覆盖物
				ply.setFillOpacity(0.00005);
				ply.setStrokeStyle('dashed');
	            map.addOverlay(ply);  //添加覆盖物
				}			
			});
		
	   
 		var myDis = new BMapLib.DistanceTool(map); 
   /*     	myDis.open();  //开启鼠标测距
  	   	myDis.close();  //关闭鼠标测距大  */
  	   
		// 定义一个控件类,即function
		function ZoomControl(){
		  // 默认停靠位置和偏移量
		  this.defaultAnchor = BMAP_ANCHOR_TOP_LEFT;
		  this.defaultOffset = new BMap.Size(10, 10);
		}

		// 通过JavaScript的prototype属性继承于BMap.Control
		ZoomControl.prototype = new BMap.Control();

		// 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
		// 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
		ZoomControl.prototype.initialize = function(map){
		  // 创建一个DOM元素
		  var div = document.createElement("div");
		  // 添加文字说明
		  div.appendChild(document.createTextNode("测距工具"));
		  // 设置样式
		  div.style.cursor = "pointer";
		  div.style.border = "1px solid gray";
		  div.style.backgroundColor = "#F0FFF0";
		  // 绑定事件,点击一次放大两级
		  div.onclick = function(e){
			  myDis.open();
		  }
		  // 添加DOM元素到地图中
		  map.getContainer().appendChild(div);
		  // 将DOM元素返回
		  return div;
		}
		// 创建控件
		var myZoomCtrl = new ZoomControl();
		// 添加到地图当中
		map.addControl(myZoomCtrl);
    </script>