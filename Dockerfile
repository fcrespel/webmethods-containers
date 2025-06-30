# Base image
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# Build args
ARG WPM_TOKEN
ARG WPM_SAG_SERVER=https://packages.webmethods.io

# Install packages with wpm
RUN ${SAG_HOME}/wpm/bin/wpm install -d ${SAG_HOME}/IntegrationServer -ws ${WPM_SAG_SERVER} -wr supported -j ${WPM_TOKEN} WmGoogleCloudStorageProvider &&\
    ${SAG_HOME}/wpm/bin/wpm install -d ${SAG_HOME}/IntegrationServer -ws ${WPM_SAG_SERVER} -wr supported -j ${WPM_TOKEN} WmStreaming &&\
    ${SAG_HOME}/wpm/bin/wpm install -d ${SAG_HOME}/IntegrationServer -ws ${WPM_SAG_SERVER} -wr licensed -j ${WPM_TOKEN} WmCloudStreams &&\
    ${SAG_HOME}/wpm/bin/wpm install -d ${SAG_HOME}/IntegrationServer -ws ${WPM_SAG_SERVER} -wr licensed -j ${WPM_TOKEN} WmKafkaAdapter &&\
    ${SAG_HOME}/wpm/bin/wpm install -d ${SAG_HOME}/IntegrationServer -ws ${WPM_SAG_SERVER} -wr licensed -j ${WPM_TOKEN} WmJDBCAdapter &&\
    ${SAG_HOME}/wpm/bin/wpm install -d ${SAG_HOME}/IntegrationServer -ws ${WPM_SAG_SERVER} -wr licensed -j ${WPM_TOKEN} WmSAP
