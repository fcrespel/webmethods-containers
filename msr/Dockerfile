# Base image
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# Build args
ARG WPM_SAG_SERVER="https://packages.webmethods.io"
ARG WPM_PACKAGES=""
ARG WPM_TOKEN

# Install packages with wpm
RUN if [ -n "$WPM_PACKAGES" -a -n "$WPM_TOKEN" ]; then \
        for WPM_PACKAGE in $WPM_PACKAGES; do \
            ${SAG_HOME}/wpm/bin/wpm install -d ${SAG_HOME}/IntegrationServer -ws ${WPM_SAG_SERVER} -wr ${WPM_PACKAGE%%:*} -j ${WPM_TOKEN} ${WPM_PACKAGE#*:}; \
        done \
    fi

# Add JDBC drivers
RUN chmod ug+w "${SAG_HOME}/IntegrationServer/lib/jars/custom" &&\
    for JAR in \
        "com/microsoft/sqlserver/mssql-jdbc/13.6.1.jre11/mssql-jdbc-13.6.1.jre11.jar" \
        "com/oracle/database/jdbc/ojdbc11/23.26.3.0.0/ojdbc11-23.26.3.0.0.jar" \
        "com/mysql/mysql-connector-j/9.7.0/mysql-connector-j-9.7.0.jar" \
        "org/postgresql/postgresql/42.7.14/postgresql-42.7.14.jar"; do \
        curl -sSLf --retry 5 "https://repo1.maven.org/maven2/${JAR}" -o "${SAG_HOME}/IntegrationServer/lib/jars/custom/$(basename ${JAR})"; \
    done &&\
    chmod ug-w "${SAG_HOME}/IntegrationServer/lib/jars/custom"

# Add Kafka libraries
RUN if [ -e "${SAG_HOME}/IntegrationServer/packages/WmKafkaAdapter" ]; then \
        mkdir -p "${SAG_HOME}/IntegrationServer/packages/WmKafkaAdapter/code/jars/static" &&\
        for JAR in \
            "com/eclipsesource/minimal-json/minimal-json/0.9.5/minimal-json-0.9.5.jar" \
            "com/fasterxml/jackson/dataformat/jackson-dataformat-csv/2.16.0/jackson-dataformat-csv-2.16.0.jar" \
            "com/fasterxml/jackson/datatype/jackson-datatype-jdk8/2.16.0/jackson-datatype-jdk8-2.16.0.jar" \
            "com/github/luben/zstd-jni/1.5.6-4/zstd-jni-1.5.6-4.jar" \
            "com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar" \
            "com/google/errorprone/error_prone_annotations/2.18.0/error_prone_annotations-2.18.0.jar" \
            "com/google/j2objc/j2objc-annotations/2.8/j2objc-annotations-2.8.jar" \
            "com/google/re2j/re2j/1.6/re2j-1.6.jar" \
            "io/confluent/logredactor-metrics/1.0.12/logredactor-metrics-1.0.12.jar" \
            "io/confluent/logredactor/1.0.12/logredactor-1.0.12.jar" \
            "org/apache/avro/avro/1.11.4/avro-1.11.4.jar" \
            "org/apache/commons/commons-compress/1.26.1/commons-compress-1.26.1.jar" \
            "org/checkerframework/checker-qual/3.33.0/checker-qual-3.33.0.jar" \
            "org/glassfish/jersey/core/jersey-client/2.47/jersey-client-2.47.jar" \
            "org/glassfish/jersey/core/jersey-common/2.47/jersey-common-2.47.jar" \
            "org/lz4/lz4-java/1.8.0/lz4-java-1.8.0.jar" \
            "org/xerial/snappy/snappy-java/1.1.10.5/snappy-java-1.1.10.5.jar"; do \
            curl -sSLf --retry 5 "https://repo1.maven.org/maven2/${JAR}" -o "${SAG_HOME}/IntegrationServer/packages/WmKafkaAdapter/code/jars/static/$(basename ${JAR})"; \
        done &&\
        for JAR in \
            "org/apache/kafka/kafka-clients/7.9.4-ccs/kafka-clients-7.9.4-ccs.jar" \
            "io/confluent/common-utils/7.9.4/common-utils-7.9.4.jar" \
            "io/confluent/kafka-avro-serializer/7.9.4/kafka-avro-serializer-7.9.4.jar" \
            "io/confluent/kafka-schema-registry-client/7.9.4/kafka-schema-registry-client-7.9.4.jar" \
            "io/confluent/kafka-schema-serializer/7.9.4/kafka-schema-serializer-7.9.4.jar"; do \
            curl -sSLf --retry 5 "https://packages.confluent.io/maven/${JAR}" -o "${SAG_HOME}/IntegrationServer/packages/WmKafkaAdapter/code/jars/static/$(basename ${JAR})"; \
        done \
    fi

# Add overlay
COPY --chown=1724:1724 IntegrationServer/ ${SAG_HOME}/IntegrationServer/
