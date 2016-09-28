{include file="common/header.tpl"}
{assign var="base" value="/winavi/"}

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span3">
            <div class="answer_list">
            </div>
        </div><!--/span-->

        <form action="{$base}ap/accept" method="post">

            <div class="span9">
                <div class="answer_comment"><div class="arw"></div>新しいWi-Fiアクセスポイントを設定してください</div>
                <?php echo validation_errors('title'); ?>
                {*
                <div class="naviko">
                <img class="img-circle" src="{$base}common/images/naviko/01.png">
                </div><!--nabiko-->
                *}
                <h3 class="page-title">
                    場所 <small>場所を選択</small>
                    <table class="form">
                        <tr>
                            <td>
                                <div id="map" style="width:100%; height:500px" onload="mapInit();"></div>
                                {literal}
                                    <script>
                                        var map;
                                        var projection3857 = new OpenLayers.Projection("EPSG:3857");
                                        var projection4326 = new OpenLayers.Projection("EPSG:4326");
                                        var deflonlat = new OpenLayers.LonLat(141.349557, 43.068856).transform(projection4326, projection3857);
                                        var markers = new OpenLayers.Layer.Markers("Markers");
                                        var size = new OpenLayers.Size(34, 37);
                                        var offset = new OpenLayers.Pixel(-(size.w / 2), -size.h);


                                        $(function mapInit() {

                                            map = new OpenLayers.Map({
                                                div: "map"
                                            });

                                            //map.addLayer(new OpenLayers.Layer.OSM());

                                            //Create Google Map Layer objects
                                            var google_hybrid = new OpenLayers.Layer.Google(
                                                    "Google Hybrid", {
                                                        type: google.maps.MapTypeId.HYBRID,
                                                        numZoomLevels: 20
                                                    });
                                            var google_physical = new OpenLayers.Layer.Google(
                                                    "Google Physical", {
                                                        type: google.maps.MapTypeId.TERRAIN
                                                    });
                                            var google_satellite = new OpenLayers.Layer.Google(
                                                    "Google Satellite", {
                                                        type: google.maps.MapTypeId.SATELLITE,
                                                        numZoomLevels: 22
                                                    });

                                            //Google streets is the normal map type, so we don't need to pass in a type
                                            var google_streets = new OpenLayers.Layer.Google(
                                                    "Google Streets", {
                                                        numZoomLevels: 20
                                                    });

                                            //Add the google map layers
                                            map.addLayers([google_hybrid, google_physical, google_satellite, google_streets]);


                                            //Add a layer switcher control
                                            map.addControl(new OpenLayers.Control.LayerSwitcher());

                                            // Zoom the map to the max extent
                                            if (!map.getCenter()) {
                                                map.zoomToMaxExtent();
                                            }

                                            map.setCenter(deflonlat, 10);

                                            // アイコンサイズと描画位置情報(x,y)
                                            var iconsize = new OpenLayers.Size(48, 48);
                                            var point = new OpenLayers.Pixel(-(iconsize.w / 2), -(iconsize.h / 2));
                                    {/literal}
                                            var icon = new OpenLayers.Icon({$base} + 'common/images/wifiicon_mod.png', iconsize, point);
                                    {literal}
                                            var marker = new OpenLayers.Marker(deflonlat, icon);

                                            markers.addMarker(marker);
                                            map.addLayer(markers);

                                            map.events.register('mouseup', map, onClick);

                                            function onClick(evt) {
                                                var lonlat = map.getLonLatFromViewPortPx(evt.xy);
                                                lonlat.transform(projection3857, projection4326);
                                                $("#lat").val(lonlat.lat);
                                                $("#lon").val(lonlat.lon);

                                                var opx = map.getLayerPxFromViewPortPx(evt.xy);
                                                marker.map = map;
                                                marker.moveTo(opx);
                                            }
                                        });
                                    </script>
                                {/literal}
                                経度：<input type="text" id="lon" name="lon">
                                緯度：<input type="text" id="lat" name="lat">
                            </td>
                        </tr>
                        <tr>
                            <th>施設名</th>
                        </tr>
                        <tr>
                            <td><input type="text" name="location_name"></td>
                        </tr>
                        <tr>
                            <th>備考</th>
                        </tr>
                        <tr>
                            <td><textarea name="memo"></textarea></td>
                        </tr>
                    </table>
                </h3>
                <p><input type="submit" value="決定！" class="btn btn-primary btn-large"></p>

            </div><!--/span-->

        </form>

    </div><!--/row-->
    <hr>
</div><!--/.fluid-container-->

{include file="common/footer.tpl"}

