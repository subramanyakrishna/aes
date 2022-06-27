@echo off
set xv_path=D:\\Vivado\\2014.4\\bin
call %xv_path%/xsim AES_test_behav -key {Behavioral:sim_1:Functional:AES_test} -tclbatch AES_test.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
