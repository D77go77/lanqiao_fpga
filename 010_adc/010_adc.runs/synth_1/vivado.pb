
�
Sourcing tcl script '%s'
201*common2K
7D:/02_SDK2/Vivado/Vivado/2018.3/scripts/Vivado_init.tcl2default:defaultZ17-201h px� 
o
Command: %s
53*	vivadotcl2>
*synth_design -top top -part xc7s6ftgb196-12default:defaultZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7s62default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7s62default:defaultZ17-349h px� 
�
%s*synth2�
wStarting RTL Elaboration : Time (s): cpu = 00:00:01 ; elapsed = 00:00:02 . Memory (MB): peak = 430.828 ; gain = 98.266
2default:defaulth px� 
�
synthesizing module '%s'%s4497*oasys2
top2default:default2
 2default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/top.v2default:default2
12default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
adc2default:default2
 2default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/adc.v2default:default2
12default:default8@Z8-6157h px� 
Q
%s
*synth29
%	Parameter IDLE bound to: 6'b000001 
2default:defaulth p
x
� 
S
%s
*synth2;
'	Parameter WR_REQ bound to: 6'b000010 
2default:defaulth p
x
� 
T
%s
*synth2<
(	Parameter WR_WAIT bound to: 6'b000100 
2default:defaulth p
x
� 
S
%s
*synth2;
'	Parameter RD_REQ bound to: 6'b001000 
2default:defaulth p
x
� 
T
%s
*synth2<
(	Parameter RD_WAIT bound to: 6'b010000 
2default:defaulth p
x
� 
Q
%s
*synth29
%	Parameter DONE bound to: 6'b100000 
2default:defaulth p
x
� 
�
synthesizing module '%s'%s4497*oasys2
i2c2default:default2
 2default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/i2c.v2default:default2
12default:default8@Z8-6157h px� 
R
%s
*synth2:
&	Parameter IDLE bound to: 7'b0000001 
2default:defaulth p
x
� 
S
%s
*synth2;
'	Parameter START bound to: 7'b0000010 
2default:defaulth p
x
� 
U
%s
*synth2=
)	Parameter WR_DATA bound to: 7'b0000100 
2default:defaulth p
x
� 
U
%s
*synth2=
)	Parameter RD_DATA bound to: 7'b0001000 
2default:defaulth p
x
� 
S
%s
*synth2;
'	Parameter R_ACK bound to: 7'b0010000 
2default:defaulth p
x
� 
S
%s
*synth2;
'	Parameter T_ACK bound to: 7'b0100000 
2default:defaulth p
x
� 
R
%s
*synth2:
&	Parameter STOP bound to: 7'b1000000 
2default:defaulth p
x
� 
[
%s
*synth2C
/	Parameter T bound to: 100000 - type: integer 
2default:defaulth p
x
� 
^
%s
*synth2F
2	Parameter SCL_MAX bound to: 500 - type: integer 
2default:defaulth p
x
� 
c
%s
*synth2K
7	Parameter SCL_LOW_HALF bound to: 124 - type: integer 
2default:defaulth p
x
� 
d
%s
*synth2L
8	Parameter SCL_HIGH_HALF bound to: 374 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
i2c2default:default2
 2default:default2
12default:default2
12default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/i2c.v2default:default2
12default:default8@Z8-6155h px� 
�
Ginstance '%s' of module '%s' requires %s connections, but only %s given350*oasys2
inst_i2c2default:default2
i2c2default:default2
112default:default2
102default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/adc.v2default:default2
2572default:default8@Z8-350h px� 
�
�Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2"
op_rd_data_reg2default:default2
adc2default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/adc.v2default:default2
2122default:default8@Z8-5788h px� 
�
�Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
adc_mdata_r_reg2default:default2
adc2default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/adc.v2default:default2
622default:default8@Z8-5788h px� 
�
�Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2#
adc_ldata_r_reg2default:default2
adc2default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/adc.v2default:default2
622default:default8@Z8-5788h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
ready2default:default2
adc2default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/adc.v2default:default2
132default:default8@Z8-3848h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
adc2default:default2
 2default:default2
22default:default2
12default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/adc.v2default:default2
12default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
smg_proc2default:default2
 2default:default2�
kD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/smg_proc.v2default:default2
12default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
tim_proc2default:default2
 2default:default2�
kD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/tim_proc.v2default:default2
12default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
tim_proc2default:default2
 2default:default2
32default:default2
12default:default2�
kD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/tim_proc.v2default:default2
12default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
smg_ctrl2default:default2
 2default:default2�
kD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/smg_ctrl.v2default:default2
12default:default8@Z8-6157h px� 
T
%s
*synth2<
(	Parameter SEG_0 bound to: 8'b11000000 
2default:defaulth p
x
� 
T
%s
*synth2<
(	Parameter SEG_1 bound to: 8'b11111001 
2default:defaulth p
x
� 
T
%s
*synth2<
(	Parameter SEG_2 bound to: 8'b10100100 
2default:defaulth p
x
� 
T
%s
*synth2<
(	Parameter SEG_3 bound to: 8'b10110000 
2default:defaulth p
x
� 
T
%s
*synth2<
(	Parameter SEG_4 bound to: 8'b10011001 
2default:defaulth p
x
� 
T
%s
*synth2<
(	Parameter SEG_5 bound to: 8'b10010010 
2default:defaulth p
x
� 
T
%s
*synth2<
(	Parameter SEG_6 bound to: 8'b10000010 
2default:defaulth p
x
� 
T
%s
*synth2<
(	Parameter SEG_7 bound to: 8'b11111000 
2default:defaulth p
x
� 
T
%s
*synth2<
(	Parameter SEG_8 bound to: 8'b10000000 
2default:defaulth p
x
� 
T
%s
*synth2<
(	Parameter SEG_9 bound to: 8'b10010000 
2default:defaulth p
x
� 
T
%s
*synth2<
(	Parameter SEG_P bound to: 8'b10001100 
2default:defaulth p
x
� 
W
%s
*synth2?
+	Parameter SEG_gang bound to: 8'b10111111 
2default:defaulth p
x
� 
W
%s
*synth2?
+	Parameter SEG_NULL bound to: 8'b11111111 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
smg_ctrl2default:default2
 2default:default2
42default:default2
12default:default2�
kD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/smg_ctrl.v2default:default2
12default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
smg_proc2default:default2
 2default:default2
52default:default2
12default:default2�
kD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/smg_proc.v2default:default2
12default:default8@Z8-6155h px� 
�
�Register %s in module %s is has both Set and reset with same priority. This may cause simulation mismatches. Consider rewriting code 
4193*oasys2
bcd_reg2default:default2
top2default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/top.v2default:default2
262default:default8@Z8-5788h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
clk2default:default2
top2default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/top.v2default:default2
572default:default8@Z8-3848h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
top2default:default2
 2default:default2
62default:default2
12default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/top.v2default:default2
12default:default8@Z8-6155h px� 
w
!design %s has unconnected port %s3331*oasys2
adc2default:default2
ready2default:defaultZ8-3331h px� 
|
!design %s has unconnected port %s3331*oasys2
adc2default:default2

wr_data[7]2default:defaultZ8-3331h px� 
|
!design %s has unconnected port %s3331*oasys2
adc2default:default2

wr_data[6]2default:defaultZ8-3331h px� 
|
!design %s has unconnected port %s3331*oasys2
adc2default:default2

wr_data[5]2default:defaultZ8-3331h px� 
|
!design %s has unconnected port %s3331*oasys2
adc2default:default2

wr_data[4]2default:defaultZ8-3331h px� 
|
!design %s has unconnected port %s3331*oasys2
adc2default:default2

wr_data[3]2default:defaultZ8-3331h px� 
|
!design %s has unconnected port %s3331*oasys2
adc2default:default2

wr_data[2]2default:defaultZ8-3331h px� 
|
!design %s has unconnected port %s3331*oasys2
adc2default:default2

wr_data[1]2default:defaultZ8-3331h px� 
|
!design %s has unconnected port %s3331*oasys2
adc2default:default2

wr_data[0]2default:defaultZ8-3331h px� 
}
!design %s has unconnected port %s3331*oasys2
adc2default:default2
wr_data_vld2default:defaultZ8-3331h px� 
�
%s*synth2�
xFinished RTL Elaboration : Time (s): cpu = 00:00:01 ; elapsed = 00:00:02 . Memory (MB): peak = 486.898 ; gain = 154.336
2default:defaulth px� 
D
%s
*synth2,

Report Check Netlist: 
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
u
%s
*synth2]
I|      |Item              |Errors |Warnings |Status |Description       |
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
u
%s
*synth2]
I|1     |multi_driven_nets |      0|        0|Passed |Multi driven nets |
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
�
'tying undriven pin %s:%s to constant 0
3295*oasys2
adc_inst2default:default2
wr_req2default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/top.v2default:default2
392default:default8@Z8-3295h px� 
�
'tying undriven pin %s:%s to constant 0
3295*oasys2
seg_init2default:default2
clk2default:default2|
fD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/top.v2default:default2
562default:default8@Z8-3295h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:01 ; elapsed = 00:00:02 . Memory (MB): peak = 486.898 ; gain = 154.336
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:01 ; elapsed = 00:00:02 . Memory (MB): peak = 486.898 ; gain = 154.336
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
U
Loading part %s157*device2"
xc7s6ftgb196-12default:defaultZ21-403h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
Parsing XDC File [%s]
179*designutils2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default8Z20-179h px� 
�
No nets matched '%s'.
507*	planAhead2
rst_IBUF2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
12default:default8@Z12-507h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
12default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
spi_clk2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1052default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1052default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
spi_miso2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1062default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1062default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
spi_mosi2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1072default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1072default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
spi_csn2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1082default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1082default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
spi_clk2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1102default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1102default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
spi_miso2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1112default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1112default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
spi_mosi2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1122default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1122default:default8@Z17-55h px�
�
No ports matched '%s'.
584*	planAhead2
spi_csn2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1132default:default8@Z12-584h px�
�
"'%s' expects at least one object.
55*common2 
set_property2default:default2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2
1132default:default8@Z17-55h px�
�
Finished Parsing XDC File [%s]
178*designutils2}
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2{
gD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/constrs_1/new/sm.xdc2default:default2)
.Xil/top_propImpl.xdc2default:defaultZ1-236h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
784.6172default:default2
0.0002default:defaultZ17-268h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0012default:default2
784.6172default:default2
0.0002default:defaultZ17-268h px� 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
784.6172default:default2
0.0002default:defaultZ17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common24
 Constraint Validation Runtime : 2default:default2
00:00:002default:default2 
00:00:00.0012default:default2
784.6172default:default2
0.0002default:defaultZ17-268h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
~Finished Constraint Validation : Time (s): cpu = 00:00:04 ; elapsed = 00:00:08 . Memory (MB): peak = 784.617 ; gain = 452.055
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
I
%s
*synth21
Loading part: xc7s6ftgb196-1
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:04 ; elapsed = 00:00:08 . Memory (MB): peak = 784.617 ; gain = 452.055
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Z
%s
*synth2B
.Start Applying 'set_property' XDC Constraints
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:04 ; elapsed = 00:00:08 . Memory (MB): peak = 784.617 ; gain = 452.055
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2

cstate_reg2default:default2
i2c2default:defaultZ8-802h px� 
w
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
sda_out2default:defaultZ8-5546h px� 
w
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
sda_out2default:defaultZ8-5546h px� 
w
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
sda_out2default:defaultZ8-5546h px� 
v
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
nstate2default:defaultZ8-5546h px� 
s
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
num2default:defaultZ8-5546h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2

cstate_reg2default:default2
adc2default:defaultZ8-802h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
cmd_vld2default:default2
32default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
cmd2default:default2
32default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2

op_wr_data2default:default2
32default:default2
52default:defaultZ8-5544h px� 
v
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2
nstate2default:defaultZ8-5546h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
nstate2default:default2
12default:default2
52default:defaultZ8-5544h px� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
.
%s
*synth2
*
2default:defaulth p
x
� 
�
%s
*synth2s
_                    IDLE |                          0000001 |                          0000001
2default:defaulth p
x
� 
�
%s
*synth2s
_                   START |                          0000010 |                          0000010
2default:defaulth p
x
� 
�
%s
*synth2s
_                 WR_DATA |                          0000100 |                          0000100
2default:defaulth p
x
� 
�
%s
*synth2s
_                   R_ACK |                          0010000 |                          0010000
2default:defaulth p
x
� 
�
%s
*synth2s
_                 RD_DATA |                          0001000 |                          0001000
2default:defaulth p
x
� 
�
%s
*synth2s
_                   T_ACK |                          0100000 |                          0100000
2default:defaulth p
x
� 
�
%s
*synth2s
_                    STOP |                          1000000 |                          1000000
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
6No Re-encoding of one hot register '%s' in module '%s'3445*oasys2

cstate_reg2default:default2
i2c2default:defaultZ8-3898h px� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
.
%s
*synth2
*
2default:defaulth p
x
� 
�
%s
*synth2s
_                    IDLE |                           000001 |                           000001
2default:defaulth p
x
� 
�
%s
*synth2s
_                  WR_REQ |                           000010 |                           000010
2default:defaulth p
x
� 
�
%s
*synth2s
_                 WR_WAIT |                           000100 |                           000100
2default:defaulth p
x
� 
�
%s
*synth2s
_                  RD_REQ |                           001000 |                           001000
2default:defaulth p
x
� 
�
%s
*synth2s
_                 RD_WAIT |                           010000 |                           010000
2default:defaulth p
x
� 
�
%s
*synth2s
_                    DONE |                           100000 |                           100000
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
6No Re-encoding of one hot register '%s' in module '%s'3445*oasys2

cstate_reg2default:default2
adc2default:defaultZ8-3898h px� 
�
!inferring latch for variable '%s'327*oasys2
wei_reg2default:default2�
kD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/smg_ctrl.v2default:default2
262default:default8@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
duan_reg2default:default2�
kD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.srcs/sources_1/new/smg_ctrl.v2default:default2
272default:default8@Z8-327h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:04 ; elapsed = 00:00:08 . Memory (MB): peak = 784.617 ; gain = 452.055
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit       Adders := 3     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      9 Bit       Adders := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      4 Bit       Adders := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit       Adders := 2     
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               12 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                9 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                8 Bit    Registers := 8     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                4 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                3 Bit    Registers := 3     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 8     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 3     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   4 Input     12 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     12 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      9 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input      8 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   6 Input      8 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   8 Input      7 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      7 Bit        Muxes := 3     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      6 Bit        Muxes := 5     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   7 Input      6 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      4 Bit        Muxes := 8     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   8 Input      4 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   6 Input      4 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   4 Input      4 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input      4 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit        Muxes := 5     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 11    
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   8 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   6 Input      1 Bit        Muxes := 6     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input      1 Bit        Muxes := 5     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   4 Input      1 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   7 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Y
%s
*synth2A
-Start RTL Hierarchical Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Hierarchical RTL Component report 
2default:defaulth p
x
� 
8
%s
*synth2 
Module top 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               12 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   4 Input     12 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     12 Bit        Muxes := 1     
2default:defaulth p
x
� 
8
%s
*synth2 
Module i2c 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit       Adders := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      9 Bit       Adders := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      4 Bit       Adders := 1     
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                9 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                8 Bit    Registers := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                4 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 4     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      9 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input      8 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   8 Input      7 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      7 Bit        Muxes := 3     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      6 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      4 Bit        Muxes := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   8 Input      4 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 7     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   8 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   6 Input      1 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
8
%s
*synth2 
Module adc 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit       Adders := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit       Adders := 1     
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                8 Bit    Registers := 6     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                3 Bit    Registers := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 3     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   6 Input      8 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input      8 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   7 Input      6 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      6 Bit        Muxes := 3     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      5 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   6 Input      4 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      4 Bit        Muxes := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   4 Input      4 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input      4 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit        Muxes := 3     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      1 Bit        Muxes := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   6 Input      1 Bit        Muxes := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   4 Input      1 Bit        Muxes := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   7 Input      1 Bit        Muxes := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   3 Input      1 Bit        Muxes := 4     
2default:defaulth p
x
� 
=
%s
*synth2%
Module tim_proc 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input     32 Bit        Muxes := 1     
2default:defaulth p
x
� 
=
%s
*synth2%
Module smg_proc 
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit       Adders := 1     
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                3 Bit    Registers := 1     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
[
%s
*synth2C
/Finished RTL Hierarchical Component Statistics
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2i
UPart Resources:
DSPs: 10 (col length:20)
BRAMs: 10 (col length: RAMB18 20 RAMB36 10)
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
W
%s
*synth2?
+Start Cross Boundary and Area Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
]
%s
*synth2E
1Warning: Parallel synthesis criteria is not met 
2default:defaulth p
x
� 
�
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2)
adc_inst/inst_i2c/num2default:defaultZ8-5546h px� 
�
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2-
adc_inst/inst_i2c/sda_out2default:defaultZ8-5546h px� 
�
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2-
adc_inst/inst_i2c/sda_out2default:defaultZ8-5546h px� 
�
8ROM "%s" won't be mapped to RAM because it is too sparse3998*oasys2-
adc_inst/inst_i2c/sda_out2default:defaultZ8-5546h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2)
adc_inst/rd_req_r_reg2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[7]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2)
adc_inst/wr_req_r_reg2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[6]2default:defaultZ8-3886h px� 
�
6propagating constant %s across sequential element (%s)3333*oasys2
12default:default2)
\adc_inst/num_reg[0] 2default:defaultZ8-3333h px� 
�
6propagating constant %s across sequential element (%s)3333*oasys2
02default:default2)
\adc_inst/num_reg[1] 2default:defaultZ8-3333h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_r_reg[7]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[7]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2*
adc_inst/addr_r_reg[7]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[6]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_w_reg[7]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[5]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_r_reg[6]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[6]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2*
adc_inst/addr_r_reg[6]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[6]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_w_reg[6]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[4]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_r_reg[5]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[5]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2*
adc_inst/addr_r_reg[5]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[4]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_w_reg[5]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[3]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_r_reg[4]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[4]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2*
adc_inst/addr_r_reg[4]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[4]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_w_reg[4]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[2]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_r_reg[3]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[3]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2*
adc_inst/addr_r_reg[3]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[2]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_w_reg[3]2default:default2
FDC2default:default2/
adc_inst/device_id_r_reg[0]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_r_reg[2]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[2]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2*
adc_inst/addr_r_reg[2]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[2]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_w_reg[2]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[1]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_r_reg[1]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[1]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2*
adc_inst/addr_r_reg[1]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[1]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_w_reg[1]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[0]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2*
adc_inst/addr_r_reg[0]2default:default2
FDC2default:default2/
adc_inst/device_id_w_reg[0]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2/
adc_inst/device_id_w_reg[0]2default:default2
FDC2default:default2'
adc_inst/cmd_reg[4]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2
bcd_reg[10]2default:default2
FDE2default:default2
bcd_reg[11]2default:defaultZ8-3886h px� 
�
6propagating constant %s across sequential element (%s)3333*oasys2
02default:default2!
\bcd_reg[11] 2default:defaultZ8-3333h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2'
adc_inst/cmd_reg[4]2default:default2
FDC2default:default2$
dsp_data_reg[12]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[12]2default:default2
FDC2default:default2$
dsp_data_reg[13]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[16]2default:default2
FDC2default:default2$
dsp_data_reg[13]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[20]2default:default2
FDC2default:default2$
dsp_data_reg[13]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[24]2default:default2
FDC2default:default2$
dsp_data_reg[13]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[28]2default:default2
FDC2default:default2$
dsp_data_reg[13]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[13]2default:default2
FDC2default:default2$
dsp_data_reg[17]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[17]2default:default2
FDC2default:default2$
dsp_data_reg[21]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[21]2default:default2
FDC2default:default2$
dsp_data_reg[25]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[25]2default:default2
FDC2default:default2$
dsp_data_reg[30]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[29]2default:default2
FDP2default:default2$
dsp_data_reg[14]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[14]2default:default2
FDP2default:default2$
dsp_data_reg[15]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[18]2default:default2
FDP2default:default2$
dsp_data_reg[15]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[22]2default:default2
FDP2default:default2$
dsp_data_reg[15]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[26]2default:default2
FDP2default:default2$
dsp_data_reg[15]2default:defaultZ8-3886h px� 
�
6propagating constant %s across sequential element (%s)3333*oasys2
02default:default2&
\dsp_data_reg[30] 2default:defaultZ8-3333h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[15]2default:default2
FDP2default:default2$
dsp_data_reg[19]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[19]2default:default2
FDP2default:default2$
dsp_data_reg[23]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[23]2default:default2
FDP2default:default2$
dsp_data_reg[27]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[27]2default:default2
FDP2default:default2$
dsp_data_reg[31]2default:defaultZ8-3886h px� 
�
6propagating constant %s across sequential element (%s)3333*oasys2
12default:default2&
\dsp_data_reg[31] 2default:defaultZ8-3333h px� 
�
6propagating constant %s across sequential element (%s)3333*oasys2
12default:default26
"\seg_init/smg_display/duan_reg[7] 2default:defaultZ8-3333h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2.
adc_inst/op_wr_data_reg[7]2default:default2
FDCE2default:default2.
adc_inst/op_wr_data_reg[3]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2.
adc_inst/op_wr_data_reg[5]2default:default2
FDCE2default:default2.
adc_inst/op_wr_data_reg[3]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys26
"adc_inst/inst_i2c/wr_data_r_reg[7]2default:default2
FDCE2default:default26
"adc_inst/inst_i2c/wr_data_r_reg[3]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys26
"adc_inst/inst_i2c/wr_data_r_reg[5]2default:default2
FDCE2default:default26
"adc_inst/inst_i2c/wr_data_r_reg[3]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys2$
dsp_data_reg[10]2default:default2
FDP2default:default2$
dsp_data_reg[11]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys23
seg_init/smg_display/wei_reg[0]2default:default2
LDP2default:default24
 seg_init/smg_display/duan_reg[0]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys23
seg_init/smg_display/wei_reg[1]2default:default2
LDP2default:default23
seg_init/smg_display/wei_reg[2]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys24
 seg_init/smg_display/duan_reg[7]2default:default2
LDP2default:default23
seg_init/smg_display/wei_reg[2]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys23
seg_init/smg_display/wei_reg[2]2default:default2
LDP2default:default23
seg_init/smg_display/wei_reg[3]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys23
seg_init/smg_display/wei_reg[3]2default:default2
LDP2default:default23
seg_init/smg_display/wei_reg[4]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys23
seg_init/smg_display/wei_reg[4]2default:default2
LDP2default:default23
seg_init/smg_display/wei_reg[5]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys23
seg_init/smg_display/wei_reg[5]2default:default2
LDP2default:default23
seg_init/smg_display/wei_reg[6]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys23
seg_init/smg_display/wei_reg[6]2default:default2
LDP2default:default23
seg_init/smg_display/wei_reg[7]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys23
seg_init/smg_display/wei_reg[7]2default:default2
LDP2default:default24
 seg_init/smg_display/duan_reg[2]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys24
 seg_init/smg_display/duan_reg[0]2default:default2
LDP2default:default24
 seg_init/smg_display/duan_reg[1]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys24
 seg_init/smg_display/duan_reg[1]2default:default2
LDP2default:default24
 seg_init/smg_display/duan_reg[4]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys24
 seg_init/smg_display/duan_reg[2]2default:default2
LDP2default:default24
 seg_init/smg_display/duan_reg[3]2default:defaultZ8-3886h px� 
�
6propagating constant %s across sequential element (%s)3333*oasys2
12default:default26
"\seg_init/smg_display/duan_reg[3] 2default:defaultZ8-3333h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys24
 seg_init/smg_display/duan_reg[4]2default:default2
LDP2default:default24
 seg_init/smg_display/duan_reg[5]2default:defaultZ8-3886h px� 
�
"merging instance '%s' (%s) to '%s'3436*oasys24
 seg_init/smg_display/duan_reg[5]2default:default2
LDP2default:default24
 seg_init/smg_display/duan_reg[6]2default:defaultZ8-3886h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys24
 seg_init/smg_display/duan_reg[3]2default:default2
top2default:defaultZ8-3332h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:05 ; elapsed = 00:00:09 . Memory (MB): peak = 784.617 ; gain = 452.055
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
R
%s
*synth2:
&Start Applying XDC Timing Constraints
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:08 ; elapsed = 00:00:14 . Memory (MB): peak = 784.617 ; gain = 452.055
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
F
%s
*synth2.
Start Timing Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
|Finished Timing Optimization : Time (s): cpu = 00:00:08 ; elapsed = 00:00:14 . Memory (MB): peak = 784.617 ; gain = 452.055
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
{Finished Technology Mapping : Time (s): cpu = 00:00:08 ; elapsed = 00:00:14 . Memory (MB): peak = 798.910 ; gain = 466.348
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Q
%s
*synth29
%Start Flattening Before IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
T
%s
*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
uFinished IO Insertion : Time (s): cpu = 00:00:08 ; elapsed = 00:00:15 . Memory (MB): peak = 798.910 ; gain = 466.348
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
D
%s
*synth2,

Report Check Netlist: 
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
u
%s
*synth2]
I|      |Item              |Errors |Warnings |Status |Description       |
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
u
%s
*synth2]
I|1     |multi_driven_nets |      0|        0|Passed |Multi driven nets |
2default:defaulth p
x
� 
u
%s
*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:08 ; elapsed = 00:00:15 . Memory (MB): peak = 798.910 ; gain = 466.348
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-

Report RTL Partitions: 
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
W
%s
*synth2?
++-+--------------+------------+----------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
L
%s
*synth24
 Start Rebuilding User Hierarchy
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:08 ; elapsed = 00:00:15 . Memory (MB): peak = 798.910 ; gain = 466.348
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Start Renaming Generated Ports
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:08 ; elapsed = 00:00:15 . Memory (MB): peak = 798.910 ; gain = 466.348
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:08 ; elapsed = 00:00:15 . Memory (MB): peak = 798.910 ; gain = 466.348
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
J
%s
*synth22
Start Renaming Generated Nets
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:08 ; elapsed = 00:00:15 . Memory (MB): peak = 798.910 ; gain = 466.348
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
J
%s
*synth22
| |BlackBox name |Instances |
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px� 
D
%s*synth2,
+------+-------+------+
2default:defaulth px� 
D
%s*synth2,
|      |Cell   |Count |
2default:defaulth px� 
D
%s*synth2,
+------+-------+------+
2default:defaulth px� 
D
%s*synth2,
|1     |BUFG   |     2|
2default:defaulth px� 
D
%s*synth2,
|2     |CARRY4 |     1|
2default:defaulth px� 
D
%s*synth2,
|3     |LUT1   |     6|
2default:defaulth px� 
D
%s*synth2,
|4     |LUT2   |    10|
2default:defaulth px� 
D
%s*synth2,
|5     |LUT3   |     8|
2default:defaulth px� 
D
%s*synth2,
|6     |LUT4   |    15|
2default:defaulth px� 
D
%s*synth2,
|7     |LUT5   |    18|
2default:defaulth px� 
D
%s*synth2,
|8     |LUT6   |    40|
2default:defaulth px� 
D
%s*synth2,
|9     |FDCE   |    38|
2default:defaulth px� 
D
%s*synth2,
|10    |FDPE   |     5|
2default:defaulth px� 
D
%s*synth2,
|11    |LDP    |     1|
2default:defaulth px� 
D
%s*synth2,
|12    |IBUF   |     2|
2default:defaulth px� 
D
%s*synth2,
|13    |OBUF   |    17|
2default:defaulth px� 
D
%s*synth2,
|14    |OBUFT  |     1|
2default:defaulth px� 
D
%s*synth2,
+------+-------+------+
2default:defaulth px� 
E
%s
*synth2-

Report Instance Areas: 
2default:defaulth p
x
� 
W
%s
*synth2?
++------+----------------+---------+------+
2default:defaulth p
x
� 
W
%s
*synth2?
+|      |Instance        |Module   |Cells |
2default:defaulth p
x
� 
W
%s
*synth2?
++------+----------------+---------+------+
2default:defaulth p
x
� 
W
%s
*synth2?
+|1     |top             |         |   164|
2default:defaulth p
x
� 
W
%s
*synth2?
+|2     |  adc_inst      |adc      |   140|
2default:defaulth p
x
� 
W
%s
*synth2?
+|3     |    inst_i2c    |i2c      |   107|
2default:defaulth p
x
� 
W
%s
*synth2?
+|4     |  seg_init      |smg_proc |     2|
2default:defaulth p
x
� 
W
%s
*synth2?
+|5     |    smg_display |smg_ctrl |     2|
2default:defaulth p
x
� 
W
%s
*synth2?
++------+----------------+---------+------+
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:08 ; elapsed = 00:00:15 . Memory (MB): peak = 798.910 ; gain = 466.348
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
r
%s
*synth2Z
FSynthesis finished with 0 errors, 0 critical warnings and 3 warnings.
2default:defaulth p
x
� 
�
%s
*synth2�
~Synthesis Optimization Runtime : Time (s): cpu = 00:00:05 ; elapsed = 00:00:11 . Memory (MB): peak = 798.910 ; gain = 168.629
2default:defaulth p
x
� 
�
%s
*synth2�
Synthesis Optimization Complete : Time (s): cpu = 00:00:08 ; elapsed = 00:00:15 . Memory (MB): peak = 798.910 ; gain = 466.348
2default:defaulth p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
e
-Analyzing %s Unisim elements for replacement
17*netlist2
22default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
12default:default2
12default:defaultZ31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
798.9102default:default2
0.0002default:defaultZ17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2m
Y  A total of 1 instances were transformed.
  LDP => LDPE (inverted pins: G): 1 instances
2default:defaultZ1-111h px� 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1252default:default2
312default:default2
92default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:00:102default:default2
00:00:172default:default2
798.9102default:default2
479.2192default:defaultZ17-268h px� 
~
4The following parameters have non-default value.
%s
395*common2&
general.maxThreads2default:defaultZ17-600h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
798.9102default:default2
0.0002default:defaultZ17-268h px� 
K
"No constraints selected for write.1103*constraintsZ18-5210h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2v
bD:/01_my_document/desktop/01_contest_about/FPGACT137X/my_code/010_adc/010_adc.runs/synth_1/top.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2p
\Executing : report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb
2default:defaulth px� 
�
Exiting %s at %s...
206*common2
Vivado2default:default2,
Sat Dec  7 20:56:53 20242default:defaultZ17-206h px� 


End Record