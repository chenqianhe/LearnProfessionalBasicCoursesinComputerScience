
w
Command: %s
53*	vivadotcl2I
5synth_design -top dynamic_scan -part xc7a100tcsg324-12default:defaultZ4-113h px
7
Starting synth_design
149*	vivadotclZ4-321h px
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7a100t2default:defaultZ17-347h px
?
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7a100t2default:defaultZ17-349h px
?
%s*synth2?
wStarting RTL Elaboration : Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 247.113 ; gain = 74.371
2default:defaulth px
?
synthesizing module '%s'638*oasys2 
dynamic_scan2default:default2I
3F:/Cqh_files/2021verilog/upload/lab3/dynamic_scan.v2default:default2
12default:default8@Z8-638h px
?
synthesizing module '%s'638*oasys2
divider2default:default2D
.F:/Cqh_files/2021verilog/upload/lab3/divider.v2default:default2
12default:default8@Z8-638h px
[
%s*synth2F
2	Parameter N bound to: 100000000 - type: integer 
2default:defaulth px
?
%done synthesizing module '%s' (%s#%s)256*oasys2
divider2default:default2
12default:default2
12default:default2D
.F:/Cqh_files/2021verilog/upload/lab3/divider.v2default:default2
12default:default8@Z8-256h px
?
synthesizing module '%s'638*oasys2
counter2default:default2D
.F:/Cqh_files/2021verilog/upload/lab3/counter.v2default:default2
12default:default8@Z8-638h px
?
%done synthesizing module '%s' (%s#%s)256*oasys2
counter2default:default2
22default:default2
12default:default2D
.F:/Cqh_files/2021verilog/upload/lab3/counter.v2default:default2
12default:default8@Z8-256h px
?
synthesizing module '%s'638*oasys2

decoder3_82default:default2G
1F:/Cqh_files/2021verilog/upload/lab3/decoder3_8.v2default:default2
12default:default8@Z8-638h px
?
default block is never used226*oasys2G
1F:/Cqh_files/2021verilog/upload/lab3/decoder3_8.v2default:default2
72default:default8@Z8-226h px
?
%done synthesizing module '%s' (%s#%s)256*oasys2

decoder3_82default:default2
32default:default2
12default:default2G
1F:/Cqh_files/2021verilog/upload/lab3/decoder3_8.v2default:default2
12default:default8@Z8-256h px
?
synthesizing module '%s'638*oasys2
rom8x42default:default2C
-F:/Cqh_files/2021verilog/upload/lab3/rom8x4.v2default:default2
12default:default8@Z8-638h px
?
%done synthesizing module '%s' (%s#%s)256*oasys2
rom8x42default:default2
42default:default2
12default:default2C
-F:/Cqh_files/2021verilog/upload/lab3/rom8x4.v2default:default2
12default:default8@Z8-256h px
?
synthesizing module '%s'638*oasys2
pattern2default:default2D
.F:/Cqh_files/2021verilog/upload/lab3/pattern.v2default:default2
12default:default8@Z8-638h px
?
default block is never used226*oasys2D
.F:/Cqh_files/2021verilog/upload/lab3/pattern.v2default:default2
72default:default8@Z8-226h px
?
%done synthesizing module '%s' (%s#%s)256*oasys2
pattern2default:default2
52default:default2
12default:default2D
.F:/Cqh_files/2021verilog/upload/lab3/pattern.v2default:default2
12default:default8@Z8-256h px
?
%done synthesizing module '%s' (%s#%s)256*oasys2 
dynamic_scan2default:default2
62default:default2
12default:default2I
3F:/Cqh_files/2021verilog/upload/lab3/dynamic_scan.v2default:default2
12default:default8@Z8-256h px
?
%s*synth2?
xFinished RTL Elaboration : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 281.344 ; gain = 108.602
2default:defaulth px
A
%s*synth2,

Report Check Netlist: 
2default:defaulth px
r
%s*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth px
r
%s*synth2]
I|      |Item              |Errors |Warnings |Status |Description       |
2default:defaulth px
r
%s*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth px
r
%s*synth2]
I|1     |multi_driven_nets |      0|        0|Passed |Multi driven nets |
2default:defaulth px
r
%s*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
?Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 281.344 ; gain = 108.602
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
T
Loading part %s157*device2$
xc7a100tcsg324-12default:defaultZ21-403h px
H
)Preparing netlist for logic optimization
349*projectZ1-570h px
;

Processing XDC Constraints
244*projectZ1-262h px
:
Initializing timing engine
348*projectZ1-569h px
?
Parsing XDC File [%s]
179*designutils2N
:F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc2default:defaultZ20-179h px
?
Finished Parsing XDC File [%s]
178*designutils2N
:F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc2default:defaultZ20-178h px
E
&Completed Processing XDC Constraints

245*projectZ1-263h px
{
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common24
 Constraint Validation Runtime : 2default:default2
00:00:002default:default2 
00:00:00.0032default:default2
582.1682default:default2
0.0002default:defaultZ17-268h px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
~Finished Constraint Validation : Time (s): cpu = 00:00:08 ; elapsed = 00:00:08 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
S
%s*synth2>
*Start Loading Part and Timing Information
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
H
%s*synth23
Loading part: xc7a100tcsg324-1
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
?Finished Loading Part and Timing Information : Time (s): cpu = 00:00:08 ; elapsed = 00:00:08 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
W
%s*synth2B
.Start Applying 'set_property' XDC Constraints
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
{incorrect argument "-dict" for "set_property" at line 7 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 7 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 60 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 60 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 61 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 61 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 62 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 62 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 63 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 63 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 64 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 64 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 65 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 65 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 66 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 66 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 68 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 68 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 70 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 70 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 71 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 71 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 72 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 72 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 73 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 73 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 74 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 74 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 75 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 75 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 76 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 76 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 77 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 77 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
?Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:08 ; elapsed = 00:00:08 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
^ROM "%s" won't be mapped to RAM because address size (%s) is larger than maximum supported(%s)3997*oasys2
clk_N2default:default2
322default:default2
182default:defaultZ8-5545h px
?
^ROM "%s" won't be mapped to RAM because address size (%s) is larger than maximum supported(%s)3997*oasys2
counter2default:default2
322default:default2
182default:defaultZ8-5545h px
?
[ROM "%s" won't be mapped to Block RAM because address size (%s) smaller than threshold (%s)3996*oasys2
mem2default:default2
32default:default2
52default:defaultZ8-5544h px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
?Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:08 ; elapsed = 00:00:09 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
B
%s*synth2-

Report RTL Partitions: 
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
I
%s*synth24
 Start RTL Component Statistics 
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
H
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px
7
%s*synth2"
+---Adders : 
2default:defaulth px
W
%s*synth2B
.	   2 Input     32 Bit       Adders := 1     
2default:defaulth px
W
%s*synth2B
.	   2 Input      3 Bit       Adders := 1     
2default:defaulth px
:
%s*synth2%
+---Registers : 
2default:defaulth px
W
%s*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth px
W
%s*synth2B
.	                3 Bit    Registers := 1     
2default:defaulth px
W
%s*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth px
6
%s*synth2!
+---Muxes : 
2default:defaulth px
W
%s*synth2B
.	   8 Input      8 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	  16 Input      8 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	   9 Input      4 Bit        Muxes := 1     
2default:defaulth px
W
%s*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
L
%s*synth27
#Finished RTL Component Statistics 
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
V
%s*synth2A
-Start RTL Hierarchical Component Statistics 
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
L
%s*synth27
#Hierarchical RTL Component report 
2default:defaulth px
9
%s*synth2$
Module divider 
2default:defaulth px
H
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px
7
%s*synth2"
+---Adders : 
2default:defaulth px
W
%s*synth2B
.	   2 Input     32 Bit       Adders := 1     
2default:defaulth px
:
%s*synth2%
+---Registers : 
2default:defaulth px
W
%s*synth2B
.	               32 Bit    Registers := 1     
2default:defaulth px
W
%s*synth2B
.	                1 Bit    Registers := 1     
2default:defaulth px
9
%s*synth2$
Module counter 
2default:defaulth px
H
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px
7
%s*synth2"
+---Adders : 
2default:defaulth px
W
%s*synth2B
.	   2 Input      3 Bit       Adders := 1     
2default:defaulth px
:
%s*synth2%
+---Registers : 
2default:defaulth px
W
%s*synth2B
.	                3 Bit    Registers := 1     
2default:defaulth px
6
%s*synth2!
+---Muxes : 
2default:defaulth px
W
%s*synth2B
.	   2 Input      3 Bit        Muxes := 1     
2default:defaulth px
<
%s*synth2'
Module decoder3_8 
2default:defaulth px
H
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px
6
%s*synth2!
+---Muxes : 
2default:defaulth px
W
%s*synth2B
.	   8 Input      8 Bit        Muxes := 1     
2default:defaulth px
8
%s*synth2#
Module rom8x4 
2default:defaulth px
H
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px
6
%s*synth2!
+---Muxes : 
2default:defaulth px
W
%s*synth2B
.	   9 Input      4 Bit        Muxes := 1     
2default:defaulth px
9
%s*synth2$
Module pattern 
2default:defaulth px
H
%s*synth23
Detailed RTL Component Info : 
2default:defaulth px
6
%s*synth2!
+---Muxes : 
2default:defaulth px
W
%s*synth2B
.	  16 Input      8 Bit        Muxes := 1     
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
X
%s*synth2C
/Finished RTL Hierarchical Component Statistics
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
E
%s*synth20
Start Part Resource Summary
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2k
WPart Resources:
DSPs: 240 (col length:80)
BRAMs: 270 (col length: RAMB18 80 RAMB36 40)
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
H
%s*synth23
Finished Part Resource Summary
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
?Start Parallel Synthesis Optimization  : Time (s): cpu = 00:00:08 ; elapsed = 00:00:09 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
K
%s*synth26
"Start Cross Boundary Optimization
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
^ROM "%s" won't be mapped to RAM because address size (%s) is larger than maximum supported(%s)3997*oasys2%
mydivider/counter2default:default2
322default:default2
182default:defaultZ8-5545h px
?
^ROM "%s" won't be mapped to RAM because address size (%s) is larger than maximum supported(%s)3997*oasys2#
mydivider/clk_N2default:default2
322default:default2
182default:defaultZ8-5545h px
?
+design %s has port %s driven by constant %s3447*oasys2 
dynamic_scan2default:default2
SEG[7]2default:default2
12default:defaultZ8-3917h px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
?Finished Cross Boundary Optimization : Time (s): cpu = 00:00:08 ; elapsed = 00:00:09 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
~Finished Parallel Reinference  : Time (s): cpu = 00:00:08 ; elapsed = 00:00:09 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
B
%s*synth2-

Report RTL Partitions: 
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
A
%s*synth2,
Start Area Optimization
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
zFinished Area Optimization : Time (s): cpu = 00:00:09 ; elapsed = 00:00:09 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
?Finished Parallel Area Optimization  : Time (s): cpu = 00:00:09 ; elapsed = 00:00:09 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
B
%s*synth2-

Report RTL Partitions: 
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
?
%s*synth2?
?Finished Parallel Synthesis Optimization  : Time (s): cpu = 00:00:09 ; elapsed = 00:00:09 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
C
%s*synth2.
Start Timing Optimization
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
O
%s*synth2:
&Start Applying XDC Timing Constraints
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
{incorrect argument "-dict" for "set_property" at line 7 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 7 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 60 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 60 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 61 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 61 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 62 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 62 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 63 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 63 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 64 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 64 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 65 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 65 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 66 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 66 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 68 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 68 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 70 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 70 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 71 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 71 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 72 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 72 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 73 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 73 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 74 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 74 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 75 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 75 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 76 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 76 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|incorrect argument "-dict" for "set_property" at line 77 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
?
%s*synth2?
?incorrect set of required parameters for "set_property" at line 77 of file F:/Cqh_files/2021verilog/upload/lab3/Nexys4DDR_Master3.xdc
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
0
%s*synth2
Usage:
2default:defaulth px
8
%s*synth2#
  set_property
2default:defaulth px
5
%s*synth2 
    [-help]
2default:defaulth px
6
%s*synth2!
    [-quiet]
2default:defaulth px
7
%s*synth2"
    attribute
2default:defaulth px
3
%s*synth2

    value
2default:defaulth px
4
%s*synth2
    object
2default:defaulth px
C
%s*synth2.
    [{>|>>} <stdoutFile>]
2default:defaulth px
o
%s*synth2Z
F---------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
?Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:16 ; elapsed = 00:00:17 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
|Finished Timing Optimization : Time (s): cpu = 00:00:16 ; elapsed = 00:00:17 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
B
%s*synth2-

Report RTL Partitions: 
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
B
%s*synth2-
Start Technology Mapping
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
{Finished Technology Mapping : Time (s): cpu = 00:00:16 ; elapsed = 00:00:17 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
B
%s*synth2-

Report RTL Partitions: 
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
<
%s*synth2'
Start IO Insertion
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
E
%s*synth20
Start Final Netlist Cleanup
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
H
%s*synth23
Finished Final Netlist Cleanup
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
uFinished IO Insertion : Time (s): cpu = 00:00:17 ; elapsed = 00:00:17 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
A
%s*synth2,

Report Check Netlist: 
2default:defaulth px
r
%s*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth px
r
%s*synth2]
I|      |Item              |Errors |Warnings |Status |Description       |
2default:defaulth px
r
%s*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth px
r
%s*synth2]
I|1     |multi_driven_nets |      0|        0|Passed |Multi driven nets |
2default:defaulth px
r
%s*synth2]
I+------+------------------+-------+---------+-------+------------------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
L
%s*synth27
#Start Renaming Generated Instances
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
?Finished Renaming Generated Instances : Time (s): cpu = 00:00:17 ; elapsed = 00:00:17 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
B
%s*synth2-

Report RTL Partitions: 
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
+| |RTL Partition |Replication |Instances |
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
T
%s*synth2?
++-+--------------+------------+----------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
I
%s*synth24
 Start Rebuilding User Hierarchy
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
?Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:17 ; elapsed = 00:00:17 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
~Start Renaming Generated Ports : Time (s): cpu = 00:00:17 ; elapsed = 00:00:17 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
?Finished Renaming Generated Ports : Time (s): cpu = 00:00:17 ; elapsed = 00:00:17 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
H
%s*synth23
Start Writing Synthesis Report
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
>
%s*synth2)

Report BlackBoxes: 
2default:defaulth px
G
%s*synth22
+-+--------------+----------+
2default:defaulth px
G
%s*synth22
| |BlackBox name |Instances |
2default:defaulth px
G
%s*synth22
+-+--------------+----------+
2default:defaulth px
G
%s*synth22
+-+--------------+----------+
2default:defaulth px
>
%s*synth2)

Report Cell Usage: 
2default:defaulth px
A
%s*synth2,
+------+-------+------+
2default:defaulth px
A
%s*synth2,
|      |Cell   |Count |
2default:defaulth px
A
%s*synth2,
+------+-------+------+
2default:defaulth px
A
%s*synth2,
|1     |BUFG   |     1|
2default:defaulth px
A
%s*synth2,
|2     |CARRY4 |     8|
2default:defaulth px
A
%s*synth2,
|3     |LUT1   |    34|
2default:defaulth px
A
%s*synth2,
|4     |LUT2   |     3|
2default:defaulth px
A
%s*synth2,
|5     |LUT3   |    15|
2default:defaulth px
A
%s*synth2,
|6     |LUT6   |     6|
2default:defaulth px
A
%s*synth2,
|7     |FDRE   |    36|
2default:defaulth px
A
%s*synth2,
|8     |IBUF   |     1|
2default:defaulth px
A
%s*synth2,
|9     |OBUF   |    16|
2default:defaulth px
A
%s*synth2,
+------+-------+------+
2default:defaulth px
B
%s*synth2-

Report Instance Areas: 
2default:defaulth px
R
%s*synth2=
)+------+------------+-----------+------+
2default:defaulth px
R
%s*synth2=
)|      |Instance    |Module     |Cells |
2default:defaulth px
R
%s*synth2=
)+------+------------+-----------+------+
2default:defaulth px
R
%s*synth2=
)|1     |top         |           |   120|
2default:defaulth px
R
%s*synth2=
)|2     |  mycounter |counter    |     9|
2default:defaulth px
R
%s*synth2=
)|3     |  mydecoder |decoder3_8 |     5|
2default:defaulth px
R
%s*synth2=
)|4     |  mydivider |divider    |    82|
2default:defaulth px
R
%s*synth2=
)|5     |  mypattern |pattern    |     6|
2default:defaulth px
R
%s*synth2=
)+------+------------+-----------+------+
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
?
%s*synth2?
?Finished Writing Synthesis Report : Time (s): cpu = 00:00:17 ; elapsed = 00:00:17 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
{
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px
o
%s*synth2Z
FSynthesis finished with 0 errors, 0 critical warnings and 1 warnings.
2default:defaulth px
?
%s*synth2?
}Synthesis Optimization Runtime : Time (s): cpu = 00:00:11 ; elapsed = 00:00:13 . Memory (MB): peak = 582.168 ; gain = 87.051
2default:defaulth px
?
%s*synth2?
Synthesis Optimization Complete : Time (s): cpu = 00:00:17 ; elapsed = 00:00:17 . Memory (MB): peak = 582.168 ; gain = 409.426
2default:defaulth px
?
 Translating synthesized netlist
350*projectZ1-571h px
b
-Analyzing %s Unisim elements for replacement
17*netlist2
92default:defaultZ29-17h px
g
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px
H
)Preparing netlist for logic optimization
349*projectZ1-570h px
r
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px
{
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px
R
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
302default:default2
12default:default2
02default:default2
02default:defaultZ4-41h px
[
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:00:152default:default2
00:00:162default:default2
582.1682default:default2
388.2662default:defaultZ17-268h px
?
sreport_utilization: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.023 . Memory (MB): peak = 582.168 ; gain = 0.000
*commonh px
}
Exiting %s at %s...
206*common2
Vivado2default:default2,
Thu Apr 29 20:24:22 20212default:defaultZ17-206h px