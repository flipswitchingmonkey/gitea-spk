#!/bin/bash
GITEA_INSTALLED=`/volume1/@appstore/Gitea/gitea/gitea --version | cut -d \  -f 3`

LATEST_URL=`curl -Ls -o /dev/null -w %{url_effective} https://github.com/go-gitea/gitea/releases/latest`
#https://github.com/go-gitea/gitea/releases/tag/v1.11.3

echo LATEST_URL = ${LATEST_URL}
GITEA_VERSION=${LATEST_URL##*/v}

if [ "${GITEA_INSTALLED}" == "${GITEA_VERSION}" ]; then
    echo "Same version"
    exit 0
fi

#Install
echo "Installed:"${GITEA_INSTALLED}
echo "LATEST:"${GITEA_VERSION}
rm -rf /tmp/gitea
mkdir /tmp/gitea
cd /tmp/gitea
git clone https://github.com/flipswitchingmonkey/gitea-spk.git
cd gitea-spk

DOWNLOAD_URL=https://github.com/go-gitea/gitea/releases/download/v${GITEA_VERSION}/gitea-${GITEA_VERSION}-linux-arm64.xz
echo ${DOWNLOAD_URL}

wget ${DOWNLOAD_URL}
xz --decompress gitea-*.xz
./create_spk.sh


sudo synoservice --stop  pkgctl-Gitea
sudo synoservice --status  pkgctl-Gitea
sudo synopkg install /tmp/gitea/gitea-spk/gitea-${GITEA_VERSION}-linux-arm64.spk
sudo synoservice --start  pkgctl-Gitea

exit 1
