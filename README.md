# XTlib
## Cocoapod

pod 'XTlib'


iOS Objective-C快速开发框架


# Root / Category / Header / Database / Color / Network / UIs / Util

介绍如下.
* Root 基类层 主要对各种UIKit控件的封装的基类组. 例如RootTableView(无需关心上下拉刷新).RootTableViewCell(三行展示一个cell)等等等等. 把原本控件按通常需求集成抽象.减少controller重复代码. 提高开发效率 .
* Category分类扩展层 .利用iOS的分类特性. 进行常规类的扩展.
* Header头文件.  避免预编译时间太长. 杜绝在预编译中放入过多的运算和操作. 对各种公共类分类定义.
* Database 数据库层. 对sqlite数据库封装. XTFMDB(对FMDB再封装). [点此跳转](https://github.com/Akateason/XTFMDB). 直接模型制表.线程安全等特性. 调用非常方便.
* Color. 颜色管理器. 项目中的颜色全部封装到配置文件.plist. 支持各种规则式样的颜色(rgb,rgba,十六进制)生成器. 只需在配置完成后. 通过宏定义的方法手动加到一个UIColor的Category. 就能在项目中全局调用.
* Network网络层. 我封装得XTReq框架. [点此跳转](https://github.com/Akateason/XTReq). 最外层调用只需关注业务处理. 业务与实现完全独立开. 带缓存逻辑. 可设不同的缓存策略. 
* UIs 控件层. 我封装的许多非常规控件. 
* Util 工具层 项目中会用到的一些工具. 



