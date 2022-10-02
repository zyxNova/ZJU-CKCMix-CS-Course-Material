# HTML表单

[TOC]

<form> 元素定义 HTML 表单：

```
<form>
 .
form elements
 .
</form>
```



## **表单属性**

**本章介绍 HTML `<form>` 元素的不同属性。**

### Action 属性

`action` 属性定义提交表单时要执行的操作。

通常，当用户单击“提交”按钮时，表单数据将发送到服务器上的文件中。

在下面的例子中，表单数据被发送到名为 "action_page.php" 的文件。该文件包含处理表单数据的服务器端脚本：

提交后，将表单数据发送到 "action_page.php"：


<form action="/demo/demo_form.asp">
First name:<br>
<input type="text" name="firstname" value="Mickey">
<br>
Last name:<br>
<input type="text" name="lastname" value="Mouse">
<br><br>
<input type="submit" value="Submit">
</form> 


<p>如果您点击提交，表单数据会被发送到名为 demo_form.asp 的页面。</p>



**提示：**如果省略 action 属性，则将 action 设置为当前页面。





### Target 属性

`target` 属性规定提交表单后在何处显示响应。

`target` 属性可设置以下值之一：

| 值        | 描述                           |
| :-------- | :----------------------------- |
| _blank    | 响应显示在新窗口或选项卡中。   |
| _self     | 响应显示在当前窗口中。         |
| _parent   | 响应显示在父框架中。           |
| _top      | 响应显示在窗口的整个 body 中。 |
| framename | 响应显示在命名的 iframe 中。   |

默认值为 `_self`，这意味着响应将在当前窗口中打开。



### Method 属性

method 属性指定提交表单数据时要使用的 HTTP 方法。

表单数据可以作为 URL 变量（使用 `method="get"`）或作为 HTTP post 事务（使用 `method="post"`）发送。

提交表单数据时，默认的 HTTP 方法是 GET。

#### 关于 GET 的注意事项：

- 以名称/值对的形式将表单数据追加到 URL
- 永远不要使用 GET 发送敏感数据！（提交的表单数据在 URL 中可见！）
- URL 的长度受到限制（2048 个字符）
- 对于用户希望将结果添加为书签的表单提交很有用
- GET 适用于非安全数据，例如 Google 中的查询字符串

#### 关于 POST 的注意事项：

- 将表单数据附加在 HTTP 请求的正文中（不在 URL 中显示提交的表单数据）
- POST 没有大小限制，可用于发送大量数据。
- 带有 POST 的表单提交无法添加书签

**提示：**如果表单数据包含敏感信息或个人信息，请务必使用 POST！



### Autocomplete 属性

`autocomplete` 属性规定表单是否应打开自动完成功能。

启用自动完成功能后，浏览器会根据用户之前输入的值自动填写值。



### Novalidate 属性

`novalidate` 属性是一个布尔属性。

如果已设置，它规定提交时不应验证表单数据。

未设置 novalidate 属性的表单：

```
<form action="/action_page.php" novalidate>
```



### enctype 属性

规定在将表单数据发送到服务器之前如何对其进行编码。

| application/x-www-form-urlencoded | 在发送前编码所有字符（默认）                                 |
| --------------------------------- | ------------------------------------------------------------ |
| multipart/form-data               | 不对字符编码。在使用包含文件上传控件的表单时，必须使用该值。 |
| text/plain                        | 空格转换为 "+" 加号，但不对特殊字符编码。                    |

### 所有`<form>`属性的列表

| 属性                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [accept-charset](https://www.w3school.com.cn/tags/att_form_accept-charset.asp) | 规定用于表单提交的字符编码。                                 |
| [action](https://www.w3school.com.cn/tags/att_form_action.asp) | 规定提交表单时将表单数据发送到何处。                         |
| [autocomplete](https://www.w3school.com.cn/tags/att_form_autocomplete.asp) | 规定表单是否应打开自动完成（填写）功能。                     |
| [enctype](https://www.w3school.com.cn/tags/att_form_enctype.asp) | 规定将表单数据提交到服务器时应如何编码（仅供 method="post"）。 |
| [method](https://www.w3school.com.cn/tags/att_form_method.asp) | 规定发送表单数据时要使用的 HTTP 方法。                       |
| [name](https://www.w3school.com.cn/tags/att_form_name.asp)   | 规定表单名称。                                               |
| [novalidate](https://www.w3school.com.cn/tags/att_form_novalidate.asp) | 规定提交时不应验证表单。                                     |
| [rel](https://www.w3school.com.cn/tags/att_form_rel.asp)     | 规定链接资源和当前文档之间的关系。                           |
| [target](https://www.w3school.com.cn/tags/att_form_target.asp) | 规定提交表单后在何处显示接收到的响应。                       |



## **表单元素**

### `<input>`元素

最重要的表单元素是 *<input>* 元素。

<input> 元素根据不同的 *type* 属性，可以变化为多种形态。



### `<select>` 元素（下拉列表）


<form action="/demo/demo_form.asp">
<select name="cars">
<option value="volvo">Volvo</option>
<option value="saab">Saab</option>
<option value="fiat">Fiat</option>
<option value="audi">Audi</option>
</select>
<br><br>
<input type="submit">
</form>


*<option>* 元素定义待选择的选项。

列表通常会把首个选项显示为被选选项。

您能够通过添加 selected 属性来定义预定义选项。

```
<option value="fiat" selected>Fiat</option>
```



### `<textarea>` 元素

<p>textarea 元素定义多行输入字段。</p>

<form action="/demo/html/action_page.php">
  <textarea name="message" rows="5" cols="30">The cat was playing in the garden.</textarea>
  <br><br>
  <input type="submit">
</form>



### `<button>` 元素

*<button>* 元素定义可点击的*按钮*


<button type="button" onclick="alert('Hello World!')">点击我！</button>





### ` <datalist> `元素 - HTML5新增

*<datalist>* 元素为 <input> 元素规定预定义选项列表。

用户会在他们输入数据时看到预定义选项的下拉列表。

<input> 元素的 *list* 属性必须引用 <datalist> 元素的 *id* 属性。

```html
<form action="/demo/demo_form.asp">

<input list="browsers" name="browser">
<datalist id="browsers">
  <option value="Internet Explorer">
  <option value="Firefox">
  <option value="Chrome">
  <option value="Opera">
  <option value="Safari">
</datalist>
<input type="submit">
</form>

<p><b>注释：</b>Safari 或 IE9（以及更早的版本）不支持 datalist 标签。</p>

```





## **`<input>`输入属性**



### 输入类型：text

*<input type="text">* 定义供*文本输入*的单行输入字段：


<form>
First name:<br>
<input type="text" name="firstname">
<br>
Last name:<br>
<input type="text" name="lastname">
</form>


<p>请注意表单本身是不可见的。</p>

<p>同时请注意文本字段的默认宽度是 20 个字符。</p>



### 输入类型：password

*<input type="password">* 定义*密码字段*：

<form action="">
User name:<br>
<input type="text" name="userid">
<br>
User password:<br>
<input type="password" name="psw">
</form>


<p>密码字段中的字符被掩码（显示为星号或圆点）。</p>



### 输入类型：submit

*<input type="submit">* 定义*提交*表单数据至*表单处理程序*的按钮。

```html
<input type="submit" value="Submit">
```

表单处理程序（form-handler）通常是包含处理输入数据的脚本的服务器页面。

在表单的 action 属性中规定表单处理程序（form-handler）



### 输入类型：radio

<input type="radio"> 定义单选按钮。

Radio buttons let a user select ONLY ONE of a limited number of choices:


<form>
<input type="radio" name="sex" value="male" checked>Male
<br>
<input type="radio" name="sex" value="female">Female
</form> 



### 输入类型：checkbox

<input type="checkbox"> 定义复选框。

复选框允许用户在有限数量的选项中选择零个或多个选项。


<form action="/demo/demo_form.asp">
<input type="checkbox" name="vehicle" value="Bike">I have a bike
<br>
<input type="checkbox" name="vehicle" value="Car">I have a car 
<br><br>
<input type="submit">
</form> 


### 输入类型：button

*<input type="button>* 定义*按钮*。

<button type="button" onclick="alert('Hello World!')">Click Me!</button>



### 输入类型：file

```html
<form id="myForm" action="xxx.php" method="post" enctype=“multipart/form-data>
<td>上传头像：</td>
                <td>
                    <input style="width: 250px" type="file" name="avatar" value="上传头像">
                </td>
</form>
```



### HTML5新增输入类型

#### 输入类型：number

*<input type="number">* 用于应该包含数字值的输入字段。

您能够对数字做出限制。


<p>
根据浏览器支持：<br>
数值约束会应用到输入字段中。
</p>

<form action="/demo/demo_form.asp">
  数量（1 到 5 之间）：
  <input type="number" name="quantity" min="1" max="5">
  <input type="submit">
</form>

<p><b>注释：</b>IE9 及早期版本不支持 type="number"。</p>





#### 输入类型：date

*<input type="date">* 用于应该包含日期的输入字段。


<p>
根据浏览器支持：<br>
当您填写输入字段时会弹出日期选择器。
</p>

<form action="/demo/demo_form.asp">
  生日：
  <input type="date" name="bday">
  <input type="submit">
</form>

<p><b>注释：</b>Firefox 或者
Internet Explorer 11 以及更早版本不支持 type="date"。</p>




#### 输入类型：color

*<input type="color">* 用于应该包含颜色的输入字段。

根据浏览器支持，颜色选择器会出现输入字段中。


<form action="action_page.php">
  Select your favorite color:
  <input type="color" name="favcolor" value="#ff0000">
  <input type="submit">
</form>

<p><b>Note:</b> type="color" is not supported in Internet Explorer.</p>



#### 输入类型：range

*<input type="range">* 用于应该包含一定范围内的值的输入字段。


<p>
根据浏览器支持：<br>
输入类型 "range" 可显示为滑动控件。
</p>

<form action="/demo/demo_form.asp" method="get">
  Points:
  <input type="range" name="points" min="0" max="10">
  <input type="submit">
</form>

<p><b>注释：</b>IE9 及早期版本不支持 type="range"。</p>

您能够使用如下属性来规定限制：min、max、step、value。



#### ==输入类型：month, week, time, datetime, datetime-local, email, search, tel, url==





## `<input>`属性

### name 属性

如果要正确地被提交，每个输入字段必须设置一个 name 属性。

本例只会提交 "Last name" 输入字段：




<form action="/demo/demo_form.asp">
First name:<br>
<input type="text" value="Mickey">
<br>
Last name:<br>
<input type="text" name="lastname" value="Mouse">
<br><br>
<input type="submit" value="Submit">
</form> 



<p>如果您点击提交，表单数据会被发送到名为 demo_form.asp 的页面。</p>

<p>first name 不会被提交，因为此 input 元素没有 name 属性。</p>



### value 属性

*value* 属性规定输入字段的初始值：

<form action="">
First name:<br>
<input type="text" name="firstname" value="John">
</form>



### readonly 属性

*readonly* 属性规定输入字段为只读（不能修改）：

<form action="">
First name:<br>
<input type="text" name="firstname" value ="John" readonly>
</form>



### disabled 属性

*disabled* 属性规定输入字段是禁用的。

被禁用的元素是不可用和不可点击的。

被禁用的元素不会被提交。

<form action="">
First name:<br>
<input type="text" name="firstname" value ="John" disabled>
</form>



### size 属性

*size* 属性规定输入字段的尺寸（以字符计）：

<form action="">
First name:<br>
<input type="text" name="firstname" value ="John" size="40">
</form>





### maxlength 属性

*maxlength* 属性规定输入字段允许的最大长度：

<form action="">
First name:<br>
<input type="text" name="firstname" maxlength="10">
</form>

如设置 maxlength 属性，则输入控件不会接受超过所允许数的字符。

该属性不会提供任何反馈。如果需要提醒用户，则必须编写 JavaScript 代码。

**注释：**输入限制并非万无一失。JavaScript 提供了很多方法来增加非法输入。如需安全地限制输入，则接受者（服务器）必须同时对限制进行检查。



### autocomplete 属性 - H5新属性

autocomplete 属性规定表单或输入字段是否应该自动完成。

当自动完成开启，浏览器会基于用户之前的输入值自动填写值。

**提示：**您可以把表单的 autocomplete 设置为 on，同时把特定的输入字段设置为 off，反之亦然。

autocomplete 属性适用于 <form> 以及如下 <input> 类型：text、search、url、tel、email、password、datepickers、range 以及 color。

<form action="/example/html5/demo_form.asp" method="get" autocomplete="on">
First name:<input type="text" name="fname" /><br />
Last name: <input type="text" name="lname" /><br />
E-mail: <input type="email" name="email" autocomplete="off" /><br />
<input type="submit" />
</form>



### autofocus 属性

autofocus 属性是布尔属性。

如果设置，则规定当页面加载时 <input> 元素应该自动获得焦点。

<form action="demo_form.asp">
  First name: <input type="text" name="fname" autofocus><br>
  <input type="submit">
</form>



### form* 属性

#### formaction 属性

formaction 属性规定当提交表单时处理该输入控件的文件的 URL。

formaction 属性覆盖 <form> 元素的 action 属性。

formaction 属性适用于 type="submit" 以及 type="image"。



拥有两个两个提交按钮并对于不同动作的 HTML 表单：

<form action="/example/html5/demo_form.asp" method="get">
First name: <input type="text" name="fname" /><br />
Last name: <input type="text" name="lname" /><br />
<input type="submit" value="提交" /><br />
<input type="submit" formaction="/example/html5/demo_admin.asp" value="以管理员身份提交" />
</form>



#### formenctype 属性

formenctype 属性规定当把表单数据（form-data）提交至服务器时如何对其进行编码（仅针对 method="post" 的表单）。

#### formmethod 属性

formmethod 属性定义用以向 action URL 发送表单数据（form-data）的 HTTP 方法。

#### formnovalidate 属性

novalidate 属性是布尔属性。

如果设置，则规定在提交表单时不对 <input> 元素进行验证。

#### formtarget 属性

formtarget 属性规定的名称或关键词指示提交表单后在何处显示接收到的响应。



### height 和 width 属性

height 和 width 属性规定 <input> 元素的高度和宽度。

height 和 width 属性仅用于 <input type="image">。

**注释：**请始终规定图像的尺寸。如果浏览器不清楚图像尺寸，则页面会在图像加载时闪烁。



把图像定义为提交按钮，并设置 height 和 width 属性：

<form action="/example/html5/demo_form.asp" method="get">
  First name: <input type="text" name="fname" /><br />
  Last name: <input type="text" name="lname" /><br />
  <input type="image" src="/i/eg_submit.jpg" alt="Submit" width="128" height="128"/>
</form>

<p><b>注释：</b>默认地，image 输入类型会发生点击图像按钮时的 X 和 Y 坐标。</p>



### list 属性

list 属性引用的 <datalist> 元素中包含了 <input> 元素的预定义选项。

<form action="/action_page.php">
  <input list="browsers" name="browser">
  <datalist id="browsers">
    <option value="Internet Explorer">
    <option value="Firefox">
    <option value="Chrome">
    <option value="Opera">
    <option value="Safari">
  </datalist>
  <input type="submit" value="Submit">
</form>



### min 和 max 属性

min 和 max 属性规定 <input> 元素的最小值和最大值。

min 和 max 属性适用于如需输入类型：number、range、date、datetime、datetime-local、month、time 以及 week。

<form action="/example/html5/demo_form.asp" method="get">
Points: <input type="number" name="points" min="0" max="10" />
<input type="submit" />
</form>

### step 属性

step 属性规定 <input> 元素的合法数字间隔。

示例：如果 step="3"，则合法数字应该是 -3、0、3、6、等等。

**提示：**step 属性可与 max 以及 min 属性一同使用，来创建合法值的范围。

step 属性适用于以下输入类型：number、range、date、datetime、datetime-local、month、time 以及 week。



拥有具体的合法数字间隔的输入字段：

<form action="/example/html5/demo_form.asp" method="get">
<input type="number" name="points" step="3" />
<input type="submit" />
</form>





### multiple 属性

multiple 属性是布尔属性。

如果设置，则规定允许用户在 <input> 元素中输入一个以上的值。

multiple 属性适用于以下输入类型：email 和 file。



接受多个值的文件上传字段：

<form action="/example/html5/demo_form.asp" method="get">
选择图片：<input type="file" name="img" multiple="multiple" />
<input type="submit" />
</form>
<p>请尝试在浏览文件时选取一个以上的文件。</p>



### pattern 属性

pattern 属性规定用于检查 <input> 元素值的正则表达式。

pattern 属性适用于以下输入类型：text、search、url、tel、email、and password。

**提示：**请使用全局的 title 属性对模式进行描述以帮助用户。



只能包含三个字母的输入字段（无数字或特殊字符）：

<form action="/example/html5/demo_form.asp" method="get">
国家代码：<input type="text" name="country_code" pattern="[A-z]{3}"
title="三个字母的国家代码" />
<input type="submit" />
</form>



### placeholder 属性

placeholder 属性规定用以描述输入字段预期值的提示（样本值或有关格式的简短描述）。

该提示会在用户输入值之前显示在输入字段中。

placeholder 属性适用于以下输入类型：text、search、url、tel、email 以及 password。



拥有占位符文本的输入字段：

<form action="/example/html5/demo_form.asp" method="get">
<input type="search" name="user_search" placeholder="Search W3School" />
<input type="submit" />
</form>



### required 属性

required 属性是布尔属性。

如果设置，则规定在提交表单之前必须填写输入字段。

required 属性适用于以下输入类型：text、search、url、tel、email、password、date pickers、number、checkbox、radio、and file.



必填的输入字段：

<form action="/example/html5/demo_form.asp" method="get">
Name: <input type="text" name="usr_name" required="required" />
<input type="submit" value="提交" />
</form>











## Appendix

### 用` <fieldset> `组合表单数据

*<fieldset>* 元素组合表单中的相关数据

*<legend>* 元素为 <fieldset> 元素定义标题。




<form action="/demo/demo_form.asp">
<fieldset>
<legend>Personal information:</legend>
First name:<br>
<input type="text" name="firstname" value="Mickey">
<br>
Last name:<br>
<input type="text" name="lastname" value="Mouse">
<br><br>
<input type="submit" value="Submit">
</fieldset>
</form>




### 重置表单

```html
<html>
<head>
<script type="text/javascript">
function formReset()
  {
  document.getElementById("myForm").reset()
  }
</script>
</head>
 
<form id="myForm">
Name: <input type="text" size="20"><br />
Age: <input type="text" size="20"><br />
<br />
<input type="button" onclick="formReset()" value="Reset">
</form>
</body>
 
</html>
```



