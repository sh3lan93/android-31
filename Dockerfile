FROM gradle

RUN apt-get -y update 
RUN apt-get install -y curl
RUN apt-get install -y unzip
RUN apt-get install -y libc6-dev-i386 lib32z1

ENV ANDROID_HOME=/opt/android-sdk
ENV ANDROID_SDK_HOME=$ANDROID_HOME
ENV ANDROID_SDK_ROOT=$ANDROID_HOME
ENV ANDROID_SDK=$ANDROID_HOME

ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/tools/bin
ENV PATH=$PATH:$ANDROID_HOME/tools/bin
ENV PATH=$PATH:$ANDROID_HOME/build-tools/31.0.0
ENV PATH=$PATH:$ANDROID_HOME/platform-tools
ENV PATH=$PATH:$ANDROID_HOME/emulator
ENV PATH=$PATH:$ANDROID_HOME/bin

WORKDIR /opt/android-sdk

RUN curl https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip -o android-commandtools.zip
RUN unzip android-commandtools.zip -d /opt/android-sdk; rm android-commandtools.zip
RUN cd cmdline-tools/; mkdir latest; cp -r `ls -A | grep -v "latest"` latest/
RUN find /opt/android-sdk/cmdline-tools/ -mindepth 1 ! -regex ".*latest.*"  -delete
RUN sdkmanager --update
RUN yes | sdkmanager "platforms;android-31" 
RUN yes | sdkmanager "build-tools;31.0.0" 
RUN yes | sdkmanager "extras;google;m2repository"
RUN yes | sdkmanager "extras;android;m2repository"
RUN yes | sdkmanager --licenses
CMD bash