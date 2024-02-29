# Java图形化界面设计之容器（JFrame）详解

原文链接：[Java图形化界面设计之容器（JFrame）详解](https://blog.csdn.net/qq_43842093/article/details/124905040)

## Java图形化界面设计——容器（JFrame）

​  程序是为了方便用户使用的，因此实现图形化界面的程序编写是所有编程语言发展的必然趋势，在[命令提示符](https://so.csdn.net/so/search?q=命令提示符&spm=1001.2101.3001.7020)下运行的程序可以让我们了解java程序的基本知识体系结构，现在就进入java图形化界面编程。

### 一、Java基本类（JFC）

​  Java基本类(“JavaFoundationClasses”，JFC)，由一些软件包组成。这些软件包主要包括下面一些应用程序接口(API)：

- 抽象窗口工具集(AWT)(1.1及以上版本)。

- Swing构件。

- Java2D应用程序接口(2DAPI)。

- 兼容程序接口。

​  上面列出的这些应用程序接口可难会出现在多个软件包中。例如：2DAPI在Java.awt和Java.awt.image软件包中都存在，虽然像Java.awt.geom等一些特殊的软件包也支持2DAPI，但是大量的2DAPI类都存在于Java.awt软件包中。

---

​  AWT(1.1及以上版本)是JFC的核心。AWT为JFC的构成提供了以下基本结构：

- 代理事件模型。

- 轻量构件。

- 剪贴板和数据传输。

- 打印和无鼠标操作。

#### 1、AWTAbstractWindowToolkit（AWT）抽象窗口工具包

​  AWT是比较旧的双介面函式库，它依然高度倚赖各作业平台自身所具备的绘图功效机能，且用一个比包容程式（Wrapper）还小的设计还去除、吸收各作业平台间的绘图功能机能差异，以致Java程式在跨平台移携后的绘图呈现不够一致，这使得AWT遭受到众多的批评。这意味着：AWT的Widget倚赖作业平台自身原有的Widget功效机能，程式设计师在开发撰写时必须去了解各作业平台在Widget方面的差异性，如此便偏离了Java程式语言最初的宗旨：跨平台一致性。

​  AWT由java.awt包提供，其提供了支持GUI设计的类和接口，而又AWT提供的组建一般称之为重量级组件，其是由本地方法来实现其功能的。AWT的特点：

- AWT中的图形函数与操作系统所提供的图形函数之间有着一一对应的关系

- AWT通过牺牲功能来实现其平台无关性

- AWT不能满足图形化用户界面发展的需要

---

#### 2、Swing包

​  为了解决AWT组件的缺陷，特别是跨平台的问题，在JDK1.2版本后提供了新的Swing包，有javax.swing提供，Swing是在AWT的基础上构建的一套新的图形界面组件，所有组建均是由java书写，具有良好的跨平台性，由于Swing没有使用本地方法实现图形功能，因此提出把Swing组件称之为轻量级组件。

注意：Swing组建是在AWT基础上建立的，而不是替代AWT的，AWT是根基，Swing是发展。

---

​  Swing组件几乎都是轻量组件，那些顶层容器：窗体，小应用程序、窗口和对话框除外。因为轻量组件是在其容器的窗口中绘制的，而不是在自己的窗口中绘制的，所以轻量组件最终必须包含在一个重量容器中。因此，Swing的窗体、小应用程序、窗口和对话框都必须是重量组件，以便提供一个可以在其绘制Swing轻量组件的窗口。

​  Swing包括250多个类，其中有些是UI组件，有些是支持类。为了把UI组件和支持类区分开，Swing组件的名字以J开头。表1-1列出了Swing提供的J组件。用斜体字表示的组件是AWT组件的替代组件。

---

​  表1-1 **Swing** UI组件

|      组件类       |                             描述                             |
| :---------------: | :----------------------------------------------------------: |
|      JApplet      |    Java.applet.Applet类的扩展，它含有JRootPane的一个实例     |
|      JButton      |      能显示文本和图形的按钮，它是AWT按钮组件的替代组件       |
|     JCheckBox     |     能显示文本和图形的复选框，它是AWT选择组件的替代组件      |
| JCheckBoxMenuItem |    一个复选框菜单项，它是AWT的复选框菜单项组件的替代组件     |
|     JComboBox     |        带下拉列表的文本框，它是AWT选择组件的替代组件         |
|    JComponent     |                     所有轻量J组件的基类                      |
|   JDesktopPane    |                        内部窗体的容器                        |
|      JDialog      |           Swing对话框的基类，它扩展了AWT Dialot类            |
|    JEditorPane    |                    用于编辑文本的文本窗格                    |
|      JFrame       |                 扩展java.awt.Frame的外部窗体                 |
|  JInternalFrame   |                在JDesktopPane中出现的内部窗体                |
|      JLabel       |      可显示文本和图标的标签，它是AWT标签组件的替代组件       |
|   JLayeredPane    |                 能够在不同层上显示组件的容器                 |
|       JList       |        显示选项列表的组件，它是AWT列表组件的替代组件         |
|       JMenu       |      菜单条中显示的一个菜单，它是AWT菜单组件的替代组件       |
|     JMenuBar      |      用于显示菜单的菜单条，它是AWT菜单条组件的替代组件       |
|     JMenuItem     |             菜单项，它是AWT菜单项组件的替代组件              |
|    JOptionPane    |            显示标准的对话框，如：消息和问题对话框            |
|      JPanel       |          通用容器，它是AWT面板和画布组件的替代组件           |
|  JPasswordfield   |             JTextField的扩展，使输入的字符不可见             |
|    JPopupMenu     |         弹出式菜单，它是AWT弹出式菜单组件的替代组件          |
|   JProgressBar    |                          进度指示器                          |
|   JRadioButton    |            单选按钮，它是AWT复选框组件的替代组件             |
|     JRootPane     | 顶层容器，它包含一个玻璃窗格，一个层窗格，一个内容窗格和一个可选的菜单条 |
|    JScrollBar     |             滚动条，它是AWT滚动条组件的替代组件              |
|    JScrollPane    |           滚动窗格，它是AWT滚动窗格组件的替代组件            |
|    JSeparator     |                       水平或垂直分隔条                       |
|      JSlider      |                             滑杆                             |
|    JSplitPane     | 有两个分隔区的容器，这两个分隔区可以水平排列或者垂直排列且分隔区的大小能自动调整 |
|    JTabbedPane    |                        带选项卡的窗格                        |
|      JTable       |                             表格                             |
|   JTableHeader    |                            表格头                            |
|     JTextArea     |    用于输入多行文本的文本域，它是AWT文本域组件的替代组件     |
|  JTestComponent   |          文本组件的基类，它替代AWT的TextComponent类          |
|    JTextField     |            单行文本域，它替代AWT的单行文本域组件             |
|     JTextPane     |                       简单的文本编辑器                       |
|   JToggleButton   |    两种状态的按钮，它是JCheckBox和JRadioButton组件的基类     |
|     JToolBar      |                            工具条                            |
|     JToolTip      |       当光标停留在一个组件上时，该组件上显示的一行文字       |
|       JTree       |                用于按钮层次组织数据的结构控件                |
|     JViesport     |                   用于浏览可滚动组件的视口                   |
|      JWindow      |             外部窗口，它是java.awt.Window的扩展              |

注：斜体字表示的是AWT的替代组件
