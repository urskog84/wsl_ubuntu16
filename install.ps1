
$distname = "Ubuntu16"
$tarfile = $distname + ".tar.gz"
$tarpath = "C:\Temp\" + $tarfile
$wsltarget = "C:\WSL\" + $distname

#WSL2 https://docs.microsoft.com/en-us/windows/wsl/install-win10

if ( [System.Environment]::OSVersion.Version.Build -eq 19041 ) {
    Write-Host  "WSL 2 can be installed"
    wsl --set-default-version 2
}
else {
    Write-Host "stick to WSL version 1"
    Write-Host "You have to run Windows 10, version 2004, Build 19041 or highe"
    Write-Host "read more on https://docs.microsoft.com/en-us/windows/wsl/install-win10"
}


try {
    choco install lxrunoffline -y
} 
catch {
    Write-Error -Message "chcolety is not install"
    brake
}

try {
    Test-Path -Path C:\Temp
}
catch {
    Write-Error -Message "C:\Temp dose not exist"
    brake
}
if (-Not (Test-Path -Path $tarpath)) {
    Invoke-WebRequest -Uri 'https://lxrunoffline.apphb.com/download/UbuntuFromMS/16' -OutFile $tarpath
}



if (-not (Test-Path -Path $wsltarget)) {
    LxRunOffline i -n $distname -d "c:\WSL\"+$distname -f $tarpath
}

wsl -e lsb_release -a
wsl -e apt-get update -y
wsl -e apt install python3-pip
wsl -e pip3 install -r requirements.txt


# Docker-ce install in WSL2
#
wsl -e apt install -y --no-install-recommends install apt-transport-https ca-certificates curl software-properties-common
wsl -e curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
#$lsb_release = wsl -e lsb_release -cs
wsl -e add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu (lsb_release -cs) stable"
wsl -e apt update
wsl -e apt-cache policy docker-ce
wsl -e apt install -y docker-ce

wsl -e docker --version
wsl -e servce docker enable
wsl -e service docker start 
wsl -e docker run hello-world