/*var alert = function(msg, type) {
	swal({
		  title: "",
		  text: msg,
		  icon: type,
		  button: "확인",
		}).then((value) => {
			return;
		});
}
var confirm = function(msg, type) {
	   swal(msg, {
	        buttons: ["취소", "확인"],
	      }).then((value) => {
	    	  if(value)
	    		  return;
	    	  else
	    		  return;
	      });
}*/

function paging(page){
	if(page == null) return false
	
	var prevPage 	= "<li class=\"page-item\">" +
						"<a class=\"page-link\" href=\"?page=" + (page.startPage - 1)+ "\" aria-label=\"Previous\"\">" +
						"<span aria-hidden=\"true\">&laquo;</span>" +
						"</a></li>";
	var nextPage 	= "<li class=\"page-item\">" +
						"<a class=\"page-link\" href=\"?page=" + (page.endPage + 1)+ "\" aria-label=\"Next\"\">" +
						"<span aria-hidden=\"true\">&raquo;</span>" +
						"</a></li>";
	
	var pageList = [];
	
	pageList.push(prevPage);
	for(var i = page.startPage; i <= page.endPage; i++){
		if(page.nowPage == i){
			pageList.push("<li class=\"page-item\">" +
					"<a class=\"nowpage page-link\" href=\"?page=" + i + "\">" + i + "</a>" +
					"</li>");
		}else{
			pageList.push("<li class=\"page-item\">" +
					"<a class=\"page-link\" href=\"?page=" + i + "\">" + i + "</a>" +
					"</li>");
		}
	}
	pageList.push(nextPage);

	$("#pages").empty();
	$("#pages").append(pageList.join(''));
}

function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}
