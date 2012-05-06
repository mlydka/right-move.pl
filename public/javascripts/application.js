// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function toggle_selected_image(element, index) {
		$('pic_nav').select('a.active').each(function(anchor) { anchor.removeClassName('active'); });
		$(element).addClassName('active');
		
		$('pic').select('a').each(function(anchor) {
						if(!anchor.hasClassName('hidden')) {
								anchor.addClassName('hidden'); 
						}
				});

		$('pic').down('a.a' + index).removeClassName('hidden');
		
		return true;
}