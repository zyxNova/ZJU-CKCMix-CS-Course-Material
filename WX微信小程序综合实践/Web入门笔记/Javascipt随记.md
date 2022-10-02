javascript

变量类型：松散类型，var 变量名



数据类型：

- 基本数据类型：undefined, null, boolean, number, string
- 复杂数据类型：object（对象）

typeof 变量 检测变量类型



### number

Number: 整数和浮点数

NaN: 非数

boolean isNaN(n)

数值转换

Number() -用于任何数据类型，返回number类型

parseInt(), parseFloat()专门把字符串转换成数值



### String

(123).toString() -> '123'



prompt() 弹出输出框

var x=prompt("请输入一个整数");

alert(); 弹出警告框

string.length 字符串长度

document.write("内容"); 向浏览器输出内容





function funcName(arg0, arg1, arg2...) {

}



return();



var x = new Array();x[2] = {0,1};

push() 把元素添加到数组尾部

unshift() 头插

pop() 从尾部弹出

shift() 从头部弹出



array.join("|") 把数组元素组合成字符串



array.sort();

array.slice(started); 返回选定的元素

array.splice();删除，插入，替换



indexOf();查找



string.slice(start,end)截取子串



string.substr(s.indexOf('.'),4); -> '.txt'截取后缀名



"10,9,8".split(','); 按','切分字符串，成为字符数组

"".replace('a','e');



> 对象在js中很重要
>
> object.function();对指定对象作用函数



BOM(browser object model)浏览器对象模型

window对象



