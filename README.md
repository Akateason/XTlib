# XTkit
iOS快速开发框架
XTkit
主要分几个模块
# Root / Category / Header / Database / Color / Network / UIs / Util

介绍如下.
* Root 基类层 主要对各种UIKit空间的封装的根类. 例如table.cell等等等等. 把原本复杂控件的集成抽象. 提高开发效率 .
* Category分类扩展层 .利用iOS的分类特性. 进行类的扩展.  
* Header头文件.  避免预编译时间太长. 杜绝在预编译中放入过多的运算和操作. 对各种公共类分类定义.
* Database 数据库层. 对sqlite数据库封装. XTFMDB(对FMDB再封装). 直接模型制表.线程安全等特性. 调用非常方便.
* Color. 颜色管理器. 封装到配置文件. 支持各种规则式样的颜色生成器. 只需在配置完成后. 手动加到一个Category. 就能在项目中全局调用.
* Network网络层. 我封装得XTReq框架. 封装3层专门处理项目中用到的请求. 最外层只需要关注到业务处理. 业务独立开. 带缓存逻辑. 可按需求. 分配不同的缓存策略. 也可不缓存 . 
* UIs 控件层. 许多非常规控件 .
* Util 工具层 一些小工具. 
