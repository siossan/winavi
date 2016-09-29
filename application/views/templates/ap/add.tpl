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

                                    var locationErrFlg = false;



                                    $(function mapInit() {

                                        map = new OpenLayers.Map({
                                            div: "map",
                                            projection: projection3857,
                                            displayProjection: projection4326

                                        });



                                        /*
                                         Geolocation（緯度・経度）
                                         getCurrentPosition :or: watchPosition
                                         */
                                        // 対応しているかチェック
                                        if (!navigator.geolocation) {
                                            alert("navigator.geolocation の対応しているブラウザを使用してください。");
                                        } else {
                                            /* 位置情報取得オプション option object */
                                            var option = {
                                                enableHighAccuracy: true, // より高精度な位置を求める
                                                maximumAge: 1, // 最後の現在地情報取得が [maximuAge][ms]以内であればその情報を再利用する設定
                                                timeout: 10000          // timeout[ms]以内に現在地情報を取得できなければ、処理を終了
                                            };
                                            /* CurrentPosition */
                                            var current = 'current-position';
                                            navigator.geolocation.getCurrentPosition(
                                                    function (position) {
                                                        success(current, position);
                                                    },
                                                    function (error) {
                                                        err(current, error);
                                                    },
                                                    option
                                                    );
                                            /* watchPosition */
                                            var watch = 'watch-position';
                                            navigator.geolocation.watchPosition(
                                                    function (position) {
                                                        success(watch, position);
                                                    },
                                                    function (error) {
                                                        err(watch, error);
                                                    },
                                                    option
                                                    );
                                        }
// 位置情報の取得に成功した時の処理
                                        function success(id, position) {
                                            var time = position.timestamp;                 //タイムスタンプ
                                            var lat = position.coords.latitude;            //緯度
                                            var lon = position.coords.longitude;           //経度
                                            var alt = position.coords.altitude;            //高度
                                            var acc = position.coords.accuracy;            //正確性
                                            var alt_acc = position.coords.altitudeAccuracy;//高度の正確性
                                            var heading = position.coords.heading;         //方位
                                            var speed = position.coords.speed;             //速

                                            deflonlat = new OpenLayers.LonLat(lon, lat).transform(projection4326, projection3857);
                                        }

                                        // 位置情報の取得に失敗した場合の処理
                                        function err(id, error) {

                                            locationErrFlg = true;
                                            var e = "";
                                            if (error.code == 1) { //1＝位置情報取得が許可されてない（ブラウザの設定）
                                                e = "位置情報が許可されてません";
                                            }
                                            if (error.code == 2) { //2＝現在地を特定できない
                                                e = "現在位置を特定できません";
                                            }
                                            if (error.code == 3) { //3＝位置情報を取得する前にタイムアウトになった場合
                                                e = "位置情報を取得する前にタイムアウトになりました";
                                            }
                                            $('#' + id + " .status").html("エラー：" + e);
                                        }
                                        
                                        map.events.register('moveend', map, onClick);

                                        map.addLayer(new OpenLayers.Layer.OSM());

                                        map.setCenter(deflonlat, 10);

                                        markers.addMarker(marker);
                                        map.addLayer(markers);


                                        function onClick(evt) {
                                            var lonlat = map.getCenter();

                                            if (marker) {
                                                marker.erase()
                                            }
                                            marker = new OpenLayers.Marker(lonlat, icon);
                                            markers.addMarker(marker);
                                            map.addLayer(markers);
                                            lonlat.transform(projection3857, projection4326);
                                            $("#lat").val(lonlat.lat);
                                            $("#lon").val(lonlat.lon);

                                        }


                                    }



                                    );
                                </script>
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

