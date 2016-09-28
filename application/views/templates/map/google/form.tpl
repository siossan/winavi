{include file="common/header.tpl"}
{assign var="base" value="/minavicms/"}

{literal}
    <script type="text/javascript">

        $(function() {
            /* レンダーDatePicker UI */
            //$.datepicker.setDefaults($.extend($.datepicker.regional['ja']));
            //$('.datepicker').datepicker({ showAnim:'slideDown', dateFormat:'yy-mm-dd' });

            var initPos = new google.maps.LatLng(42.804882, 140.687429);
            var myOptions = {
                noClear: true,
                center: initPos,
                zoom: 10,
                //mapTypeId: google.maps.MapTypeId.TERRAIN, // 地図の種別
                scaleControl: true
            };
            var map_canvas = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

//            var kmlOptions = {
//                preserveViewport: true
//            }

            //var kmlUrl = 'http://kmlnetworklink.gsi.go.jp/kmlnetworklink/gsi_map.kml';
            //var kmlLayer = new google.maps.KmlLayer(kmlUrl, kmlOptions);
            //kmlLayer.setMap(map_canvas);

        });

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
                <div id="map_canvas" style="width:70%; height:800px;padding-left: 50px;"></div>
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

