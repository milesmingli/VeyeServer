var mb = myBrowser();

function myBrowser(){
	    var userAgent = navigator.userAgent; //ȡ���������userAgent�ַ���
	 
	    var isOpera = userAgent.indexOf("Opera") > -1;
	    if (isOpera) {
	        return "Opera"
	    }; //�ж��Ƿ�Opera�����
	    if (userAgent.indexOf("Firefox") > -1) {
	        return "FF";
	    } //�ж��Ƿ�Firefox�����
	    if (userAgent.indexOf("Chrome") > -1){
	  return "Chrome";
	 }
	    if (userAgent.indexOf("Safari") > -1) {
	        return "Safari";
	    } //�ж��Ƿ�Safari�����
	    if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
	    	
	        return "IE";
	    }; //�ж��Ƿ�IE�����
	}
	//�����ǵ�������ĺ���

	if ("IE" == mb) {
	   // alert("���� IE");
	}
	if ("FF" == mb) {
	   // alert("���� Firefox");
	}
	if ("Chrome" == mb) {
	   // alert("���� Chrome");
	}
	if ("Opera" == mb) {
	  //  alert("���� Opera");
	}
	if ("Safari" == mb) {
	   // alert("���� Safari");
	}