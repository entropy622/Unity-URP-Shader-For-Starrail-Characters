[English](README_EN.md)

# 展示

![image](SRLS2.1.3/img/capture187.png)
![image](SRLS2.1.3/img/capture173.png)
![image](SRLS2.1.3/img/capture169.png)

# 更新 Prefabs

现在你可以使用着色好的角色prefab文件了，但你仍要导入_ Settings.unitypackage _ 和_ Volume.unitypackage 两个文件， （在 _SRLS2.1.3_ 文件夹中）.
然后你仍需要在Global Volume(或者Box Volume)的Inspector面板中,在volume->profile一栏选择对应的volume文件 (文件名是 _MI Volume Profile_). 这一步就是上后处理效果.

# 导入

## 为了使用该项目,您的Unity版本需要为2022.3.34或更晚的版本.

1. 将unitypackage文件分别拽入您的项目中.
2. 在.material文件的Inspector面板中,替换对应角色的贴图(.material文件的路径为_(Assets -> 0_SR -> mar_7th)_)
3. 导入角色模型, 上材质 _(eyebrow应该和eye上一样的材质)_ .
4. 在Global Volume(或者Box Volume)的Inspector面板中,在volume->profile一栏选择对应的volume文件 (文件名是 _MI Volume Profile_). 这一步就是上后处理效果.(不会写后处理,就用URP自带的后处理了)
5. 给角色的头部骨骼绑定三个空物体 _(假设他们的名字分别是 Center, Front, Right)_ . Center 的坐标设为 (0,0,0),Front 的坐标设为 (0,0,A)  _(A 是任意正实数)_, Right 的坐标设为 (B,0,0) _(B 是任意负实数)_

- 头部骨骼路径可参考下图(该路径仅仅使用与mmd模型).

![image](SRLS2.1.3/img/Show.png)

6. 将脚本 _(路径为 Assets -> 0_SR -> SRLS2.1 -> GetFaceDir.cs)_ 挂载到人物身上. 然后将三个空物体以及 face/hair 材质拽入脚本(_GetFaceDir.cs_)的Inspector面板中的对应栏目中.(参考上图)

- 眼透效果与脸部的SDF阴影依赖于头部方向向量!

7. 点击 _play_. (脚本(_GetFaceDir.cs_)在play模式下才会运行,并把头部向量传递给shader.所以,如果你打开项目后没有进入过play模式,在editor模式下可能不会有脸部阴影以及眼透效果)

# 其他展示

# Other Presentation
![image](SRLS2.1.3/img/capture175.png)
![image](SRLS2.1.3/img/capture183.png)
![image](SRLS2.1.3/img/capture171.png)i
![image](SRLS2.1.3/img/capture167.png)
![image](SRLS2.1.3/img/capture188.png)
![image](SRLS2.1.3/img/capture179.png)
