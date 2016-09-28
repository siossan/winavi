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

            <div id="cesiumContainer" class="span9">
                <?php echo validation_errors('title'); ?>
            </div><!--/span-->
            <script>
                var viewer = new Cesium.Viewer('cesiumContainer', {
                    imageryProvider: new Cesium.createOpenStreetMapImageryProvider({
                        url: 'http://cyberjapandata.gsi.go.jp/xyz/std/'
                    }),
                    terrainProvider: new Cesium.JapanGSITerrainProvider({}),
                    baseLayerPicker: false
                });
                var scene = viewer.scene;
                scene.globe.depthTestAgainstTerrain = true;
            </script>
        </form>
    </div><!--/row-->
    <hr>
</div><!--/.fluid-container-->

{include file="common/footer.tpl"}

