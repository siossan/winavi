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
            var kmlUrl = 'http://www.snowwhite.hokkaido.jp/minavicms/material/place.kmz';
            var kmlLayer = new google.maps.KmlLayer({
                url: kmlUrl,
                map: map_canvas
            });
            
            $("#slon").val({$lon});
            $("#slat").val({$lat});

            stP = new google.maps.LatLng({$lat}, {$lon});
            
            stMarker = new google.maps.Marker({
                position: stP,
                draggable: true,
                map: map_canvas
            });
            

            //地図クリックイベントの登録
            google.maps.event.addListener(map_canvas, 'click',
                    function (event) {
                        clickMapObject(event, 0);
                    })

            google.maps.event.addListener(kmlLayer, 'click', function (event) {
                clickMapObject(event, 1)
            });
        });
        function clickMapObject(event, layerFlg) {
            if (stMarker && edMarker) {
                edMarker.setMap(null);
                edMarker = null;
            } else if (!stMarker) {

            } else if (!edMarker) {
                if (layerFlg == 0) {
                    alert('避難所を選択してください');
                } else {
                    edP = event.latLng;
                    edMarker = new google.maps.Marker({
                        position: event.latLng,
                        draggable: true,
                        map: map_canvas
                    });
                    infotable(stMarker.getPosition().lat(),
                            edMarker.getPosition().lng());

                    $("#elon").val(edMarker.getPosition().lng());
                    $("#elat").val(edMarker.getPosition().lat());
                    var request = {
                        origin: stP, /* 出発地点 */
                        destination: edP, /* 到着地点 */
                        travelMode: google.maps.DirectionsTravelMode.WALKING	/* トラベルモード */
                    };
                    directionsService.route(request, function (response, status) {
                        if (status == google.maps.DirectionsStatus.OK) {
                            directionsDisplay.setDirections(response);
                        }
                    });
                }

                // 時間算出
                var service = new google.maps.DistanceMatrixService;
                service.getDistanceMatrix({
                    origins: [stP],
                    destinations: [edP],
                    travelMode: google.maps.TravelMode.WALKING,
                    unitSystem: google.maps.UnitSystem.METRIC,
                    avoidHighways: false,
                    avoidTolls: false
                }, function (response, status) {
                    if (status !== google.maps.DistanceMatrixStatus.OK) {
                        alert('Error was: ' + status);
                    } else {
                        var originList = response.originAddresses;
                        var destinationList = response.destinationAddresses;
                        var outputDiv = document.getElementById('output');
    {*                        var showGeocodedAddressOnMap = function (asDestination) {
    var icon = asDestination ? destinationIcon : originIcon;
    return function (results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
    map.fitBounds(bounds.extend(results[0].geometry.location));
    markersArray.push(new google.maps.Marker({
    map: map,
    position: results[0].geometry.location,
    icon: icon
    }));
    } else {
    alert('Geocode was not successful due to: ' + status);
    }
    };
    };*}

                        for (var i = 0; i < originList.length; i++) {
                            var results = response.rows[i].elements;
    {*                            geocoder.geocode({'address': originList[i]},
    showGeocodedAddressOnMap(false));*}
                            for (var j = 0; j < results.length; j++) {
    {*                                geocoder.geocode({'address': destinationList[j]},
    showGeocodedAddressOnMap(true));*}
    {*                                $("#time").val(results[j].distance.text + ' / ' +
    results[j].duration.text);*}
                                $("#time").val(results[j].duration.text);
                                $("#dist").val(results[j].distance.text);
                            }
                        }
                    }
                });
            }

        }

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
            <div class="well sidebar-nav" style="display:none;">
                <ul class="nav nav-list">
                    <li class="nav-header">Sidebar</li>
                    <li><a href="#">Link</a></li>
                </ul>
            </div><!--well -->
            <div class="teacher" style=""><img src="{$base}common/images/manavi/nami1_nomal.png"></div>
        </div><!--/span-->

        <form action="{$base}answer/result" method="post" class="form-horizontal" role="form" enctype="multipart/form-data">
            <input type="hidden" name="eme_flg" value="{$emeFlg}" />
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
                        <tr>
                            <th>場所</th>
                        </tr>
                        <tr>
                            <th>
                        <div class="t_comment_wrap">
                            <div class="t_comment">
                                <input type="text" id="teacher_say" class="t_txt" value="大変！{if $emeFlg == "1"}地震{elseif $emeFlg == 2 }石狩川洪水{else}豊平川洪水{/if}が起こってしまいました。君が逃げる避難所を選択しましょう">
                            </div>
                            <div class="t_comment_arw"></div>
                        </div>
                        </th>
                        </tr>
                        <tr>
                            <td>
                                <div id="map_canvas" style="width:70%; height:800px;padding-left: 50px;margin-bottom:10px;"></div>
                                <input type="hidden" id="slon" name="slon">
                                <input type="hidden" id="slat" name="slat">
                                <input type="hidden" id="elon" name="elon">
                                <input type="hidden" id="elat" name="elat">
                                <dl class="input_box cf">
                                    {*
                                    <dt>開始緯度</dt><dd><input type="text" id="slon" name="slon"></dd>
                                    <dt>開始経度</dt><dd><input type="text" id="slat" name="slat"></dd>
                                    <dt>終了緯度</dt><dd><input type="text" id="elon" name="elon"></dd>
                                    <dt>終了経度</dt><dd><input type="text" id="elat" name="elat"></dd>
                                    *}
                                    <dt>時間</dt><dd><input type="text" id="time" name="time"></dd>
                                    <dt>距離</dt><dd><input type="text" id="dist" name="dist"></dd>
                                </dl>
                            </td>
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