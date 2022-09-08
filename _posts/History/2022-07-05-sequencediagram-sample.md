---
title: "Sequence diagram sample"
categories:
 - Temp
tags:
 - temp
published: false
---

@startuml
Main -> DataManagerOptimizer ++ : _loadEventProcess
    DataManagerOptimizer -> DataManagerOptimizer ++ : UpdateFFTFileLoadData()
        DataManagerOptimizer -> FFTFileLoader ++ : LoadFftDataSet()
            FFTFileLoader -> FFTFileLoader ++ : Get New FFT FileList
            FFTFileLoader --         
            loop FFT File Load(Parallel)
                FFTFileLoader -> FftFileReader ++ : GetSimulationFFTFileData()
                return                
            end
            hnote right #HotPink : 최종적으로 PipeLine 병렬처리를 생각해 봐야함.
            loop Make New Data List
                alt Check Result File
                else Exist
                    FFTFileLoader -> FFTFileLoader ++ : newDataList 추가
                    FFTFileLoader --
                else Not Exist
                    FFTFileLoader -> IFDTDToFFTConverter ++ : ConvertAndSave()
                    return
                    FFTFileLoader -> FFTFileLoader ++ : newDataList 추가
                    FFTFileLoader--
            end
            
            FFTFileLoader -> FFTDataSet ++ : FillData()
                FFTDataSet -> FFTDataSet ++ : GroupBy with FFTKey
                FFTDataSet --
                FFTDataSet -> FFTDataSet ++ : VH Grouping With AngeKey(theta,phi)
                FFTDataSet --
                FFTDataSet -> FFTDataSet ++ : FillNearField()
                loop EFieldSet
                    FFTDataSet -> FFTDataConvertor ++ : ConvertToNear()
                    return
                end
                
                note right
                    NearField 데이터 생성
                    메모리 생성
                    NearField 생성 후 
                    원본 데이터가 필요 한가?
                end note
                FFTDataSet -> FFTDataSet ++ : ConvertToNear()
                FFTDataSet --
                FFTDataSet --
            return;
        return
    DataManagerOptimizer --
    
    DataManagerOptimizer -> DataManagerOptimizer ++ : UpdateResultSimulationItemList()
        loop Parallel
        note bottom
        Image Simulation 시작
        end note
            DataManagerOptimizer -> ImageSimulationProcess ++ : Process()
                ImageSimulationProcess -> ImageSimulationProcess ++ : processInternal()
                ImageSimulationProcess -> ImageSimulationProcess ++ #SkyBlue : CalcApertureResult();
                loop AngleKey Theta, Phi
                    ImageSimulationProcess -> ImageSimulationProcess ++ : InitFTCoef();
                    hnote right #HotPink : MaskImage[] (In)
                        ImageSimulationProcess -> ImageSimulationProcess ++ : CircularShift()
                        hnote right #HotPink : MaskImage[] (Out)
                        ImageSimulationProcess --
                    ImageSimulationProcess --

                    group H/V Process
                    
                    ImageSimulationProcess -> ImageSimulationProcess ++ #Red : ZeroPadding()
                    note right : Start H Field
                        ImageSimulationProcess -> ImageSimulationProcess ++ : CircularShift() x3
                        note right #HotPink : Complex[] x3
                        ImageSimulationProcess --

                        ImageSimulationProcess -> ImageSimulationProcess ++ : 
                        note right #HotPink : ex, ey, ez complex[]
                        ImageSimulationProcess --

                        ImageSimulationProcess -> ImageSimulationProcess ++ : CircularShift() x3
                        note right #HotPink : Complex[] x3
                        ImageSimulationProcess --
                    ImageSimulationProcess --

                    ImageSimulationProcess -> ImageSimulationProcess ++ : CalcExpFFTApt()
                    ImageSimulationProcess --

                    
                    ImageSimulationProcess -> ImageSimulationProcess ++ #Red : ZeroPadding()
                    note right : Start V Field
                        ImageSimulationProcess -> ImageSimulationProcess ++ : CircularShift() x3
                        note right #HotPink : Complex[] x3
                        ImageSimulationProcess --

                        ImageSimulationProcess -> ImageSimulationProcess ++ : 
                        note right #HotPink : ex, ey, ez complex[]
                        ImageSimulationProcess --

                        ImageSimulationProcess -> ImageSimulationProcess ++ : CircularShift() x3
                        note right #HotPink : Complex[] x3
                        ImageSimulationProcess --
                    ImageSimulationProcess --

                    ImageSimulationProcess -> ImageSimulationProcess ++ : CalcExpFFTApt()
                    ImageSimulationProcess --    
                    end
                end
                ImageSimulationProcess --

                ImageSimulationProcess -> ImageSimulationProcess ++ #CadetBlue: CalcImageResult()
                loop AngleKey Theta, Phi
                    loop NearField
                        ImageSimulationProcess -> ImageSimulationProcess ++ : InverseFFT();
                        note right #HotPink : Complex[]
                        ImageSimulationProcess --
                    end
                ImageSimulationProcess -> ImageSimulationProcess ++ : HField , CalcResizing()
                note right #HotPink : ex, ey, ez Complex[]
                ImageSimulationProcess --
                ImageSimulationProcess -> ImageSimulationProcess ++ : VField , CalcResizing()
                note right #HotPink : ex, ey, ez Complex[]
                ImageSimulationProcess --
                end
                ImageSimulationProcess --
                ImageSimulationProcess -- 
            return    
        end
    DataManagerOptimizer --
return
@enduml