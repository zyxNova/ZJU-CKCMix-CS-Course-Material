function check() {
    var pw = document.forms["myForm"]["password"].value;
    var cf = document.forms["myForm"]["confirm"].value;
    if (pw != cf) {
        alert("确认密码与密码不一致");
        return false;
    }
    var phone = document.forms["myForm"]["phone"].value;
    
    if (isNaN(phone)) {
        alert("请输入11位数字手机号");
        return false;
    }
    else {
        if (phone.toString().length != 11) {
            alert("请输入11位数字手机号");
        return false;
        }
    }
    var x=document.forms["myForm"]["email"].value;
    var atpos = x.indexOf("@");
    var dotpos = x.lastIndexOf(".");
    if (atpos < 1 || dotpos-atpos < 2) {
        alert("请输入有效的邮箱地址");
        return false;
    }
    return true;
}