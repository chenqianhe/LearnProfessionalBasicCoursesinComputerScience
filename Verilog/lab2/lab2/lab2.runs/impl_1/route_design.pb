
N
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px
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
m
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px
M
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px
?
Rule violation (%s) %s - %s
20*drc2
PLIO-72default:default2B
.Placement Constraints Check for IO constraints2default:default2?
?An IO Bus SW[15:0] with more than one IO standard is found. Components associated with this bus are:  SW[15] of IOStandard LVCMOS33; SW[14] of IOStandard LVCMOS33; SW[13] of IOStandard LVCMOS33; SW[12] of IOStandard LVCMOS33; SW[11] of IOStandard LVCMOS33; SW[10] of IOStandard LVCMOS33; SW[9] of IOStandard LVCMOS18; SW[8] of IOStandard LVCMOS18; SW[7] of IOStandard LVCMOS33; SW[6] of IOStandard LVCMOS33; SW[5] of IOStandard LVCMOS33; SW[4] of IOStandard LVCMOS33; SW[3] of IOStandard LVCMOS33; SW[2] of IOStandard LVCMOS33; SW[1] of IOStandard LVCMOS33; SW[0] of IOStandard LVCMOS33;2default:defaultZ23-20h px
_
DRC finished with %s
79*	vivadotcl2(
0 Errors, 1 Warnings2default:defaultZ4-198h px
b
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px
S

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px
v
BMultithreading enabled for route_design using a maximum of %s CPUs97*route2
22default:defaultZ35-254h px
m

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px
@
.Phase 1 Build RT Design | Checksum: 157e027dc
*commonh px
?

%s
*constraints2q
]Time (s): cpu = 00:00:29 ; elapsed = 00:00:26 . Memory (MB): peak = 1065.207 ; gain = 114.7502default:defaulth px
s

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px
x
\No timing constraints were detected. The router will operate in resource-optimization mode.
64*routeZ35-64h px
q

Phase %s%s
101*constraints2
2.1 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px
D
2Phase 2.1 Pre Route Cleanup | Checksum: 157e027dc
*commonh px
?

%s
*constraints2q
]Time (s): cpu = 00:00:29 ; elapsed = 00:00:26 . Memory (MB): peak = 1070.242 ; gain = 119.7852default:defaulth px
F
4Phase 2 Router Initialization | Checksum: 157e027dc
*commonh px
?

%s
*constraints2q
]Time (s): cpu = 00:00:29 ; elapsed = 00:00:26 . Memory (MB): peak = 1073.063 ; gain = 122.6052default:defaulth px
m

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px
?
-Phase 3 Initial Routing | Checksum: ff76ab0d
*commonh px
?

%s
*constraints2q
]Time (s): cpu = 00:00:29 ; elapsed = 00:00:26 . Memory (MB): peak = 1073.063 ; gain = 122.6052default:defaulth px
p

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px
r

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px
E
3Phase 4.1 Global Iteration 0 | Checksum: 1269a78f7
*commonh px
?

%s
*constraints2q
]Time (s): cpu = 00:00:29 ; elapsed = 00:00:26 . Memory (MB): peak = 1073.063 ; gain = 122.6052default:defaulth px
C
1Phase 4 Rip-up And Reroute | Checksum: 1269a78f7
*commonh px
?

%s
*constraints2q
]Time (s): cpu = 00:00:29 ; elapsed = 00:00:26 . Memory (MB): peak = 1073.063 ; gain = 122.6052default:defaulth px
y

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px
L
:Phase 5 Delay and Skew Optimization | Checksum: 1269a78f7
*commonh px
?

%s
*constraints2q
]Time (s): cpu = 00:00:29 ; elapsed = 00:00:26 . Memory (MB): peak = 1073.063 ; gain = 122.6052default:defaulth px
k

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px
>
,Phase 6 Post Hold Fix | Checksum: 1269a78f7
*commonh px
?

%s
*constraints2q
]Time (s): cpu = 00:00:29 ; elapsed = 00:00:26 . Memory (MB): peak = 1073.063 ; gain = 122.6052default:defaulth px
l

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px
?
-Phase 7 Route finalize | Checksum: 1269a78f7
*commonh px
?

%s
*constraints2q
]Time (s): cpu = 00:00:29 ; elapsed = 00:00:26 . Memory (MB): peak = 1073.063 ; gain = 122.6052default:defaulth px
s

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px
F
4Phase 8 Verifying routed nets | Checksum: 1269a78f7
*commonh px
?

%s
*constraints2q
]Time (s): cpu = 00:00:29 ; elapsed = 00:00:26 . Memory (MB): peak = 1073.063 ; gain = 122.6052default:defaulth px
o

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px
B
0Phase 9 Depositing Routes | Checksum: 1269a78f7
*commonh px
?

%s
*constraints2q
]Time (s): cpu = 00:00:29 ; elapsed = 00:00:26 . Memory (MB): peak = 1073.063 ; gain = 122.6052default:defaulth px
:
Router Completed Successfully
16*routeZ35-16h px
?

%s
*constraints2q
]Time (s): cpu = 00:00:29 ; elapsed = 00:00:26 . Memory (MB): peak = 1073.063 ; gain = 122.6052default:defaulth px
W
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
422default:default2
22default:default2
162default:default2
02default:defaultZ4-41h px
[
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:00:292default:default2
00:00:262default:default2
1073.0632default:default2
122.6052default:defaultZ17-268h px
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
00:00:00.0292default:default2
1073.0632default:default2
0.0002default:defaultZ17-268h px
M
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px
?
#The results of DRC are in file %s.
168*coretcl2?
]F:/Cqh_files/2021verilog/upload/lab2/lab2/lab2.runs/impl_1/_7Seg_Driver_Direct_drc_routed.rpt]F:/Cqh_files/2021verilog/upload/lab2/lab2/lab2.runs/impl_1/_7Seg_Driver_Direct_drc_routed.rpt2default:default8Z2-168h px
o
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px
y
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px
?
iThere are no user specified timing constraints. Timing constraints are needed for proper timing analysis.200*timingZ38-313h px
M
/No user defined clocks was found in the design!216*powerZ33-232h px
H
,Running Vector-less Activity Propagation...
51*powerZ33-51h px
M
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px


End Record