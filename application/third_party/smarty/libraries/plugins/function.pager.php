<?php
/**
 *	smarty function:pager()
 *	sample:
 *	{pager total=$app.topic_count per=2 current=$form.p url="/topics/PAGE/"}
 *	{pager total=$app.topic_count per=2 current=$form.p onclick="location.href='index.php?action=hoge_hoge&list=PAGE'"}
 *	{pager total=$app.topic_count per=2 current=$form.p url="`$config.url`topics/PAGE/" units="Total: TOTAL  From:BEGIN To:END" unit="CURRENT: BEGIN"}
 *
 *	@param	array	$param 	 
 *			('total' => トータルの件数, 
 *			 'per' => ページあたりの件数,
 *			 'current' => 現在のページ(デフォルト:1)
 *
 *			 'url' => ページ移動のURL(PAGEがページ番号に置換される)
 *			 'onclick' => onclick時の文字列(PAGEがページ番号に置換される)
 *
 *			 'range' => 表示するページ数(省略で全てのページ),
 *			 'nolist' => リスト表示しない・する(trueで次へ戻るのみ)
 *			 'edge' => 最初・最後を表示(trueで表示する)
 *
 *			 'next' => 次へボタンの名称(省略で 次へ)
 *			 'prev' => 前へボタンの名称(省略で 前へ)
 *			 'nextedge' => 最後へボタンの名称(省略で 最後へ)
 *			 'prevedge' => 最初へボタンの名称(省略で 最初へ)
 *			 'units' => 件数表示 (省略でTOTAL件中BEGIN～END件を表示) 
 *			 'unit' => 1ページの場合の表示(省略で　BEGINページ)
 *			)
 *	@return	string
 */
function smarty_function_pager($param)
{
	$html = '';
	
	// 必須項目を変数に代入
	$total = $param['total'];
	$per = $param['per']?$param['per']:1;
	$current = ($param['current'] > 0)?$param['current']:1;
	$url = $param['url'];
	
	// 現在の表示件数のセット
	if ($total > 0) {
		$pageBegin = (($current - 1) * $per + 1);
		$pageEnd = (($current * $per) > $total) ? $total : ($current * $per);
	} else {
		$pageBegin = 0;
		$pageEnd = 0;
	}
	
	// 現在の件数をHTMLにセット
//	if ($pageBegin < (int)$pageEnd) {
//        $htmlCurrent = isset($param['units']) ? $param['units'] : 'TOTAL件中 BEGIN～END件';
//		$htmlCurrent = str_replace(array('TOTAL', 'BEGIN', 'END'), array($total, $pageBegin, $pageEnd), $htmlCurrent);
//	} else {
//        $htmlCurrent = isset($param['unit']) ? $param['unit'] : 'BEGINページ';
//		$htmlCurrent = str_replace('BEGIN', $pageBegin, $htmlCurrent);
//	}
    
    if ($pageBegin == $pageEnd) {
        
    }
    
    if ($pageBegin === (int)$pageEnd) {
        $htmlCurrent = isset($param['units']) ? $param['units'] : 'TOTAL件中 END件目';
    } else {
        $htmlCurrent = isset($param['units']) ? $param['units'] : 'TOTAL件中 BEGIN～END件目';
    }

    $htmlCurrent = str_replace(array('TOTAL', 'BEGIN', 'END'), array($total, $pageBegin, $pageEnd), $htmlCurrent);
	
	// onclickパラメータのセット
    $onclick = isset($param['onclick']) ? $param['onclick'] : null;	
	// 次へボタン
    $next = isset($param['next']) ? $param['next'] : '次へ';
	// 前へボタン
    $prev = isset($param['prev']) ? $param['prev'] : '前へ';
	// 最初へボタン
    $prevedge = isset($param['prevedge']) ? $param['prevedge'] : '最初へ';
	// 最後へボタン
    $nextedge = isset($param['nextedge']) ? $param['nextedge'] : '最後へ';

	// 次のページをHTMLにセット
	if (($current * $per) < $total) {
		if ($onclick) {
			$htmlNext = sprintf('<a href="#" class="toLast" onclick="%s; return false;">%s</a>', str_replace('PAGE', ($current + 1), $onclick), $next);
			if (isset($param['edge'])) {
				$htmlNext .= sprintf('  <a class="toLast" href="#" onclick="%s; return false;">%s</a>', str_replace('PAGE', (ceil($total/$per)), $onclick), $nextedge);
			}
		} else {
			$htmlNext = sprintf('<a href="%s">%s</a>', str_replace('PAGE', ($current + 1), $url), $next);
			if (isset($param['edge'])) {
				$htmlNext .= sprintf('  <a href="%s">%s</a>', str_replace('PAGE', (ceil($total/$per)), $url), $nextedge);
			}
		}
	} else {
        $htmlNext = isset($param['edge']) 
            ? sprintf('<span class="gray">%s  %s</span>', $next, $nextedge) 
            : sprintf('<span class="gray">%s</span>', $next);
	}
		
	// 戻るページHTMLをセット
	if ($current > 1) {
		if ($onclick) {
			if (isset($param['edge'])) {
				$htmlPrev = sprintf('<a href="#" class="toFirst" onclick="%s; return false;">%s</a>  ', str_replace('PAGE', 1, $onclick), $prevedge);
			}
			$htmlPrev .= sprintf('<a href="#" class="toFirst" onclick="%s; return false;">%s</a> | ', str_replace('PAGE', ($current - 1), $onclick), $prev);
		} else {
			if (isset($param['edge'])) {
				$htmlPrev = sprintf('<a href="%s">%s</a>  ', str_replace('PAGE', 1, $url), $prevedge);
			}
			$htmlPrev .= sprintf('<a href="%s">%s</a> | ', str_replace('PAGE', ($current - 1), $url), $prev);
		}
	} else {
        $htmlPrev = isset($param['edge']) 
            ? sprintf('<span class="gray">%s | %s</span>  ', $prevedge, $prev) 
            : sprintf('<span class="gray">%s</span> | ', $prev);
	}
	
	// ページリストの作成
	$html_list = '';
	
	if (!$total) {
		$total = 1;
	}
	
	// rangeが指定されている
	if (isset($param['range'])) {
		$begin = $current - $param['range'];
		$end = $current + $param['range'] + (($pageBegin < 2)?1:0);
		
		// 最小値が1以下
		if ($begin < 1) {
			$diff = - $begin;
			$begin = 1;
		} else {
			$diff = 0;
		}
		
		$end += $diff;
		
		if ($end > ceil($total / $per)) {
			$diff = $end - ceil($total / $per);
			$end = ceil($total / $per);
		} else {
			$diff = 0;
		}
		
		$begin -= $diff;
		
		if ($begin < 1) {
			$begin = 1;
		}
		
	// rangeが指定されていない
	} else {
		$begin = 1;
		$end = ceil($total / $per);
	}
	
	// HTMLの設定
	$i = 0;
	foreach (range($begin, $end) as $page) {
		if ($page == $current) {
			$htmlList .= '<b class="currentpage">' . $page . '</b> ';
		} else {
            $htmlList .= $onclick 
                ? sprintf('<a href="#" onclick="%s; return false;">%d</a> ', str_replace('PAGE', $page, $onclick), $page) 
                : sprintf('<a href="%s">%d</a> ', str_replace('PAGE', $page, $url), $page);
		}
	}
	
	// 件数表示
	
	// HTMLの生成
	$html = '<div class="page">';
        $html .= $htmlCurrent;
	if ($end > 1) {
        $html .= sprintf('  %s%s%s  ', $htmlPrev, (!isset($param['nolist']) ? $htmlList . ' | ' : ''), $htmlNext);
	}
	$html .='</div>';
	
    // hiddenパラメータセット
    $html .= '<input type="hidden" name="p" value="' . $current .'" />';
    $html .= '<input type="hidden" name="limit" value="' . $per . '" />';
    
	return $html;	
}