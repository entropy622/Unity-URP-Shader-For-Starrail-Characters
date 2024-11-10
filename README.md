# Presentation
![image](SRLS2.1.3/img/capture187.png)
![image](SRLS2.1.3/img/capture173.png)
![image](SRLS2.1.3/img/capture169.png)

# UPdate prefabes 更新prefabs
Now you can just using the prefabs of shaded characters，but you still need to import the_ Settings.unitypakage _ and the_ Volume.unitypackage_ files in _SRLS2.1.3_ folder.
And you still need to apply the post-processing effect. in the Global Volume (or Box Volume) Inspector panel, select the corresponding volume file (file name is _MI Volume Profile_) under the "volume->profile" section.
现在你可以使用着色好的角色prefabe文件了，但你仍要导入_ Settings.unitypakage _ 和_ Volume.unitypackage 两个文件， （在 _SRLS2.1.3_ 文件夹中）.
然后你仍需要在Global Volume(或者Box Volume)的Inspcter面板中,在volume->profile一栏选择对应的volume文件 (文件名是 _MI Volume Profile_). 这一步就是上后处理效果.(不会写后处理,就用URP自带的后处理了)


# Import(ver.ENG)
## To import the shader into your project, the unity version should be 2022.3.34 or later
1. Drag the unitypackage files into your project seperately.
2. Replace the texture in the inspector panel for each materials _(Assets -> 0_SR -> mar_7th)_
3. Import the character model, and apply the materials _(the eyebrow should be applied with the eye material)_ .
4. Choose volume from the imported files (The name is _MI Volume_)
5. Binding three empty objects _(Assume naming they as Center, Front, Right)_ with the character's head.Set the position of Center as (0,0,0),the position of Front as (0,0,A)  _(A could be any positive number)_, the position of Right as (B,0,0) _(B could be any nagetive number)_
###### the path of the head bone is showed in the follow img.
![image](SRLS2.1.3/img/Show.png)
6. Attach the script _(Assets -> 0_SR -> SRLS2.1 -> GetFaceDir.cs)_ to the character.Then drag the three empty objects and face/hair materials into the corresponding columns in the inspector panel.(Like the upper img)
##### The eye-through-the-hair effect and face SDF shadow depend on the facing direction vector.
7. Click _play_.(The _GetFaceDir.cs_ script wouldn't update the facing direction in edit mode when you are rotating your character.)

# Import(ver.CHI)
## 为了使用该项目,您的Unity版本需要为2022.3.34或更晚的版本.
1. 将unitypackage文件分别拽入您的项目中.
2. 在.material文件的inspector面板中,替换对应角色的贴图(.material文件的路径为_(Assets -> 0_SR -> mar_7th)_)
3. 导入角色模型, 上材质 _(eyebrow应该和eye上一样的材质)_ .
4. 在Global Volume(或者Box Volume)的Inspcter面板中,在volume->profile一栏选择对应的volume文件 (文件名是 _MI Volume Profile_). 这一步就是上后处理效果.(不会写后处理,就用URP自带的后处理了)
5. 给角色的头部骨骼绑定三个空物体 _(假设他们的名字分别是 Center, Front, Right)_ . Center 的坐标设为 (0,0,0),Front 的坐标设为 (0,0,A)  _(A 是任意正实数)_, Right 的坐标设为 (B,0,0) _(B 是任意负实数)_
###### 头部骨骼路径可参考下图(该路径仅仅使用与mmd模型).
![image](SRLS2.1.3/img/Show.png)
6. 将脚本 _(路径为 Assets -> 0_SR -> SRLS2.1 -> GetFaceDir.cs)_ 挂载到人物身上. 然后将三个空物体以及 face/hair 材质拽入脚本(_GetFaceDir.cs_)的inspector面板中的对应栏目中.(参考上图)
##### 眼透效果与脸部的SDF阴影依赖于头部方向向量!
7. 点击 _play_. (脚本(_GetFaceDir.cs_)在play模式下才会运行,并把头部向量传递给shader.所以,如果你打开项目后没有进入过paly模式,在editor模式下可能不会有脸部阴影以及眼透效果)

# Other Presentation
![image](SRLS2.1.3/img/capture175.png)
![image](SRLS2.1.3/img/capture183.png)
![image](SRLS2.1.3/img/capture171.png)i
![image](SRLS2.1.3/img/capture167.png)
![image](SRLS2.1.3/img/capture188.png)
![image](SRLS2.1.3/img/capture179.png)
