{include file="common/header.tpl"}
{assign var="base" value="http://www.snowwhite.hokkaido.jp/manavi/"}

{literal}
    <script type="text/javascript">

        var stMarker;
        var edMarker;
        var stP;
        var edP;
        var map_canvas;
        var directionsService = new google.maps.DirectionsService;
        var directionsDisplay = new google.maps.DirectionsRenderer;
        var kmlLayer;
    {/literal}
        $(function () {
            /* レンダーDatePicker UI */
            //$.datepicker.setDefaults($.extend($.datepicker.regional['ja']));
            //$('.datepicker').datepicker({ showAnim:'slideDown', dateFormat:'yy-mm-dd' });
            var initPos = new google.maps.LatLng(42.804882, 140.687429);
            var myOptions = {
                noClear: true,
                center: initPos,
                zoom: 10,
                //mapTypeId: google.maps.MapTypeId.TERRAIN, // 地図の種別
                scaleControl: true,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map_canvas = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
            directionsDisplay.setMap(map_canvas);
            var kmlOptions = {
                preserveViewport: true
            }
            kmlUrl = 'http://www.snowwhite.hokkaido.jp/minavicms/material/place.kmz';
            kmlLayer = new google.maps.KmlLayer({
                url: kmlUrl,
                map: map_canvas
            });
            
            kmlUrl = 'http://www.snowwhite.hokkaido.jp/minavicms/material/toyohira.kmz';
    {if $emeFlg == 1}
            kmlUrl = 'http://www.snowwhite.hokkaido.jp/minavicms/material/zenkai.kmz';
    {elseif $emeFlg == 2}
            kmlUrl = 'http://www.snowwhite.hokkaido.jp/minavicms/material/ishikari.kmz';
    {/if}
            kmlLayer = new google.maps.KmlLayer({
                url: kmlUrl,
                map: map_canvas
            });

            //地図クリックイベントの登録
            var request = {
                origin: new google.maps.LatLng({$lat}, {$lon}), /* 出発地点 */
                destination: new google.maps.LatLng({$elat}, {$elon}), /* 到着地点 */
                travelMode: google.maps.DirectionsTravelMode.WALKING	/* トラベルモード */
            };
            directionsService.route(request, function (response, status) {
                if (status == google.maps.DirectionsStatus.OK) {
                    directionsDisplay.setDirections(response);
                }
            });

        });
    {*        function kmlchange3() {
    var kmlUrl = 'http://www.snowwhite.hokkaido.jp/minavicms/material/zenkai.kmz';
    kmlLayer = new google.maps.KmlLayer({
    url: kmlUrl,
    map: map_canvas
    });
    }
    function kmlchange() {
    var kmlUrl = 'http://www.snowwhite.hokkaido.jp/minavicms/material/toyohira.kmz';
    kmlLayer = new google.maps.KmlLayer({
    url: kmlUrl,
    map: map_canvas
    });
    }
    function kmlchange2() {
    var kmlUrl = 'http://www.snowwhite.hokkaido.jp/minavicms/material/ekijouka.kmz';
    kmlLayer = new google.maps.KmlLayer({
    url: kmlUrl,
    map: map_canvas
    });
    }*}

        //HTMLtagを更新
        function infotable(lat, lon) {
            $("#lat").val(lat);
            $("#lon").val(lon);
        }
        ;
        function reloadMaker() {

            var initPos = new google.maps.LatLng(42.804704, 140.687493);
            var myOptions = {
                noClear: true,
                center: initPos,
                zoom: 15,
                mapTypeId: google.maps.MapTypeId.TERRAIN, // 地図の種別
                scaleControl: true
            };
            var map_canvas = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
            /* ロード時に初期化 */
            var initPos = new google.maps.LatLng(42.804295, 140.679425);
            var marker = new google.maps.Marker({
                position: initPos, /* マーカーを立てる場所の緯度・経度 */
                map: map_canvas, /*マーカーを配置する地図オブジェクト */
                title: 'ニセコ'
            });
            // To add the marker to the map, call setMap();
            marker.setMap(map_canvas);
        }


    {literal}
    </script>
{/literal}

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span3">
            <div class="well sidebar-nav">
                <ul class="nav nav-list">
                    <li class="nav-header">Sidebar</li>
                    <li><a href="#">Link</a></li>
                </ul>
            </div><!--well -->
            <div class="teacher" style=""><img src="{$base}common/images/manavi/nami1_nomal.png"></div>
        </div><!--/span-->

        <form action="{$base}Pointaccept/index" method="post" class="form-horizontal" role="form" enctype="multipart/form-data">

            <div class="span9">
                <?php echo validation_errors('title'); ?>
                {*
                <div class="naviko">
                <img class="img-circle" src="{$base}common/images/naviko/01.png">
                </div><!--nabiko-->
                *}
                <h3 class="page-title">
                    <p style="display:none;">場所 <small>場所を選択</small></p>
                    <table class="form">
                        <tr>
                            <th>避難所マップ</th>
                        </tr>
                        <!-- <tr>
                            <th>場所</th>
                        </tr> -->
                        <tr>
                            <th>
                        <div class="t_comment_wrap">
                            <div class="t_comment">
                                <input type="text" id="teacher_say" class="t_txt" value="避難経路を詳しくを見てみましょう">
                            </div>
                            <div class="t_comment_arw"></div>
                        </div>
                        </th>
                        </tr>
                        <tr>
                            <td>
                                <div id="map_canvas" style="width:70%; height:800px;padding-left: 50px;"></div>
                                緯度：<input type="text" id="lon" name="lon" value="{$lon}">
                                経度：<input type="text" id="lat" name="lat" value="{$lat}">
                                時間：<input type="text" id="time" name="time" value="{$dist}">
{*                                <input type="button" value="豊平浸水域" onclick="kmlchange();">
                                <input type="button" value="全壊率" onclick="kmlchange2();">
                                <input type="button" value="液状化" onclick="kmlchange3();">*}
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="cesiumContainer" class="span9" style="height:800px">
                                    <?php echo validation_errors('title'); ?>
                                </div><!--/span-->
                                <script>
                                    {literal}
                                        var viewer = new Cesium.Viewer('cesiumContainer', {
                                            imageryProvider: new Cesium.createOpenStreetMapImageryProvider({
                                                url: 'http://cyberjapandata.gsi.go.jp/xyz/std/'
                                            }),
                                            terrainProvider: new Cesium.JapanGSITerrainProvider({heightPower: 50.0}),
                                            baseLayerPicker: false,
                                            timeline: false,
                                            animation: false
                                        });
                                    {/literal}
                                    {*                                    var viewer = new Cesium.Viewer("cesiumContainer");*}
                                    {*                                    viewer.dataSources.add(Cesium.KmlDataSource.load('http://www.snowwhite.hokkaido.jp/minavicms/material/hogehoge.kmz'));*}
                                        var scene = viewer.scene;
                                        scene.globe.depthTestAgainstTerrain = true;

                                        var pinBuilder = new Cesium.PinBuilder();
                                        function createPin(lat, lon, text) {
                                            return viewer.entities.add({
                                                name: 'Question mark',
                                                position: Cesium.Cartesian3.fromDegrees(lon, lat),
                                                billboard: {
                                                    image: pinBuilder.fromText(text, Cesium.Color.BLUE, 48).toDataURL(),
                                                    verticalOrigin: Cesium.VerticalOrigin.BOTTOM
                                                }
                                            });
                                        }

                                        var entities = [createPin({$lat}, {$lon}, 'Start'), createPin({$elat}, {$elon}, 'End')];
                                        viewer.zoomTo(entities);
                                </script>
                            </td>
                        </tr>
                    </table>
                </h3>



                <p><a href="https://www.snowwhite.hokkaido.jp/webrtc" class="btn btn-primary btn-large">教えて先生</a></p>
            </div><!--/span-->

        </form>

    </div><!--/row-->
    <hr>
</div><!--/.fluid-container-->

{include file="common/footer.tpl"}

