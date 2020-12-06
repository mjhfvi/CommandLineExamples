:: Clones or pulls a remote git repository
:: If the directory exists and points to the correct remote repository, the script will fetch --all
:: Otherwise, if the directory exists, but either isn't a git repo, or doesn't point to the correct
:: remote, the directory will be deleted and a new copy cloned.

:: Usage:
::     clone.bat <remoteURL> <directoryName>

@echo off

:: Assert that there are two arguments
set haveExactlyTwoArgs=1

if "%2"=="" (set haveExactlyTwoArgs=0)
if NOT "%3"=="" (set haveExactlyTwoArgs=0)

if %haveExactlyTwoArgs%==0 (
	echo clone.bat was not given exacly two parameters.
	echo clone.bat expects the remote URL as the first argument and the directory name as the second
	exit /b 137
	)

set remoteURL=%1
set repoName=%2

:: Check to see target directory exists
IF NOT EXIST %repoName% GOTO Clone

:: Check if the directory is a valid git repo
pushd %2
git rev-parse --git-dir
set badDir=%errorlevel%
if %badDir% == 0 (
:: Get the existing git remote URL to compare to the one from the parameter
	for /f "delims=" %%A in ('git config --get remote.origin.url') do set "existingURL=%%A"
	if "%existingURL%" == "%remoteURL%" (
		echo Git repo already exists. Pulling and reseting to save time.
		git fetch --all
		git pull
		git reset --hard HEAD
		git clean -qfdx 
		popd
		exit /b %errorlevel%
		)
	echo Git repo exists, but has a different remote URL
) else (
	echo Directory exists but is not a valid git repo
)

echo Deleting existing directory
popd
:: Remove existing directory, either because it's not a git repo, or it has the wrong remote URL
rd /s /q %repoName%

: Clone
echo Cloning a fresh copy of the repo
git clone %1 %2
goto eof

: EOF
exit /b %errorlevel%