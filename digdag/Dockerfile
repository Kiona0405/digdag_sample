ARG BASE_IMAGE

FROM $BASE_IMAGE

# ENV HTTP_PROXY=http://proxy:3128
# ENV HTTPS_PROXY=http://proxy:3128
# ENV no_proxy=localhost
ENV USER digdag

USER root
RUN yum update -y 
RUN yum install -y \
    java-1.8.0-openjdk-devel \
    git sudo curl gettext \
    postgresql-9.2.24-7.el7_9 \
    postgresql-libs-9.2.24-7.el7_9

# user
RUN useradd -m $USER --shell /bin/bash && \
    echo "$USER ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN    mkdir -p /opt/digdag/plugin/ \
    && mkdir -p /opt/digdag/bin \
    && mkdir -p /opt/digdag/repo \
    && mkdir -p /opt/digdag/config \
    && mkdir -p /opt/digdag/project \
    && mkdir -p /home/$USER/.gradle \
    && chown ${USER}:${USER} -R /opt/digdag \
    && chown ${USER}:${USER} -R /home/$USER/.gradle

# /opt/digdag/plugin/: git repository and build place
# /opt/digdag/bin: digdag command location
# /opt/digdag/repo: build artifacts are copied 
# /opt/digdag/project : project dir. It' mounted by volume

# install digdag
RUN    curl -o /opt/digdag/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
    && chmod +x /opt/digdag/bin/digdag \
    && echo 'export PATH="/opt/digdag/bin:$PATH"' >> /root/.bashrc \
    && echo 'export PATH="/opt/digdag/bin:$PATH"' >> /home/$USER/.bashrc

ENV PATH /opt/digdag/bin:$PATH

USER $USER

# COPY config/gradle.properties /home/$USER/.gradle/gradle.properties
COPY ./script/build_plugin.sh /opt/digdag/bin/build_plugin.sh

# build plugins
RUN /opt/digdag/bin/build_plugin.sh https://github.com/hiroyuki-sato/digdag-plugin-ssh.git
RUN /opt/digdag/bin/build_plugin.sh https://github.com/hiroyuki-sato/digdag-plugin-mysql.git
    
RUN    mkdir -p ~/.ssh \
    && yes | ssh-keygen -m PEM -N "" -P "" -f ~/.ssh/id_rsa \
    && digdag secrets --local --set ssh.private_key=@/home/$USER/.ssh/id_rsa \
    && digdag secrets --local --set ssh.public_key=@/home/$USER/.ssh/id_rsa.pub
# Caution! Because digdag use old java(java 8), we need to generate ssh key with '-m PEM' option,
# so that the generated keys are in old format.

RUN sudo localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"

COPY --chown=$USER /config/server.properties /opt/digdag/config/server.properties
COPY --chown=$USER /script/entrypoint.sh /opt/digdag/bin/entrypoint.sh

ENTRYPOINT \
    /opt/digdag/bin/entrypoint.sh \ 
    /opt/digdag/bin/digdag server \
    --config /opt/digdag/config/server.properties
