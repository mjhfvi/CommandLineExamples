\\SERVER\Software\Installations\Jabber\CiscoJabberSetup.msi /qb
cd %PROGRAMFILES(X86)%\Cisco Systems\Cisco Jabber\
ren jabber-config-defaults.xml jabber-config-defaults.xml.old
xcopy \\SERVER\Software\Installations\Jabber\jabber-config-defaults.xml "C:\Program Files (x86)\Cisco Systems\Cisco Jabber"