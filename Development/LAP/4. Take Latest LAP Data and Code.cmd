cd "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\"
C:
tf workspace /new /s:http://il-air-dev01:8080/tfs/DefaultCollection /noprompt
tf workfold "$/" "D:\SimProjects" /map /collection:http://il-air-dev01:8080/tfs/DefaultCollection /workspace:%computername%

cd "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\"
c:
TF.exe get $/BasicStuff D:\SimProjects\BasicStuff /recursive /force
TF.exe get $/FlashDX D:\SimProjects\FlashDX /recursive /force
TF.exe get $/GPGPU D:\SimProjects\GPGPU /recursive /force
REM TF.exe get $/Hardware D:\SimProjects\Hardware /recursive /force
REM TF.exe get $/"LAP hardware installation" D:\SimProjects\HW configuration /recursive /force
TF.exe get $/PropertyPages D:\SimProjects\PropertyPages /recursive /force
TF.exe get $/RenderContexts D:\SimProjects\RenderContexts /recursive /force
TF.exe get $/Renderer_DX9 D:\SimProjects\Renderer_DX9 /recursive /force
TF.exe get $/SimDynamicExtensions D:\SimProjects\SimDynamicExtensions /recursive /force
TF.exe get $/SimEngCommon D:\SimProjects\SimEngCommon /recursive /force
TF.exe get $/Sim-Engine D:\SimProjects\Sim-Engine /recursive /force
TF.exe get $/TargetsManager D:\SimProjects\TargetsManager /recursive /force
TF.exe get $/UltraSound_Lib D:\SimProjects\UltraSound_Lib /recursive /force

D:\SimProjects\Sim-Engine\sim_engine_get.bat
D:\SimProjects\Sim-Engine\SMB_VS2015.bat
REM ##Copy SimEditor reflection from main branch to desktop � create a shortcut from:
D:\SimProjects\BasicStuff\ReflectionSystem\Applications\SimEditor\bin\Release\SimEditor.exe

TF.exe get $/"LAP Chole"/LapMentor-BeforeFaceLiftBranch/Cases/Practice0001 D:\SimProjects\LAP\Data\Practice0001 /recursive /force
TF.exe get $/"LAP Chole"/LapMentor/Cases/Practice0002 D:\SimProjects\LAP\Data\Practice0002 /recursive /force
TF.exe get $/"LAP Chole"/LapMentor/Cases/Module0001 D:\SimProjects\LAP\Data\Module0001 /recursive /force
TF.exe get $/"LAP Chole" D:\SimProjects\LAP\Solutions\LapChole /recursive /force

TF.exe get $/SuturingLapVS2010/Practice0003 D:\SimProjects\LAP\Data\Practice0003
TF.exe get $/SuturingLapVS2010/Practice0004 D:\SimProjects\LAP\Data\Practice0004
TF.exe get $/SuturingLapVS2010 D:\SimProjects\LAP\Solutions\Suturing

TF.exe get $/Gastric/Module0002 D:\SimProjects\LAP\Data\Module0002 /recursive /force
TF.exe get $/Gastric D:\SimProjects\LAP\Solutions\Gastric /recursive /force

TF.exe get $/"Ventral Hernia"/Module0003 D:\SimProjects\LAP\Data\Module0003 /recursive /force
TF.exe get $/"Ventral Hernia" D:\SimProjects\LAP\Solutions\Hernia /recursive /force

TF.exe get $/SimEngine_Sig/Module0004: D:\SimProjects\LAP\Data\Module0004 /recursive /force
TF.exe get $/SimEngine_Sig: D:\SimProjects\LAP\Solutions\Sigmoidectomy /recursive /force

TF.exe get $/"Sim-Engine Gyn"/Module0005: D:\SimProjects\LAP\Data\Module0005 /recursive /force
TF.exe get $/"Sim-Engine Gyn": D:\SimProjects\LAP\Solutions\Gynecology /recursive /force

TF.exe get $/SimEngine_LET/Practice0005: D:\SimProjects\LAP\Data\Practice0005 /recursive /force
TF.exe get $/SimEngine_LET: D:\SimProjects\LAP\Solutions\SimEngine LET /recursive /force

TF.exe get $/Nephrectomy/Solution/Module0006: D:\SimProjects\LAP\Data\Module0006 /recursive /force
TF.exe get $/Nephrectomy: D:\SimProjects\LAP\Solutions\Nephrectomy /recursive /force

TF.exe get $/Hysterectomy/New_Solution/Module0008 D:\SimProjects\LAP\Data\Module0008 /recursive /force
TF.exe get $/Hysterectomy/New_Solution D:\SimProjects\LAP\Solutions\Hysterectomy /recursive /force

TF.exe get $/Appendectomy/2_0_0_0_with_patches/Module0009 D:\SimProjects\LAP\Data\Module0009 /recursive /force
TF.exe get $/Appendectomy/2_0_0_0_with_patches D:\SimProjects\LAP\Solutions\Appendectomy /recursive /force

TF.exe get $/DaVince_Branch/Cases/CuffClosureLAP D:\SimProjects\LAP\Data\Module0010 /recursive /force
TF.exe get $/"LAP Cuff Closure"/Solution D:\SimProjects\LAP\Solutions\CuffClosure /recursive /force

TF.exe get $/"LAP Legacy Projects"/Cholangiogram/Practice0006 D:\SimProjects\LAP\Data\Practice0006 /recursive /force
TF.exe get $/"LAP Legacy Projects"/"Thoracic Lobectomy"/"New Solution"/Module0011 D:\SimProjects\LAP\Data\Module0011 /recursive /force
TF.exe get $/"LAP Legacy Projects"/"Inguinal Hernia"/Module0012 D:\SimProjects\LAP\Data\Module0012 /recursive /force
TF.exe get $/"LAP Legacy Projects"/MyomaSuturing/Module0019 D:\SimProjects\LAP\Data\Module0019 /recursive /force
TF.exe get $/"LAP Legacy Projects" D:\SimProjects\LAP\Solutions\"LAP Legacy Projects" /recursive /force 
 
pause