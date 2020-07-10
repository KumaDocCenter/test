:: ===================================================================
:: 配置文件
:: 
:: 
:: ===================================================================
:: 关闭回显
@echo off
:: %~dp0(K:\...\<Item>\Menu.Conf\)
:: NewCD(K:\...\<Item>)
set OldCD=%cd%
cd %~dp0
:: 跳转到上级目录
cd ..
cd ..
set NewCD=%cd%
cd %OldCD%

:: 项目根目录(K:\...\<Dir>)
set "ProjectDir=%NewCD%"
:: 子模块根目录名
set "SubModuleDir=source_md"
:: 钩子名称
set "HookName_01=post-checkout"
set "HookName_02=post-commit"
set "HookName_03=post-merge"
set "HookName_04=pre-push"
REM set "HookName_05=XXX"
REM set "HookName_06=XXX"
REM set "HookName_07=XXX"
REM set "HookName_08=XXX"
REM set "HookName_09=XXX"
REM set "HookName_10=XXX"
REM set "HookName_11=XXX"
REM set "HookName_12=XXX"


