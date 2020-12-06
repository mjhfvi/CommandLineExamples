cd "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\"
C:
tf workspace /new /s:http://il-air-dev01:8080/tfs/DefaultCollection /noprompt
tf workfold "$/" "D:\SimProjects" /map /collection:http://il-air-dev01:8080/tfs/DefaultCollection /workspace:%computername%