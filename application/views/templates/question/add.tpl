{include file="common/header.tpl"}
{assign var="base" value="/minavicms/"}

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span3">
            <div class="well sidebar-nav">
                <ul class="nav nav-list">
                    <li class="nav-header">Sidebar</li>
                    <li><a href="#">Link</a></li>
                </ul>
            </div><!--well -->
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
                    場所 <small>場所を選択</small>
                    <table class="form">
                        <!--                    <tr>
                                                <th>日時</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <input class="sp_start_date" type="text" name="date" value="" />
                                                </td>
                                            </tr>-->
                        <tr>
                            <th>タイトル</th>
                        </tr>
                        <tr>
                            <td><input type="text" name="title"></td>
                        </tr>
                        <tr>
                            <th>英語タイトル</th>
                        </tr>
                        <tr>
                            <td><input type="text" name="title_en"><br/>
                                <label><input type="checkbox" name="in_english">自動翻訳を利用する<br/></label>
                            </td>
                        </tr>
                        <tr>
                            <th>場所</th>
                        </tr>
                        <tr>
                            <td>
                                <div id="map" style="width:500px; height:500px" onload="mapInit();"></div>
                                {literal}
                                    <script>
                                        var map;
                                        var projection3857 = new OpenLayers.Projection("EPSG:3857");
                                        var projection4326 = new OpenLayers.Projection("EPSG:4326");
                                        var deflonlat = new OpenLayers.LonLat(139.6489569, 35.8574244).transform(projection4326, projection3857);
                                        var markers = new OpenLayers.Layer.Markers("Markers");
                                        var size = new OpenLayers.Size(34, 37);
                                        var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);


                                        $(function mapInit(){

                                        map = new OpenLayers.Map({
                                        div: "map",
                                        projection: projection3857,
                                        displayProjection: projection4326
                                    });

                                    map.addLayer(new OpenLayers.Layer.XYZ("標準地図",
                                    "http://cyberjapandata.gsi.go.jp/xyz/std/${z}/${x}/${y}.png", {
                                    attribution: "<a href='http://portal.cyberjapan.jp/help/termsofuse.html'>国土地理院</a>",
                                    maxZoomLevel: 18
                                }));

                                map.setCenter(deflonlat, 10);
    
                                var marker = new OpenLayers.Marker(deflonlat);

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
                                緯度：<input type="text" id="lon" name="lon">
                                経度：<input type="text" id="lat" name="lat">
                            </td>
                        </tr>
                    </table>
                    <select name="area_id">
                        <option value="0">場所を選択</option>
                        <option value="1">ニセコ町</option>
                        <option value="2">鎌倉市</option>
                        <option value="0">無</option>
                    </select>
                    <div class="file"><small>背景画像アップロード</small><input name="bg_file" type="file"></div>
                </h3>

                {*
                <div class="file">
                <input type="file">
                </div><!--file-->
                <p><a href="confirm.html" class="btn btn-primary btn-large">確認画面に進む！</a></p>
                <hr>
                <h3 class="page-title">
                イラスト選択 <small>クリックしてイラストを選択！</small>
                <br />
                <select>
                <option selected>表情の種類を選択</option>
                <option>笑顔</option>
                <option>怒り</option>
                <option>喜怒哀楽無退二</option>
                </select>
                <div class="block-change"><i class="icon-th"></i></div>
                </h3>
                *}
                <p><input type="submit" value="決定！" class="btn btn-primary btn-large"></p>
                {*
                <div class="row-fluid shop-items">
                <div class="span3">
                <dl class="blue active">
                <dt class="item-img">
                <img class="img-circle" src="{$base}common/images/naviko/01.png">
                <ul>
                <li class="heading"><h2>笑顔</h2></li>
                <li class="take-look">選択</li>
                </ul>
                </dt>
                <dt class="price">選択中</dt>
                </dl>
                </div><!--span3 -->
                <div class="span3">
                <dl class="green">
                <dt class="item-img">
                <img class="img-circle" src="{$base}common/images/naviko/02.png">
                <ul>
                <li class="heading"><h2>ほげ</h2></li>
                <li class="take-look">選択</li>
                </ul>
                </dt>
                <dt class="price">選択中</dt>
                </dl>
                </div><!--span3 -->
                <div class="span3">
                <dl class="purple">
                <dt class="item-img">
                <img class="img-circle" src="{$base}common/images/naviko/03.png">
                <ul>
                <li class="heading"><h2>ほげ</h2></li>
                <li class="take-look">選択</li>
                </ul>
                </dt>
                <dt class="price">選択中</dt>
                </dl>
                </div><!--span3 -->
                <div class="span3">
                <dl class="yellow">
                <dt class="item-img">
                <img class="img-circle" src="{$base}common/images/naviko/04.png">
                <ul>
                <li class="heading"><h2>ほげ</h2></li>
                <li class="take-look">選択</li>
                </ul>
                </dt>
                <dt class="price">選択中</dt>
                </dl>
                </div><!--span3 -->
                <div class="span3" style="margin-left:0;">
                <dl class="green">
                <dt class="item-img">
                <img class="img-circle" src="{$base}common/images/naviko/05.png">
                <ul>
                <li class="heading"><h2>ほげ</h2></li>
                <li class="take-look">選択</li>
                </ul>
                </dt>
                <dt class="price">選択中</dt>
                </dl>
                </div><!--span3 -->
                <div class="span3">
                <dl class="purple">
                <dt class="item-img">
                <img class="img-circle" src="{$base}common/images/naviko/06.png">
                <ul>
                <li class="heading"><h2>ほげ</h2></li>
                <li class="take-look">選択</li>
                </ul>
                </dt>
                <dt class="price">選択中</dt>
                </dl>
                </div><!--span3 -->
                <div class="span3">
                <dl class="purple">
                <dt class="item-img">
                <img class="img-circle" src="{$base}common/images/naviko/07.png">
                <ul>
                <li class="heading"><h2>ほげ</h2></li>
                <li class="take-look">選択</li>
                </ul>
                </dt>
                <dt class="price">選択中</dt>
                </dl>
                </div><!--span3 -->
        
                <div class="span3">
                <dl class="purple">
                <dt class="item-img">
                <img class="img-circle" src="{$base}common/images/naviko/08.png">
                <ul>
                <li class="heading"><h2>ほげ</h2></li>
                <li class="take-look">選択</li>
                </ul>
                </dt>
                <dt class="price">選択中</dt>
                </dl>
                </div><!--span3 -->
                </div><!--/row-->
                *}
            </div><!--/span-->

        </form>

    </div><!--/row-->
    <hr>
</div><!--/.fluid-container-->

{include file="common/footer.tpl"}

