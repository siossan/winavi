{assign var="base" value="/winavi/"}
{*{assign var="base" value="http://www.snowwhite.hokkaido.jp/manavi/"}*}
<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8">
        <title>admin</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Le styles -->
        <link href="{$base}common/css/bootstrap.css" rel="stylesheet">
        <link href="{$base}common/css/bootstrap-responsive.css" rel="stylesheet">
        <link href="{$base}common/css/bootstrap-custom.css" rel="stylesheet">
        <link href="{$base}common/css/font-awesome.css" rel="stylesheet">
        <!--[if lt IE 7]>
                <link href="{$base}common/css/font-awesome-ie7.css" rel="stylesheet">
        <![endif]-->
        <link href="{$base}common/css/style.css" rel="stylesheet">
        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
                <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- Fav and touch icons -->
        <link rel="shortcut icon" href="{$base}common/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="{$base}common/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="{$base}common/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="{$base}common/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="{$base}common/ico/apple-touch-icon-57-precomposed.png">
        <script src="{$base}common/js/lib/bootstrap/jquery.js"></script>
        <script src="{$base}common/js/lib/bootstrap/bootstrap-transition.js"></script>
        <script src="{$base}common/js/lib/bootstrap/bootstrap-alert.js"></script>
        <script src="{$base}common/js/lib/bootstrap/bootstrap-modal.js"></script>
        <script src="{$base}common/js/lib/bootstrap/bootstrap-dropdown.js"></script>
        <script src="{$base}common/js/lib/bootstrap/bootstrap-scrollspy.js"></script>
        <script src="{$base}common/js/lib/bootstrap/bootstrap-tab.js"></script>
        <script src="{$base}common/js/lib/bootstrap/bootstrap-tooltip.js"></script>
        <script src="{$base}common/js/lib/bootstrap/bootstrap-popover.js"></script>
        <script src="{$base}common/js/lib/bootstrap/bootstrap-button.js"></script>
        <script src="{$base}common/js/lib/bootstrap/bootstrap-collapse.js"></script>
        <script src="{$base}common/js/lib/bootstrap/bootstrap-carousel.js"></script>
        <script src="{$base}common/js/lib/bootstrap/bootstrap-typeahead.js"></script>
        <script src="{$base}common/js/common.js"></script>

        <!--openlayers settings-->
        <link rel="stylesheet" href="{$base}common/css/ol.css" type="text/css">
        <script src="{$base}common/js/ol.js" type="text/javascript"></script>
        <script type="text/javascript" src="{$base}common/js/OpenLayers.js"></script>

        <script type="text/javascript" src="{$base}common/js/jquery/zebra-datepicker/zebra_datepicker.js"></script>
        <link href="{$base}common/css/jquery/zebra-datepicker/zebra_datepicker.css" rel="stylesheet">

        <!-- cesium settings -->
        <script src="https://cesiumjs.org/Cesium/Build/Cesium/Cesium.js"></script>
        <link href="https://cesiumjs.org/Cesium/Build/Cesium/Widgets/widgets.css" rel="stylesheet">
        <script src="{$base}common/js/JapanGSITerrainProvider.js"></script>
        
        <!-- GoogleMaps -->
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Lato:300,400,700,900,300italic,400italic,700italic,900italic' rel='stylesheet' type='text/css'>

    </head>
    <body>


        <!-- NAVBAR
        ================================================== -->
        <div class="container navbar-wrapper">
            <div class="navbar navbar-inverse">
                <div class="navbar-inner">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="{$base}ap/aplist">WinaVi</a>
                    <div class="nav-collapse collapse">
{*                        <ul class="nav navbar-text pull-right">
                            <li><a href="#" class="register"><i class="icon-off"></i>ログアウト</a></li>
                        </ul>*}
{*                        <p class="navbar-text pull-right">
                            <i class="icon-asterisk"></i>Logged in as <a href="#" class="navbar-link">塩崎</a>
                        </p>*}
                        <ul class="nav">
                            <li><a href="{$base}ap/aplist"><i class="icon-comment"></i>{$lang.menu_find}</a></li>
                            <li><a href="{$base}ap/add"><i class="icon-comment"></i>{$lang.menu_add}</a></li>
                                    <li><a href="{$base}ap/aplist?lang=jp">日本語</a></li>
                                    <li><a href="{$base}ap/aplist?lang=en">ENGLISH</a></li>
{*                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-map-marker"></i>{$lang.menu_select}<b class="caret"></b></a>
                                <ul class="dropdown-menu">
                                    <li><a href="{$base}ap/aplist?lang=jp">日本語</a></li>
                                    <li><a href="{$base}ap/aplist?lang=en">ENGLISH</a></li>
                                </ul>
                            </li>*}
                        </ul>
                    </div><!--nav-collapse -->
                </div><!--navbar-inner -->
            </div><!--navbar -->
        </div><!--container -->
