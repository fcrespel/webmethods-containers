# webMethods Edge Runtime base image
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# Install packages with wpm
ARG WPM_TOKEN
RUN wpm install -d ${SAG_HOME}/IntegrationServer -ws ${WPM_SAG_SERVER} -wr supported -j ${WPM_TOKEN} WmFlatFile &&\
    wpm install -d ${SAG_HOME}/IntegrationServer -ws ${WPM_SAG_SERVER} -wr supported -j ${WPM_TOKEN} WmStreaming &&\
    wpm install -d ${SAG_HOME}/IntegrationServer -ws ${WPM_SAG_SERVER} -wr licensed -j ${WPM_TOKEN} WmJDBCAdapter
