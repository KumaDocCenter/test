:: ===================================================================
:: 子模块 添加后的处理
:: 
:: 存放目录： 
:: 运行目录： 
:: 
:: ===================================================================
:: EQU - 等于  NEQ - 不等于
:: 
:: 
:::::::::::::::::::::::: 预处理 ::::::::::::::::::::::::
:: 关闭回显
@echo off
:: 窗口标题
::Title "New Windows Title"
:: 设置颜色(黑色背景|淡绿色字体)
color 0A
:: 调试开关
set SysDebug=0
set AppDebug=0
:: 当前文件名(xxx.bat)
set ThisFileName=%~nx0
:: 当前文件名全路径(E:\...\xxx.bat)
set ThisFile=%~f0
:: 当前文件目录(E:\...\sh\)
set ThisDir=%~dp0
:: 是否跳转到脚本目录(1:是|0:否)
set is_cd=0
:: 是否入口文件(1:是|0:否)
set is_inPoint=1

::Debug
if %SysDebug%==1 (
	echo [%0] ------------------------
	echo  0: %0
	echo  1: %1
	echo  2: %2
	echo  3: %3
	echo  4: %4
	echo  5: %5
	echo  6: %6
	echo  7: %7
	echo  8: %8
	echo  9: %9
	echo [%0] ------------------------
	echo ThisFileName: %ThisFileName%
	echo ThisFile: %ThisFile%
	echo ThisDir: %ThisDir%	
)

:: 跳转到脚本目录 
if %is_cd%==1 cd /d %~dp0
:: 入口文件处理
if  "%is_inPoint%" == "1" (	
	REM 注: 只有在入口文件中开启变量延迟，子脚本的修改才能返回到当前环境中
	REM 开启变量延迟
	setlocal EnableDelayedExpansion
)

::::::::跳转调度::::::::
:: NEQ - 不等于  EQU - 等于
:: 可解决：
:: 参数1为  
:: 参数1为 "" 
:: 参数1为 ":xxx"
:: 
:: %gotolable:~1,1% : 从第2个字符开始，截取1个字符
:: %gotolable:~1,-1% : 从第2个字符开始，截取至倒数1个的字符，即首尾各去除1个字符
:: 当参数1为空时，%gotolable% = []，所以需要  NEQ "[]" 
:: 用[]，在输入值为空时，避免下面的if报错

set gotolable=[%1]
:: 去除双引号
set gotolable=%gotolable:"=%
if "%gotolable%" NEQ "[]"  (
	REM %1不为空			
	if "%gotolable:~1,1%"==":" (
		REM 第1个字符为 :
		Call %gotolable:~1,-1%  %2  %3  %4  %5  %6  %7  %8  %9
	) else (	
		Call :Debug_Point  %1  %2  %3  %4  %5  %6  %7  %8  %9
	)
) else (
	REM %1为空
	goto :Debug_Point
)
::::::::跳转调度::::::::

::::::::Function::::::::
GOTO:EOF
:: ==================================================
:: 函数名称: SET_MAP
:: 函数功能: 设置映射表
:: 函数参数: 	 
::           arg1: 
::		
:: ==================================================
:SET_MAP
	:: 当前文件名(xxx.bat)
	set ThisFileName=%~nx0
	:: 当前文件名全路径(E:\...\xxx.bat)
	set ThisFile=%~f0
	:: 当前文件目录(E:\...\sh\)
	set ThisDir=%~dp0
GOTO:EOF

GOTO:EOF
:: ==================================================
:: 函数名称: SETVAR
:: 函数功能: 设置变量
:: 函数参数: 	 
::           arg1: 字符串(最多9对)
::		           格式 key=value;key=value;...
:: ==================================================
:SETVAR
:: ----------------------------------------------------------------
:: 格式：
:: key=value;key=value;...
::
:: 处理分号 ;  ，然后直接设置变量(set key=value)
:: key=value : 最多9对
:: ----------------------------------------------------------------
for /f "tokens=1-9 delims=;" %%a in ( "%~1" ) do (
	if %SysDebug%==1 echo [a: %%a ] [b: %%b ] [c: %%c ] [d: %%d ] [e: %%e ] 
	if %SysDebug%==1 echo [f: %%f ] [g: %%g ] [h: %%h ] [i: %%i ]
	
	:: 设置变量 :: NEQ - 不等于
	if  "%%a" NEQ ""  set "%%a"
	if  "%%b" NEQ ""  set "%%b"
	if  "%%c" NEQ ""  set "%%c"
	if  "%%d" NEQ ""  set "%%d"
	if  "%%e" NEQ ""  set "%%e"
	if  "%%f" NEQ ""  set "%%f"
	if  "%%g" NEQ ""  set "%%g"
	if  "%%h" NEQ ""  set "%%h"
	if  "%%i" NEQ ""  set "%%i"
)
GOTO:EOF


GOTO:EOF
:: ================================================== ::
:: 函数名称：_time								 	  ::
:: 函数功能：获取时间相关信息			 			  ::
:: 函数参数：[arg1]: 日期分隔符			 		  	  ::
::  		 	     默认 -						 	  ::
::           							 			  ::
:: 返回值：          							      ::
::    %datetime%  ： 时间							  ::
::        		     2018-12-10 21:43:58  			  ::
::    %timestamp%  ：时间戳						      ::
::        		     20181210214358 			 	  ::
:: ================================================== ::
:_time
:: 闭环 setlocal ... endlocal
setlocal

if %SysDebug%==1 echo ------------------------ 简易日期时间和时间戳  ----------------------

:: 日期分隔符
if "%~1" == "" (
	set delim=-
) else (
	set delim=%~1
)


:: 日期处理( 2018-12-10 )
for /f "tokens=1-4  delims=/ " %%a in ("%date%") do (
	set _de=%%a%delim%%%b%delim%%%c
	set de=%%a%%b%%c
	set week=%%d
)
:: 时间处理( 21:43:58 )
for /f "tokens=1-4  delims=:." %%a in ("%time%") do (
	set _ti=%%a:%%b:%%c
	set ti=%%a%%b%%c
)

:: 当前日期时间( 2018-12-10 21:43:58 )
set "datetime=%_de% %_ti%"
if %SysDebug%==1 echo 日期时间："%datetime%"

:: 日期时间 戳( 20181210214358 )
set deti=%de%%ti%
:::: 去除所有空格
set timestamp=%deti: =%
if %SysDebug%==1 echo 时间戳："%timestamp%"

if %SysDebug%==1 echo ------------------------ 简易日期时间和时间戳  ----------------------

(
endlocal
REM 输出变量
set datetime=%datetime%
set timestamp=%timestamp%
)
GOTO:EOF
::调用示例
REM call :_time  -
::call :_time  
::echo datetime: %datetime%
::echo timestamp: %timestamp%

::::::::Function::::::::

:::::::::::::::::::::::: 预处理 ::::::::::::::::::::::::


:: -----[Function]------------------------------------------------------------------------------------------


GOTO:EOF
:: ==================================================
:: 函数名称: test
:: 函数功能: 		
:: 函数参数: 	 
::           arg1: 参数1
::           arg2: 参数2		
::         [arg3]: 参数3			
::	
:: 返回值：
:: 	
:: ==================================================
:test
:: 闭环 setlocal ... endlocal
setlocal 
::Debug
if %SysDebug%==1 (
	echo [%ThisFileName%] %~0 .................
	echo arg0: %~0 
	echo arg1: %~1 
	echo arg2: %~2 
	echo arg3: %~3 
	echo arg4: %~4 
	echo arg5: %~5
	echo arg6: %~6 
	echo arg7: %~7 
	echo arg8: %~8
	echo arg9: %~9
	echo [%ThisFileName%] %~0 .................
)
:: EQU - 等于  NEQ - 不等于
set ExitCode=0
:: 遍历目录下指定文件
set arr_Index=1
for %%i in (%ScriptDir%Data\*.Metadata.bat) do ( 
	REM %%i : %ScriptDir%Data\XX.Metadata.bat
	set /A arr_Index+=1
)
(
endlocal
REM 输出变量
REM set %~9=111
)
Exit /B %ExitCode%
GOTO:EOF


GOTO:EOF
:: ==================================================
:: 函数名称: SparseCheckout
:: 函数功能: 稀疏检出		
:: 函数参数: 	 
::           arg1: 子模块根目录(名称)				  
::                 如 source_md	
::           arg2: 子模块(名称) 						  
::                 相对于子模块根目录的路径(如 Ajax)		
::	
:: 上下文变量：
:: 	   %ProjectDir% ： 项目根目录(K:\...\<Dir>)
:: 返回值：
:: 	
:: ==================================================
:SparseCheckout
:: 闭环 setlocal ... endlocal
setlocal 
::Debug
if %SysDebug%==1 (
	echo [%ThisFileName%] %~0 .................
	echo arg0: %~0 
	echo arg1: %~1 
	echo arg2: %~2 
	echo arg3: %~3 
	echo arg4: %~4 
	echo arg5: %~5
	echo arg6: %~6 
	echo arg7: %~7 
	echo arg8: %~8
	echo arg9: %~9
	echo [%ThisFileName%] %~0 .................
)
:: EQU - 等于  NEQ - 不等于
set "SubModuleDir=%~1"
set "SubModule=%~2"

Call :_time
:: 设置文件名称
set FileName=sparse-checkout

if /i "[%ForceUpdate%]" EQU "[/Y]"  (
	REM 文件存在则备份
	if exist "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%\info\%FileName%"  (
		ren  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%\info\%FileName%"   "%FileName%.%timestamp%"
	)
	REM 复制文件
	xcopy  "%ScriptDir%%FileName%"   "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%\info\"  /Y
	REM 启用sparse-checkout并检出分支
	cd %ProjectDir%\%SubModuleDir%\%SubModule%
	echo SubModule: %cd%
	if exist ".git" (
		REM 启用 sparse-checkout 
		git config core.sparsecheckout true
		REM 检出分支
		git checkout master
	)
) else (
	REM 文件不存在才执行
	if not exist "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%\info\%FileName%"  (
		REM 复制文件
		xcopy  "%ScriptDir%%FileName%"   "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%\info\"  /Y
		REM 启用sparse-checkout并检出分支
		cd %ProjectDir%\%SubModuleDir%\%SubModule%
		echo SubModule: %cd%
		if exist ".git" (
			REM 启用 sparse-checkout 
			git config core.sparsecheckout true
			REM 检出分支
			git checkout master
		)
	)
)

(
endlocal
REM 输出变量
REM set %~9=111
)
GOTO:EOF


GOTO:EOF
:: ==================================================
:: 函数名称: CopyHook
:: 函数功能: 复制钩子		
:: 函数参数: 	 
::           arg1: 钩子文件源路径(K:\...\<Dir>)
::           arg2: 钩子文件目标路径(K:\...\<Dir>)				  
::                 如 .git\modules\source_md\Ajax
::           arg3: 钩子文件名称
::	
:: 上下文变量：
:: 	    
:: 返回值：
:: 	
:: ==================================================
:CopyHook
:: 闭环 setlocal ... endlocal
setlocal 
::Debug
if %SysDebug%==1 (
	echo [%ThisFileName%] %~0 .................
	echo arg0: %~0 
	echo arg1: %~1 
	echo arg2: %~2 
	echo arg3: %~3 
	echo arg4: %~4 
	echo arg5: %~5
	echo arg6: %~6 
	echo arg7: %~7 
	echo arg8: %~8
	echo arg9: %~9
	echo [%ThisFileName%] %~0 .................
)
:: EQU - 等于  NEQ - 不等于
Call :_time
:: 钩子文件源路径(K:\...\<Dir>)
set "HookSoure=%~1"
:: 钩子文件目标路径(K:\...\<Dir>)	
set "HookDest=%~2"
:: 设置钩子名称
set "HookName=%~3"

if /i "[%ForceUpdate%]" EQU "[/Y]"  (
	REM 文件存在则备份
	if exist "%HookDest%\hooks\%HookName%"  (
		ren "%HookDest%\hooks\%HookName%"   "%HookName%.%timestamp%"	
	)
	REM 复制钩子
	xcopy  "%HookSoure%\%HookName%"   "%HookDest%\hooks\"  /Y
) else (
	REM 文件不存在才执行
	if not exist "%HookDest%\hooks\%HookName%"  (
		REM 复制钩子
		xcopy  "%HookSoure%\%HookName%"   "%HookDest%\hooks\"  /Y
	)
)

(
endlocal
REM 输出变量
REM set %~9=111
)
GOTO:EOF



:: -----[Function]------------------------------------------------------------------------------------------


:Debug_Point
:: EQU - 等于  NEQ - 不等于

:: 当前脚本目录(E:\...\)
set ScriptDir=%~dp0
:: 加载配置
Call %ScriptDir%Add.After.Conf.bat
:: 强制更新(/Y:目标中文件已存在时也执行相关命令)
set "ForceUpdate=/N"

if ["%~1"] NEQ [""] (
	if /i ["%~1"] EQU ["/Y"]  (
		set "ForceUpdate=/Y"
	) else (
		set "SubModule=%~1"
		if /i ["%~2"] EQU ["/Y"]  set "ForceUpdate=/Y"
	)
)


:: dir "source_md\"  /ad/b  
:: 获取目录下的目录名列表，不包含子目录
:: /a: 指定属性
::     d: 目录属性
:: /b: 使用空格式(没有标题信息或摘要)
:: 如
:: aa
:: test

:: Call :CopyHook "钩子文件源路径(K:\...\<Dir>)"  "钩子文件目标路径(如 .git\modules\source_md\Ajax)" "钩子文件名称"
:: Call :SparseCheckout "%SubModuleDir%" 子模块
:: Main
if ["%SubModule%"] NEQ [""] (
	REM 单体模式	
	Call :SparseCheckout "%SubModuleDir%"  "%SubModule%"
	if ["%HookName_01%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%"  "%HookName_01%"
	if ["%HookName_02%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%"  "%HookName_02%"
	if ["%HookName_03%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%"  "%HookName_03%"
	if ["%HookName_04%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%"  "%HookName_04%"
	if ["%HookName_05%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%"  "%HookName_05%"
	if ["%HookName_06%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%"  "%HookName_06%"
	if ["%HookName_07%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%"  "%HookName_07%"
	if ["%HookName_08%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%"  "%HookName_08%"
	if ["%HookName_09%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%"  "%HookName_09%"
	if ["%HookName_10%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%"  "%HookName_10%"
	if ["%HookName_11%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%"  "%HookName_11%"
	if ["%HookName_12%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%SubModule%"  "%HookName_12%"
) else (
	REM 批量模式
	for /f "usebackq tokens=* delims=" %%i in (`dir "%ProjectDir%\%SubModuleDir%\"  /ad/b`) do (
		if %AppDebug%==1 echo [i: %%i ][Prefx: %%~xi ]	
		echo.
		Call :SparseCheckout "%SubModuleDir%"  "%%i"
		if ["%HookName_01%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%%i"  "%HookName_01%"
		if ["%HookName_02%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%%i"  "%HookName_02%"
		if ["%HookName_03%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%%i"  "%HookName_03%"
		if ["%HookName_04%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%%i"  "%HookName_04%"
		if ["%HookName_05%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%%i"  "%HookName_05%"
		if ["%HookName_06%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%%i"  "%HookName_06%"
		if ["%HookName_07%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%%i"  "%HookName_07%"
		if ["%HookName_08%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%%i"  "%HookName_08%"
		if ["%HookName_09%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%%i"  "%HookName_09%"
		if ["%HookName_10%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%%i"  "%HookName_10%"
		if ["%HookName_11%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%%i"  "%HookName_11%"
		if ["%HookName_12%"] NEQ [""] Call :CopyHook "%ScriptDir%Hooks"  "%ProjectDir%\.git\modules\%SubModuleDir%\%%i"  "%HookName_12%"
		echo.
	)
)




