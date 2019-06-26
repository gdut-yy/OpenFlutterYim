# OpenFlutterYim

![](github/ic_yim_flutter.png)

## 开发环境
```
$ flutter --version
Flutter 1.5.4-hotfix.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 7a4c33425d (2 weeks ago) • 2019-04-29 11:05:24 -0700
Engine • revision 52c7a1e849
Tools • Dart 2.3.0 (build 2.3.0-dev.0.5 a1668566e5)
```

```
Android Studio 3.4
Build #AI-183.5429.30.34.5452501, built on April 10, 2019
JRE: 1.8.0_152-release-1343-b01 amd64
JVM: OpenJDK 64-Bit Server VM by JetBrains s.r.o
Windows 10 10.0
```

FlutterBoost 需要修改源码：

- `BoostFlutterView.java` ViewCompat android.support => androidx
- `BoostFlutterFragment.java` Fragment android.support => androidx
- `BoostFlutterNativeView.java` 去掉 detach 的 @Override

## 特别感谢

网易、环信、融云、容联云、企达、腾讯云、firebase
- DartVM服务器开发文章目录（27）：https://www.jianshu.com/p/32e2dcf5f391
- Flutter实战一Flutter聊天应用（21）：https://github.com/hekaiyou/talk_casually
- Flutter 第三方包：https://pub.dartlang.org/flutter
- 阿里巴巴FlutterBoost：https://github.com/alibaba/flutter_boost （50 commits）
- 阿里巴巴FlutterGo：https://github.com/alibaba/flutter-go （398 commits）
- Yim电影模块参考：https://github.com/songxiaoliang/visitor-flutter （36 commits）
- Yim读书模块参考：https://github.com/huanxsd/flutter_shuqi （32 commits）
- Yim音乐模块参考1：https://github.com/boyan01/flutter-netease-music （327 commits）
- 网易云音乐Api：https://github.com/Binaryify/NeteaseCloudMusicApi
- Yim音乐模块参考2：https://github.com/wukuy/cloud-music-mobile （29 commits）
- Yim商城模块参考：https://github.com/youjinjin/flutter_shop （102 commits）

## 毕设开源预告

FYim（flutter-yim）是本人基于 Flutter 技术开发的一款跨平台聊天社交应用，主要包含 IM（仿微信）、电影（仿豆瓣）、小说（仿书旗小说）、音乐（仿网易云音乐）四大模块。（Native？RN？Weex？Google I/O 2019 上 Flutter for Web 的发布预示 Flutter 或将成为全平台 UI 框架？）

在持续半年的开发过程中，历经 Flutter 版本从 1.0.0 升至 1.6.x，微信版本从 6.7.x 升至 7.0.x，书旗小说 API 改造，网易云音乐整体 UI 改造，Android 9 适配等各种坑…… 最坑的是，在答辩前一周时突然发现第三方  API 接口下线，不得不连夜 fork 出分支使用豆瓣 API 来救火……

BTW，感谢指导老师，感谢答辩老师，感谢阿里开源的 FlutterBoost 混合开发方案，感谢 GitHub 社区上给予过帮助的伙伴们。为更好地感谢和回馈开源社区，遂决定稍后将此项目开源。

## Git Branchs

- `0.0.1`：flutter_app。Flutter 最初的样子，用于测试开发环境是否搭配成功。
- `0.1.0`：集成 flutter_boost。项目测试，此分支后暂时只支持 android。
- `1.x`：module_movie、module_novel、module_cloud_music
- `2.x`：module_movie => module_douban

## Yim 主模块（仿微信）
![](github/fyim4.jpg)

![](github/fyim9.jpg)

![](github/fyim6.jpg)

![](github/fyim7.jpg)

## Yim 电影模块（仿豆瓣）

![](github/fyim2.jpg)

![](github/fyim3.jpg)

## Yim 小说模块（仿书旗小说）

![](github/fyim5.jpg)
## Yim 音乐模块（仿网易云音乐）
![](github/fyim1.jpg)