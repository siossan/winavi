!function ($) {
    $(function(){
        // carousel demo
        $('#myCarousel').carousel()
    })
}(window.jQuery)

$(function(){
    $('.shop-items dl').hover(function(){
        $(this).find('.item-img ul').animate({
            'bottom':'0'
        });
    },function(){
        $(this).find('.item-img ul').animate({
            'bottom':'-60px'
        });
    });
    $('.shop-items dl').click(function(){
        $('.shop-items dl').removeClass('active');
        $(this).addClass('active');
        var nabviko = $(this).find('img').attr('src')
        $('.naviko').find('img').attr('src',nabviko);
    })
	
    //
    /*$('.block-change').click(function(){
		$('.shop-items .span3').toggleClass('span2').toggleClass('span3');
	});*/
        
    // 各種プラグイン
    $('.sp_start_date').Zebra_DatePicker({
        format: 'Y-m-d',
        offset: [0, 135]
    });
	
	
});
