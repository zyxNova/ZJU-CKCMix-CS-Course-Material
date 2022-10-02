Vivado Version: 2021.2

project1_MUX8T1是一位八选一的多路选择器，只有仿真验证，没有bit文件。

project2_LED_Decoder2T4包括了自己定义的De24（2to4的译码器）的IP核，
以及引用该IP核用于上板验证的工程LED_Decoder。该工程使用两个开关作为输入，四个LED灯作为译码后的输出。
Lab1.bit是该工程的bit文件。

project3_ALU包含了ALU的设计实现和仿真验证。根目录下的IP文件夹内是ALU工程要调用的IP核。
由于IP核在本地统一存放在D盘根目录下，拷贝到本文件夹后没有修改XML文件内的路径，可能会引起IP核无法正常调用的问题。
ALU的功能和文档要求的有所不同，不支持两个输入数字的大小比较，而支持XOR、NOR运算。

