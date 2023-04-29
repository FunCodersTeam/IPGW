<h1 align="center">东北大学网关认证助手</h1>

<p align="center">
<a href="https://app.codacy.com/gh/FunCodersTeam/IPGW/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade"><img src="https://app.codacy.com/project/badge/Grade/98f5b166f7cc4f6385eab32b69ff224d"/></a>
<img src="https://img.shields.io/github/stars/FunCodersTeam/IPGW?style=flat&logo=github&color=ff69b4">
<img src="https://img.shields.io/github/forks/FunCodersTeam/IPGW?style=flat&logo=github&color=blue">
<img src="https://img.shields.io/github/issues/FunCodersTeam/IPGW?style=flat&logo=github">
<br>
<a href="#安装">安装</a> | <a href="#使用方法">使用方法</a> | <a href="https://github.com/FunCodersTeam/IPGW/issues/new">反馈</a>
</p>

欢迎使用网关认证助手🎉！这是一个非常轻量化的 Bash 脚本，旨在为无桌面环境的用户提供便捷安全的 IPGW 认证方式。该脚本可以通过命令行工具进行调用，无需图形界面，无需安装额外软件，方便在服务器、终端等无桌面环境的情况下进行认证。

> **Tip:** 本脚本不会保存或者传输您的个人信息，请放心使用

## 安装

要使用此脚本，您需要在系统上安装 `curl` 或 `wget`。如果您没有安装它们，您需要先安装它们。

一旦您安装了 `curl` 或 `wget`，您可以从 Github 下载此脚本：

```bash
$ git clone https://github.com/FunCodersTeam/IPGW.git
```
如果您的设备可以访问校内网，建议您使用以下命令：
```bash
$ curl -O http://219.216.99.37/ipgw.sh
```
或者：
```bash
$ wget http://219.216.99.37/ipgw.sh
```

## 使用方法

要使用此脚本，请导航到保存脚本的目录，并运行以下命令：
```bash
$ chmod +x ipgw.sh
```
添加可执行权限后，再运行：
```bash
$ . ipgw.sh
```
或者：
```bash
$ source ipgw.sh
```
脚本将提示您输入您的学号和密码。输入您的凭据后，脚本将登录到 IPGW 系统中。

如果您已经登录到 IPGW 系统，脚本也会告知您。

要退出 IPGW 系统，您可以运行以下命令：
```bash
$ loginout
```
## 结构和贡献

此项目由一个 Bash 脚本 ipgw.sh 组成。脚本分为几个函数，处理登录过程的不同方面。

如果您想要为此项目做出贡献，欢迎您 fork 仓库并创建一个 pull request。请确保遵循现有代码中使用的编码风格和约定。

许可证
此项目根据 MIT 许可证授权。有关详情，请参阅 LICENSE 文件。

## 维护者和联系方式

此项目由 [guidons](https://github.com/guidons-master) 维护。如果您有任何问题或反馈，请通过 guidons.tech@google.com 联系我。

## 致谢

在实现过程中，参考了 [neugo](https://github.com/neucn/neugo) 项目的代码，非常感谢该项目的开发者所提供的宝贵参考。
