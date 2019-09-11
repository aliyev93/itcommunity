
var initRepeater=function(dataGroup,dataGroupTemplate){
	var addItem = function () {
	    var dataGroup = document.querySelector('['+dataGroup+']');
	    var index = dataGroup.querySelectorAll('[data-group-element]').length;
	    var dataGroupTemplate = document.querySelector('['+dataGroupTemplate+']');

	    var e = document.createElement('div');
	    e.innerHTML = dataGroupTemplate.innerHTML.split("$index").join(index);
	    e.setAttribute("data-group-element","");

	    dataGroup.appendChild(e);
	};

	var addButton = document.querySelector('.repeater-add-btn');

	addButton.addEventListener('click', function() {
	    addItem();
	}, false);

	function remove(element) {
	    var container_ = element.parentNode.parentNode.parentNode.parentNode;
	    var delete_ = element.parentNode.parentNode.parentNode;
	    container_.removeChild(delete_);
	}
}


