---
title: "Class diagram sample"
categories:
 - Temp
tags:
 - temp
published: false
---


@startuml

class BitMapMeshGridVertices
class PImageViewer
class MeshImagePopup
' Class Definition
class PanelSingleViewControl
' class CutPlanePolygonExtractorCommonWithRemoveAffects
class ItemMeshImage
class MeshDataGenerator
{
    + MeshData Generate()
}
class MeshData
{
    + PrePareConfig()
    + PrePare()
    + Update()
}
interface IItemMeshImage
interface IMeshPositionGenerator
interface IMeshInfo
interface IMeshParameter

class BitmapMeshData
class NonuniformMeshPositionGenerator
class MeshGridVertexGenerator
class NonUniformMeshGen
class MeshInfoNonUniform
class DefaultNonUniformParameter
class MeshParameterGenerator
 
' Class Relations
PanelSingleViewControl -left-> IItemMeshImage
ItemMeshImage -up-|> IItemMeshImage
' PanelSingleViewControl ..> CutPlanePolygonExtractorCommonWithRemoveAffects
ItemMeshImage .right.> MeshDataGenerator
MeshDataGenerator ..> MeshData
BitmapMeshData -up-|> MeshData
NonuniformMeshPositionGenerator -up-|> IMeshPositionGenerator
BitmapMeshData .right.> IMeshPositionGenerator
NonuniformMeshPositionGenerator .right.> MeshGridVertexGenerator
MeshGridVertexGenerator ..> NonUniformMeshGen
MeshInfoNonUniform -up-|> IMeshInfo
DefaultNonUniformParameter -up-|> IMeshParameter
NonuniformMeshPositionGenerator --> IMeshParameter
MeshGridVertexGenerator --> IMeshParameter
NonUniformMeshGen --> IMeshParameter
PImageViewer <-up- MeshImagePopup
PanelSingleViewControl -down-> MeshImagePopup
MeshImagePopup -up-> IItemMeshImage
'Note
note right of MeshData
실제 BitMap 생성 하는 로직
endnote

note right of MeshParameterGenerator
~~BoundBox BBS 를 만들때 기존 Z축에 대한 자료구조만 만들었는데~~
~~X, Y 축 모두 하게 될 경우 가 생겼으므로~~
~~BBS를 X, Y 축에 대해서 미리 만들어 놓는다.~~
~~Parallel.Invoke 를 가지고 병렬 처리를 한다.~~
endnote

note right of MeshGridVertexGenerator
GetVertices Method 에서 X, Y 축에 대한 함수를
GetNonuniformMeshVertices로 바꾼다.
endnote

note left of DefaultNonUniformParameter
LimitMeshCellSize
UniformMeshCellSize
미리 Axis에 따라거 계산 하지 말고,
ItemPoint3DF 값으로 설정
Runtime시에 결정 해서 사용 하도록 함
end note

note right of NonUniformMeshGen
Run() 함수 호출 시 XYZ AxisType을 입력?
Constructor() 에서 둘중 DI 한다.
end note

note left of IMeshParameter
RCWA SolidBoundBoxes 사용하지 않음
GetSolidBoundBoxes(enAxisType)으로 변경
end note

note as n1
1. CollectionBoundbox 코드 부분 찾아서 수정.
2. MinMesh RCWA 에서도 사용 함.(수정)
end note

@enduml