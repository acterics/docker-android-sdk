FROM openjdk:8-jdk

LABEL maintainer="lolego1601@gmail.com"
ARG ANDROID_COMPILE_SDK="27"
ARG ANDROID_BUILD_TOOLS="27.0.2"
ARG ANDROID_SDK_TOOLS_CODE="4333796"
ARG CONSTRAINT_LAYOUT_VERSION="1.0.2"
ARG ANDROID_SDK_DIR="android-sdk"

RUN apt-get --quiet update --yes \
 && apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 \
 && wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_CODE}.zip \
 && unzip android-sdk.zip -d ${ANDROID_SDK_DIR} \
 && echo y | android-sdk/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" \
 && echo y | android-sdk/tools/bin/sdkmanager "platform-tools" \
 && echo y | android-sdk/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" \
 && echo y | android-sdk/tools/bin/sdkmanager "extras;android;m2repository" \
 && echo y | android-sdk/tools/bin/sdkmanager "extras;google;google_play_services" \
 && echo y | android-sdk/tools/bin/sdkmanager "extras;google;m2repository" \
 && echo y | android-sdk/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;${CONSTRAINT_LAYOUT_VERSION}" \
 && echo y | android-sdk/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;${CONSTRAINT_LAYOUT_VERSION}" \
 && export ANDROID_HOME=$PWD/$ANDROID_SDK_DIR/ \
 && export PATH=$PATH:$PWD/$ANDROID_SDK_DIR/ \
 && rm -rf /tmp/* 

ENV ANDROID_HOME=$PWD/$ANDROID_SDK_DIR/
