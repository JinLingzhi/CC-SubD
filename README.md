# CC-SubD
该程序实现了Catmull-Clark细分曲面的精确评估，旨在为求解基函数提供一个稳健的工具，以支持基于细分的等几何分析的相关工作。

This program implements the exact evaluation of Catmull-Clark subdivision surfaces, aiming to provide a robust tool for solving basis function to support related work of subdivision-based isogeometric analysis.

![这是图片](https://raw.githubusercontent.com/JinLingzhi/Pictures/main/freecompress-vehicle.png)

# 文件结构
```
CC-SubD:.
├─subd_basis   \\计算细分曲面基函数
├─subd_eval    \\计算细分曲面点和偏导矢
├─subd_find    \\关于元素搜索的相关函数
├─subd_init    \\初始化细分曲面数据
├─subd_plot    \\关于绘图的相关函数
└─subd_refine  \\细分曲面控制网格细分
```

# 示例

## 程序开始
```
% 读取OBJ文件，并生成细分曲面网格数据的结构体
[vertex,face] = Obj2Matlab('Vehicle.obj');
[subd] = CCS2DMaker(vertex,face);

% 绘制细分任意次的控制网格
figure
CCS2DPlotMesh(subd,3);
hold on

% 初始化细分曲面数据
[SubDInfos,subd] = CCS2DInitInfo(subd,1);

% 绘制每个控制网格相应极限曲面上若干个点
for i = 1:size(subd.face,1)
    SubDInfo = SubDInfos(i);

    y = linspace(SubDInfo.corner(2),SubDInfo.corner(4),11);
    x = linspace(SubDInfo.corner(1),SubDInfo.corner(3),11);
    [yy,xx] = meshgrid(y,x);

    u = [reshape(xx,1,[]);reshape(yy,1,[])];
    P = CCS2DPointEval(SubDInfo,subd.vertex,u);

    plot3(P(1,:),P(2,:),P(3,:),'b.');
    hold on
end

```

## 已支持网格类型
在细分控制网格进行十字剖分的过程中，主要将其划分为以下几类网格，每类网格对应的细分编号规则在程序中均有着不同的处理方式。

1.内部规则网格(ftype-10)
![这是图片](https://raw.githubusercontent.com/JinLingzhi/Pictures/main/ftype-10.png)

2.含一个奇异点的内部非规则网格(ftype-11)
![这是图片](https://raw.githubusercontent.com/JinLingzhi/Pictures/main/ftype-11.png)

3.一般的边界网格1(ftype-201)
![这是图片](https://raw.githubusercontent.com/JinLingzhi/Pictures/main/ftype-201.png)

4.一般的边界网格2(ftype-202)
![这是图片](https://raw.githubusercontent.com/JinLingzhi/Pictures/main/ftype-202.png)

5.含一个边界顶点的边界网格(ftype-21)
![这是图片](https://raw.githubusercontent.com/JinLingzhi/Pictures/main/ftype-21.png)

6.含二个边界顶点的边界网格1(ftype-221)
![这是图片](https://raw.githubusercontent.com/JinLingzhi/Pictures/main/ftype-221.png)

7.含二个边界顶点的边界网格2(ftype-222)
![这是图片](https://raw.githubusercontent.com/JinLingzhi/Pictures/main/ftype-222.png)

8.含三个边界顶点的边界网格(ftype-23)
![这是图片](https://raw.githubusercontent.com/JinLingzhi/Pictures/main/ftype-23.png)

# 版本说明
v1.0.0版本只提供matlab版本的相关程序，并存放于matlab分支下。该版本已基本实现了细分曲面基函数计算的核心功能，但目前仅有部分代码附带了注释，后续版本将进一步完善。

v1.0.0 version only provides relevant programs in the MATLAB version, which are stored under the MATLAB branch. This version has implemented most of the core functions for basis function calculations, but currently, only some of the code includes comments. Future versions will further improve this.

# 更新日志
v1.0.0 

实现了不同类型的边界网格、含一个奇异点内部非规则网格以及内部规则网格相应极限曲面的基函数计算。

implemented the basis function calculations for different types of boundary grids, internal irregular mesh with a singularity, and the corresponding limit surfaces of internal regular grids.