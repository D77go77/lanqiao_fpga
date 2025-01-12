
# 蓝桥杯 FPGA 设计与开发示例

本仓库包含了一系列针对蓝桥杯竞赛的 FPGA 设计与开发示例，旨在帮助参赛者熟悉 FPGA 的开发流程和常用模块的实现。

## 项目列表

- **001_led_blink**: 实现 LED 闪烁功能，帮助理解基本的 FPGA 输出控制。
- **002_led_water**: 实现流水灯效果，展示多路 LED 的顺序点亮。
- **003_tim**: 演示定时器的设计与应用。
- **004_tim_led_key**: 结合定时器、LED 和按键的综合应用示例。
- **005_buzz**: 实现蜂鸣器控制，演示声音的产生与控制。
- **006_smg**: 驱动数码管显示数字或字符。
- **007_key_led**: 按键控制 LED 的状态变化。
- **008_key_smg_cnt**: 按键控制数码管计数显示。
- **009_at24c02_WandR_error**: 与 AT24C02 EEPROM 的读写操作示例（包含错误处理）。
- **010_adc**: 模拟数字转换（ADC）的实现与数据读取。
- **100_sim2**: 综合模拟示例 2，包含多个功能模块的集成应用。
- **100_sim2WithE2prom_error**: 综合模拟示例 2，增加 EEPROM 读写功能，并处理可能的错误。

## 快速开始

1. **环境准备**:
   - 安装 FPGA 开发工具，如 [Xilinx Vivado](https://www.xilinx.com/products/design-tools/vivado.html) 或 [Intel Quartus Prime](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/overview.html)。
   - 确保已安装相应的 FPGA 开发板驱动程序。

2. **克隆仓库**:
   ```bash
   git clone https://github.com/D77go77/lanqiao_fpga.git
   ```

3. **打开项目**:
   - 在开发工具中，打开相应的项目文件或创建新项目并导入所需的 Verilog/VHDL 源代码。

4. **编译与综合**:
   - 在开发环境中运行综合（Synthesis）和实现（Implementation）流程，确保设计无错误。

5. **下载与测试**:
   - 将生成的比特流文件下载到 FPGA 开发板上。
   - 根据项目功能，验证硬件行为是否符合预期，例如观察 LED、数码管显示或蜂鸣器声音等。

## 资源

- [Verilog 教程](https://www.verilog.com/): 提供 Verilog 硬件描述语言的学习资料。
- [VHDL 教程](https://www.vhdl.org/): 提供 VHDL 硬件描述语言的学习资料。
- [FPGA 开发板手册](https://www.fpga.com/): 包含常用 FPGA 开发板的使用指南和技术规格。

## 许可证

本项目基于 GPL-3.0 许可证进行分发。有关详细信息，请参阅 [LICENSE](./LICENSE) 文件。

