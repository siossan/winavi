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
                <div class="answer_comment"><div class="arw"></div>新しいWi-Fiアクセスポイントを設定してください<br />まずはWi-Fiスポットの場所を地図の中央に表示してください</div>
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
                                <script>
                                    var map;
                                    var projection3857 = new OpenLayers.Projection("EPSG:3857");
                                    var projection4326 = new OpenLayers.Projection("EPSG:4326");
                                    var deflonlat = new OpenLayers.LonLat(141.349557, 43.068856).transform(projection4326, projection3857);
                                    var markers = new OpenLayers.Layer.Markers("Markers");
                                    var size = new OpenLayers.Size(34, 37);
                                    var offset = new OpenLayers.Pixel(-(size.w / 2), -size.h);
                                    var marker;

                                    // アイコンサイズと描画位置情報(x,y)
                                    var iconsize = new OpenLayers.Size(48, 48);
                                    var point = new OpenLayers.Pixel(-(iconsize.w / 2), -(iconsize.h / 2));
                                    var icon = new OpenLayers.Icon({$base} + 'common/images/wifiicon_mod.png', iconsize, point);

                                    $(function mapInit() {

                                        map = new OpenLayers.Map({
                                            div: "map",
                                            eventListeners: {
                                                'moveend': onClick
                                            },
                                            projection: projection3857,
                                            displayProjection: projection4326

                                        });

                                        map.addLayer(new OpenLayers.Layer.OSM());

                                        map.setCenter(deflonlat, 10);

                                        markers.addMarker(marker);
                                        map.addLayer(markers);

                                        //map.events.register('mouseup', map, onClick);

                                        function onClick(evt) {
                                            var lonlat = map.getCenter();

                                            if (marker) {
                                                marker.erase()
                                            }
                                            marker = new OpenLayers.Marker(lonlat, icon);
                                            markers.addMarker(marker);
                                            map.addLayer(markers);

                                            //map.events.register('mouseup', map, onClick);

                                            function onClick(evt) {
                                                var lonlat = map.getCenter();
                                                $("#lat").val(lonlat.lat);
                                                $("#lon").val(lonlat.lon);

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

