#!/usr/bin/env bash

CHROME="google-chrome"

CHROME_DRIVER="chromedriver"
DOWNLOAD_URL="https://chromedriver.storage.googleapis.com"
INSTALL_PATH="/usr/local/bin"

TEMPDIR=$(mktemp -d)

# chrome check
if ! type -a $CHROME > /dev/null 2>&1; then
    echo "Install ${CHROME} package from your distribution"
    exit
fi
CHROME_VERSION=$($CHROME '--version')

# chrome driver check
if ! type -a "${INSTALL_PATH}/${CHROME_DRIVER}" > /dev/null 2>&1; then
    CHROME_DRIVER_VERSION="NOT installed"
else
    CHROME_DRIVER_VERSION=$("${INSTALL_PATH}/${CHROME_DRIVER}" '--version')
fi

# version check
if [ "$(echo "${CHROME_VERSION}" | awk '{print $3}' | awk -F '.' '{print $1 "." $2 "." $3}')" != \
     "$(echo "${CHROME_DRIVER_VERSION}" | awk '{print $2}' | awk -F '.' '{print $1 "." $2 "." $3}')" ]; then
    # driver latest release
    FILE="LATEST_RELEASE"
    URL="${DOWNLOAD_URL}/${FILE}"
    wget $URL -O "${TEMPDIR}/${FILE}"
    LATEST_RELEASE=$(cat "${TEMPDIR}/${FILE}")

    echo "Google Chrome current : ${CHROME_VERSION}"
    echo "Chrome Driver current : ${CHROME_DRIVER_VERSION}"
    echo "Chrome Driver latest release : ${LATEST_RELEASE}"

    # download
    FILE="chromedriver_linux64.zip"
    URL="${DOWNLOAD_URL}/${LATEST_RELEASE}/${FILE}"
    wget $URL -O "${TEMPDIR}/${FILE}"
    unzip -o "${TEMPDIR}/${FILE}" -d "${TEMPDIR}"
    mv "${TEMPDIR}/${CHROME_DRIVER}" $INSTALL_PATH

    echo "Update completed"
else
    echo "Nothing to do"
fi
