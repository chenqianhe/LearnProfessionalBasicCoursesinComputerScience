
z
eCannot write hardware definition file as there are no IPI block design hardware handoff files present*	vivadotclh px
N
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-347h px
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-349h px
M
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px
S
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px
b
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px
m
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px
M
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px
S
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px
b
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px
R

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px
z
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
22default:defaultZ30-611h px
v

Phase %s%s
101*constraints2
1 2default:default2,
Placer Runtime Estimator2default:defaultZ18-101h px
H
6Phase 1 Placer Runtime Estimator | Checksum: c808ab9a
*commonh px
?

%s
*constraints2r
^Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.014 . Memory (MB): peak = 921.664 ; gain = 0.0002default:defaulth px
s

Phase %s%s
101*constraints2
2 2default:default2)
Placer Initialization2default:defaultZ18-101h px
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
921.6642default:default2
0.0002default:defaultZ17-268h px
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
921.6642default:default2
0.0002default:defaultZ17-268h px
?

Phase %s%s
101*constraints2
2.1 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px
q

Phase %s%s
101*constraints2
2.1.1 2default:default2#
Pre-Place Cells2default:defaultZ18-101h px
C
1Phase 2.1.1 Pre-Place Cells | Checksum: bdb64a59
*commonh px
?

%s
*constraints2r
^Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.029 . Memory (MB): peak = 921.664 ; gain = 0.0002default:defaulth px
B
%Done setting XDC timing constraints.
35*timingZ38-35h px
s

Phase %s%s
101*constraints2
2.1.2 2default:default2%
IO & Clk Clean Up2default:defaultZ18-101h px
E
3Phase 2.1.2 IO & Clk Clean Up | Checksum: bdb64a59
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.806 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
?

Phase %s%s
101*constraints2
2.1.3 2default:default2>
*Implementation Feasibility check On IDelay2default:defaultZ18-101h px
^
LPhase 2.1.3 Implementation Feasibility check On IDelay | Checksum: bdb64a59
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.807 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
u

Phase %s%s
101*constraints2
2.1.4 2default:default2'
Commit IO Placement2default:defaultZ18-101h px
G
5Phase 2.1.4 Commit IO Placement | Checksum: 850bb718
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.808 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
e
SPhase 2.1 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 17e36e942
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.808 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
z

Phase %s%s
101*constraints2
2.2 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px
s

Phase %s%s
101*constraints2
2.2.1 2default:default2%
Place Init Design2default:defaultZ18-101h px
F
4Phase 2.2.1 Place Init Design | Checksum: 190d0797a
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.816 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
M
;Phase 2.2 Build Placer Netlist Model | Checksum: 190d0797a
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.816 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
w

Phase %s%s
101*constraints2
2.3 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px
?

Phase %s%s
101*constraints2
2.3.1 2default:default24
 Constrain Global/Regional Clocks2default:defaultZ18-101h px
U
CPhase 2.3.1 Constrain Global/Regional Clocks | Checksum: 190d0797a
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.818 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
J
8Phase 2.3 Constrain Clocks/Macros | Checksum: 190d0797a
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.818 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
F
4Phase 2 Placer Initialization | Checksum: 190d0797a
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.819 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
n

Phase %s%s
101*constraints2
3 2default:default2$
Global Placement2default:defaultZ18-101h px
A
/Phase 3 Global Placement | Checksum: 18716a119
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.971 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
n

Phase %s%s
101*constraints2
4 2default:default2$
Detail Placement2default:defaultZ18-101h px
z

Phase %s%s
101*constraints2
4.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px
M
;Phase 4.1 Commit Multi Column Macros | Checksum: 18716a119
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.973 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
|

Phase %s%s
101*constraints2
4.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px
O
=Phase 4.2 Commit Most Macros & LUTRAMs | Checksum: 266848dd1
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.987 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
v

Phase %s%s
101*constraints2
4.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px
I
7Phase 4.3 Area Swap Optimization | Checksum: 2687eaeb0
*commonh px
?

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.991 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
|

Phase %s%s
101*constraints2
4.4 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px
?

Phase %s%s
101*constraints2
4.4.1 2default:default24
 Commit Small Macros & Core Logic2default:defaultZ18-101h px
y

Phase %s%s
101*constraints2
4.4.1.1 2default:default2)
Commit Slice Clusters2default:defaultZ18-101h px
L
:Phase 4.4.1.1 Commit Slice Clusters | Checksum: 1c332f8a9
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
U
CPhase 4.4.1 Commit Small Macros & Core Logic | Checksum: 1c332f8a9
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
?

Phase %s%s
101*constraints2
4.4.2 2default:default2C
/Clock Restriction Legalization for Leaf Columns2default:defaultZ18-101h px
d
RPhase 4.4.2 Clock Restriction Legalization for Leaf Columns | Checksum: 1c332f8a9
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
?

Phase %s%s
101*constraints2
4.4.3 2default:default2E
1Clock Restriction Legalization for Non-Clock Pins2default:defaultZ18-101h px
f
TPhase 4.4.3 Clock Restriction Legalization for Non-Clock Pins | Checksum: 1c332f8a9
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
O
=Phase 4.4 Small Shape Detail Placement | Checksum: 1c332f8a9
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
r

Phase %s%s
101*constraints2
4.5 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px
E
3Phase 4.5 Re-assign LUT pins | Checksum: 1c332f8a9
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
A
/Phase 4 Detail Placement | Checksum: 1c332f8a9
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
?

Phase %s%s
101*constraints2
5 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px
s

Phase %s%s
101*constraints2
5.1 2default:default2'
PCOPT Shape updates2default:defaultZ18-101h px
F
4Phase 5.1 PCOPT Shape updates | Checksum: 1c332f8a9
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
x

Phase %s%s
101*constraints2
5.2 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px
K
9Phase 5.2 Post Commit Optimization | Checksum: 1c332f8a9
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
?

Phase %s%s
101*constraints2
5.3 2default:default25
!Sweep Clock Roots: Post-Placement2default:defaultZ18-101h px
T
BPhase 5.3 Sweep Clock Roots: Post-Placement | Checksum: 1c332f8a9
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
v

Phase %s%s
101*constraints2
5.4 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px
I
7Phase 5.4 Post Placement Cleanup | Checksum: 1c332f8a9
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
p

Phase %s%s
101*constraints2
5.5 2default:default2$
Placer Reporting2default:defaultZ18-101h px
C
1Phase 5.5 Placer Reporting | Checksum: 1c332f8a9
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
w

Phase %s%s
101*constraints2
5.6 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px
I
7Phase 5.6 Final Placement Cleanup | Checksum: d37d804f
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
X
FPhase 5 Post Placement Optimization and Clean-Up | Checksum: d37d804f
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
:
(Ending Placer Task | Checksum: be44d882
*commonh px
?

%s
*constraints2o
[Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 935.844 ; gain = 14.1802default:defaulth px
W
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
332default:default2
02default:default2
02default:default2
02default:defaultZ4-41h px
[
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px
A
Writing placer database...
1603*designutilsZ20-1893h px
:
Writing XDEF routing.
211*designutilsZ20-211h px
G
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px
G
#Writing XDEF routing special nets.
210*designutilsZ20-210h px
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:002default:default2 
00:00:00.0302default:default2
935.8442default:default2
0.0002default:defaultZ17-268h px
|
jreport_io: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.027 . Memory (MB): peak = 935.844 ; gain = 0.000
*commonh px
?
sreport_utilization: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.039 . Memory (MB): peak = 935.844 ; gain = 0.000
*commonh px
?
treport_control_sets: Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.001 . Memory (MB): peak = 935.844 ; gain = 0.000
*commonh px


End Record