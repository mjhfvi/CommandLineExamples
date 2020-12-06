mkdir "C:\Program Files\HP\HP Image Assistant\"
copy "\\SERVER\Software\Drivers\HP\HP Image Assistant\" "C:\Program Files\HP\HP Image Assistant\"

mklink /H %UserProfile%\Desktop\HPImageAssistant.exe "C:\Program Files\HP\HP Image Assistant\HPImageAssistant.exe"


