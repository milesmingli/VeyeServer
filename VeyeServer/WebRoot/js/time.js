

function time(){
	
	var select = document.getElementById("birthday");
	var myDate=new Date();
	var now=myDate.getFullYear();

	for(var i=1900;i<=now;i++){
		var opt = document.createElement('option');
		opt.value =i.toString()+"-01"+"-01";
	    opt.selected = false;
	    opt.innerHTML =i.toString();
	    select.appendChild(opt);  
		
	}
	
}