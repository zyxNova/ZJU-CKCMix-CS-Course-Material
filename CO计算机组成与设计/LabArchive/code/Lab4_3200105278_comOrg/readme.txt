Vivado Version: 2021.2

SCPU是Lab4的工程目录，实现了所有要求的基本SCPU指令和五种异常、两种中断处理。
已经在core_tb.v和imem_data.mem中写好了仿真程序和机器码，如无意外点击Run Simulation即可运行仿真。
推荐运行35us，点击Zoom Fit再放大，可以看到各个信号的变化。
Top_final.bit供上板验证使用。

test_final目录是我写的测试代码。
test_final.s是汇编指令，有比较详细的注释。使用vscode中的venus插件可以生成PC、机器码和汇编指令的对应。
trim.cpp是我写的截取机器码的C++程序，可以不管。
5_final.mem是最终版本的imem_data.mem的内容，已经载入到imem_data.mem中。

