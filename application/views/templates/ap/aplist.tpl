{include file="common/header.tpl"}
{assign var="base" value="/winavi/"}

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span3">
            <div class="answer_list">
            </div>
        </div><!--/span-->

        <form action="{$base}Pointaccept/index" method="post" class="form-horizontal" role="form" enctype="multipart/form-data">

            <div class="span9">
                <div class="answer_comment"><div class="arw"></div>{$lang.comment_aplist}</div>
                <?php echo validation_errors('title'); ?>
                {*
                <div class="naviko">
                <img class="img-circle" src="{$base}common/images/naviko/01.png">
                </div><!--nabiko-->
                *}
                <h3 class="page-title">
                    {$lang.aplistplace} <small>{$lang.aplistplace_tips}</small>
                    <table class="form">
                        <tr>
                            <td colspan="3">
                                <div id="map" style="width:100%; height:600px" onload="mapInit();"></div>
                                {literal}
                                    <script>
                                        var map;
                                        var popup = null;
                                        var projection3857 = new OpenLayers.Projection("EPSG:3857");
                                        var projection4326 = new OpenLayers.Projection("EPSG:4326");
                                        var projection4612 = new OpenLayers.Projection("EPSG:4612");
                                        var projection900913 = new OpenLayers.Projection("EPSG:900913");
                                        var markers = new OpenLayers.Layer.Markers("Markers");
                                        var size = new OpenLayers.Size(34, 37);
                                        var offset = new OpenLayers.Pixel(-(size.w / 2), -size.h);

                                        var pointFeature;
                                        var vectorPoint;
                                        var selectId = 0;

                                        $(function mapInit() {

                                            map = new OpenLayers.Map({
                                                div: "map",
                                                projection: projection3857,
                                                displayProjection: projection900913
                                            });

                                            map.addLayer(new OpenLayers.Layer.OSM());

                                            var center = new OpenLayers.LonLat(141.349557, 43.068856).transform(projection4326, projection900913);
                                            map.setCenter(center, 10);

                                            // アイコンサイズと描画位置情報(x,y)
                                            var iconsize = new OpenLayers.Size(48, 48);
                                            var point = new OpenLayers.Pixel(-(iconsize.w / 2), -(iconsize.h / 2));


                                    {/literal}
                                    {foreach from=$list item=v}
                                            var deflonlat = new OpenLayers.LonLat({$v.x}, {$v.y}).transform(projection4326, projection900913);
                                        {if $v.is_opendata == 1}
                                            var icon = new OpenLayers.Icon({$base} + 'common/images/wifiicon2.png', iconsize, point);
                                        {else}
                                            var icon = new OpenLayers.Icon({$base} + 'common/images/wifiicon_mod.png', iconsize, point);
                                        {/if}

                                            var marker = new OpenLayers.Marker(deflonlat, icon);

                                            marker.tag = '<span style="color:red;">{$v.location_name}</span>\n\
                                                            <br />住所：{$v.address}&nbsp;&nbsp;&nbsp;\n\
                                                            <br />備考：{$v.memo}<br />';
                                            marker.x = {$v.x};
                                            marker.y = {$v.y};

                                            marker.id = {$v.ap_id};
                                            marker.good = {$v.good};
                                            marker.bad = {$v.bad};

                                            // マーカーがクリックされた際のイベントを登録                      
//                                            marker.events.register('mousedown', marker, onMarkerClick);
                                            marker.events.on({
                                                click: function (ev) {
                                                    onMarkerClick(ev);
                                                },
                                                touchstart: function (ev) {
                                                    onMarkerClick(ev);
                                                }
                                            });


                                            markers.addMarker(marker);
                                    {/foreach}
                                    {literal}

                                            map.addLayer(markers);

                                            function onMarkerClick(evt) {
                                                if (popup)
                                                    map.removePopup(popup);
                                                popup = new OpenLayers.Popup.FramedCloud(
                                                        "Popup", // id               {String}
                                                        new OpenLayers.LonLat(evt.object.x, evt.object.y).transform(projection4326, projection900913), // lonlat {OpenLayers.LonLat}
                                                        null, // contentSize      {OpenLayers.Size}
                                                        evt.object.tag, // contentHTML      {String}
                                                        null, // anchor           {Object}
                                                        true, // closeBox         {Boolean}
                                                        null);          // closeBoxCallback {Function}
                                                map.addPopup(popup);
                                                $('#eval').show();

                                                selectId = evt.object.id;
                                                $("#goodnum").text(evt.object.good);
                                                $("#badnum").text(evt.object.bad);
                                                return false;
                                            }

                                            //map.events.register('mouseup', map, onClick);

                                            function onClick(evt) {
                                                if (popup && !evt.object)
                                                    map.removePopup(popup);
                                            }
                                        });


                                        //and finally build a function to do the buffering



                                        function onGood() {
                                            if (selectId > 0) {
                                    {/literal}
                                                location.href = '{$base}ap/evaluation/1/' + selectId;
                                            }
                                        }
                                        function onBad() {
                                            if (selectId > 0) {
                                                location.href = '{$base}ap/evaluation/2/' + selectId;
                                            }
                                        }
                                        function onProblem() {
                                            if (selectId > 0) {
                                                location.href = '{$base}ap/evaluation/3/' + selectId;
                                    {literal}
                                            }
                                        }


                                    </script>
                                {/literal}
                            </td>
                        </tr>
                        <tr id="eval" style="display: none;">
                            <td style="width: 10%;"><a class="goodButton" onclick="onGood();">Good!</a>good/<span id="goodnum">0</span>人</td>
                            <td style="width: 10%;"><a class="badButton" onclick="onBad();">Bad...</a>bad/<span id="badnum">0</span>人</td>
                            <td style="position: absolute; right:0;"><a class="badButton"  onclick="onProblem();">APが存在しない/位置ずれ　報告</a></td>
                        </tr>
                    </table>
                </h3>
            </div><!--/span-->

        </form>

    </div><!--/row-->
    <hr>
</div><!--/.fluid-container-->

{include file="common/footer.tpl"}

