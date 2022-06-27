@echo off
set xv_path=D:\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto 681a65902c8d4b19a3e2ec68fa664faa -m64 --debug typical --relax -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot AES_test_behav xil_defaultlib.AES_test xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
