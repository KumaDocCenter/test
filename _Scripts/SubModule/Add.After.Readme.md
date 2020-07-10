---
title: Add.After 使用指南
date: 2020-05-31 23:29:14
updated: 2020-05-31 23:29:14
mathjax: false
categories: 
tags:
  - Readme
typora-root-url: Readme
typora-copy-images-to: Readme
top: 1
comments: false
---

# Add.After 使用指南

Git子模块添加后续处理，当前包含的操作有：

* 稀疏检出配置
  * `/Y` : 相关文件已存在则备份，后缀为时间戳。
  * 普通情况下，文件不存在才复制文件。
* 钩子配置
  * `/Y` : 相关文件已存在则备份，后缀为时间戳。
  * 普通情况下，文件不存在才复制文件。



## 使用


`Add.After.bat`  ： Git子模块添加后续处理。

 ```
[arg1] : /Y 目标中文件已存在时也执行相关命令
[arg1] : 子模块目录名(如 Ajax)
[arg2] : /Y 目标中文件已存在时也执行相关命令
 ```

无`子模块目录名`时，默认处理配置中指定目录下的所有子模块。

**示例**

```
>Add.After.bat
>Add.After.bat /Y
>Add.After.bat test /y
```

根据实际修改配置文件



## 目录结构

```
Hooks/               #钩子目录
sparse-checkout      #稀疏检出配置文件
Add.After.bat        #核心脚本
Add.After.Conf.bat   #主配置文件(或配置文件样本)
```




## 参考阅读

 
