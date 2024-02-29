# vscode 使用

## vscode 快捷键

参考：[vscode配置和快捷键](https://www.yc00.com/news/1699252806a907163.html)

---

| 快捷键                                        | 功能                                             |
| --------------------------------------------- | ------------------------------------------------ |
| <kbd>Ctrl</kbd> <kbd>p</kbd> 或 <kbd>F1</kbd> | 搜索文件                                         |
| <kbd>Ctrl</kbd> <kbd>Shift</kbd> <kbd>l</kbd> | 选中所有匹配的选定内容，可以一次性修改           |
| <kbd>Ctrl</kbd> <kbd>d</kbd>                  | 选中该选定内容的下一个匹配项，再按会再次向下匹配 |
| <kbd>Ctrl</kbd> <kbd>u</kbd>                  | <kbd>Ctrl</kbd> <kbd>d</kbd> 的逆操作            |
| <kbd>Ctrl</kbd> <kbd>l</kbd>                  | 选择整行                                         |
| <kbd>Ctrl</kbd> <kbd>g</kbd>                  | 跳转到指定行                                     |
| <kbd>Ctrl</kbd> <kbd>k</kbd> + <kbd>w</kbd>   | 关闭所有标签页                                   |
| <kbd>Alt</kbd> <kbd>up</kbd>                  | 向上移动行                                       |
| <kbd>Alt</kbd> <kbd>down</kbd>                | 向下移动行                                       |
| <kbd>Ctrl</kbd> <kbd>`</kbd>                  | 打开终端                                         |
| <kbd>Ctrl</kbd> <kbd>\\</kbd>                 | 分割窗口                                         |
| <kbd>Ctrl</kbd> <kbd>1</kbd>、<kbd>2</kbd>    | 分聚焦到第 1、2 个编辑器                         |
| <kbd>Ctrl</kbd> <kbd>/</kbd>                  | 注释行                                           |
| <kbd>Ctrl</kbd> <kbd>+</kbd>/<kbd>-</kbd>     | 放大/缩小                                        |

## VS Code 括号、引号的自动补全

参考：[VS Code 括号、引号的自动补全](https://zhuanlan.zhihu.com/p/651290630?utm_id=0)

- 设置：*"editor.autoClosing": "languageDefined"*
  - *languageDefined* 对应 *$HOME/resources/app/extensions/XXX/* 路径下的 *language-configuration.json* 文件，其中： $HOME 表示安装目录；XXX 表示 某个语言，如Java、HTML、MarkDown。

- 具体参考：[语言配置指南](https://code.visualstudio.com/api/language-extensions/language-configuration-guide)

## 插件

- 11 个你不需要的 Visual Studio Code 扩展，开发者 Wesley Smits 以自身经验为例罗列了11 个他认为已经没用的扩展。**“由于扩展可能会导致性能问题、增加 CPU 使用率，并且可能与其他扩展或本地功能发生冲突，因此最好将扩展限制为你所需要的扩展”**。
- Wesley Smits 指出，有些扩展的下载页面顶部有甚至有明确的弃用通知，但在 Medium、dev.to、Reddit 等一些平台上却仍有推荐贴。值得一提的是，这些扩展中有许多是原生存在于 Visual Studio Code 中，所以可以通过设置菜单启用 / 禁用或进行控制。
- 这些设置可以通过 UI 或 JSON 配置来控制。Wesley Smits 在文中以 JSON 版本为例建议：可以通过命令面板（⇧ ⌘P）打开全局 Visual Studio 代码设置的 settings.json。输入 settings，然后选择 "Preferences: Open User Settings (JSON)"。
- 这 11 个扩展具体包括：
  1. Auto Rename Tag — 1050 万次下载；
  2. Auto Close Tag — 800 万次下载；
  3. Auto Import — 250 万次下载；
  4. Settings Sync — 340 万次下载；
  5. Trailing Spaces— 110 万次下载；
  6. Path Intellisense — 800 万次下载
  7. NPM — 560 万次下载
  8. HTML Snippets — 840 万次下载
  9. HTMLTagWrap— 415K 次下载
  10. Lorem Ipsum — 473K 次下载
- Visual Studio Code 有一个广泛的扩展市场，可以增加你的便利度。但在安装其中一个之前，最好先看看它是否还没有原生支持。随着时间的推移，包含改进和功能的每月发布更新，越来越多的 Visual Studio Code 扩展将不再需要。

<https://zhuanlan.zhihu.com/p/113222681?utm_source=com.tencent.wework&utm_id=0&wd=&eqid=9b13917c0009eb23000000056489cb32>
