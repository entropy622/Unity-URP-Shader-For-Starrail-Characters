using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class GetFaceDir : MonoBehaviour
{
    public Transform HeadBoneTransform;
    public Transform HeadFrontTransform;
    public Transform HeadRightTransform;
    public Material FaceMaterial;
    public Material HairMaterial;

    private int HeadFrontID = Shader.PropertyToID("_Front");
    private int HeadRightID = Shader.PropertyToID("_Right");

#if UNITY_EDITOR
    private void OnValidate()
    {
        LateUpdate();
    }
#endif

    public void SetValue(Material mat)
    {
        Debug.Log("zzz");
        mat.SetVector(HeadFrontID,(HeadFrontTransform.position - HeadBoneTransform.position).normalized);
        mat.SetVector(HeadRightID,(HeadRightTransform.position - HeadBoneTransform.position).normalized);
    }
    private void LateUpdate()
    {
        SetValue(FaceMaterial);
        SetValue(HairMaterial);
    }
}
