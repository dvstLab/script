LATEST_VERSION=$(curl --silent "https://github.com/porjo/youtubeuploader/releases/latest" | sed "s#.*tag/\(.*\)\".*#\1#")
[[ -f ".version" ]] && CURRENT_VERSION=$(cat .version)

if [[ -n "${CURRENT_VERSION}" ]] || [[ "${CURRENT_VERSION}" != "${LATEST_VERSION}" ]]; then
    rm -f youtubeuploader_linux_amd64
    curl --silent -L -o youtubeuploader_linux_amd64.tar.gz "https://github.com/porjo/youtubeuploader/releases/download/${LATEST_VERSION}/youtubeuploader_linux_amd64.tar.gz"
    tar -xzf youtubeuploader_linux_amd64.tar.gz
    rm -f youtubeuploader_linux_amd64.tar.gz
    mv -f youtubeuploader_linux_amd64 ytup
    echo ${CURRENT_VERSION} > .version
fi
