Vivado Version: 2021.2

Mul_Div是综合两类PPT做出的乘法器和除法器。Mul.v和Div.v是源文件。
仿真需要分别将tb.v和div_tb.v设置为顶层模块。

尝试修改了top.v，想要上板验证，但是在implementation时会报错：

[Opt 31-67] Problem: A LUT5 cell in the design is missing a connection on input pin I0, 
which is used by the LUT equation. This pin has either been left unconnected in the design 
or the connection was removed due to the trimming of unused logic. 
The LUT cell name is: vga_muldiv/vga_debugger/display_data_reg_0_63_0_2_i_101.

经周炀叶同学指出，vga模块引用时应对不足32位的输入信号补齐，添加相应代码后可以生成比特流，
但是所有信号显示均为0。由于时间紧迫没有再debug。

float_add是浮点加法器，直接仿真即可。

