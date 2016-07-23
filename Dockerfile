FROM debian:jessie

ENV DF_VERSION 43_03
ENV DFHACK_VERSION 43.03-r1

ADD .launch.sh /run.sh
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        libsdl-image1.2:i386 \
        libsdl-ttf2.0-0:i386 \
        libgtk2.0-0:i386 \
        libjpeg62-turbo:i386 \
        libglu1-mesa:i386 \
        libopenal1:i386 \
        ca-certificates \
        bzip2 \
        wget && \
    apt-get autoremove -y && \
    apt-get clean -y && \
# Add Dwarf Fortress
	wget -O df.tar.bz2 http://www.bay12games.com/dwarves/df_${DF_VERSION}_linux.tar.bz2 && \
    tar xvf df.tar.bz2 && \
    rm df.tar.bz2 && \
    rm /df_linux/libs/libgcc_s.so.1 /df_linux/libs/libstdc++.so.6 &&\
    chmod -x+X -R /df_linux && \
    chmod +x /df_linux/df /df_linux/libs/Dwarf_Fortress && \
    mkdir -p /df_linux/data/{save,movies} && \
# Add DFHack
	cd /df_linux && \
	wget -O dfhack.tar.bz2 https://github.com/DFHack/dfhack/releases/download/0.${DFHACK_VERSION}/dfhack-0.${DFHACK_VERSION}-Linux-gcc-4.8.1.tar.bz2 && \
    tar xvf dfhack.tar.bz2 && \
    rm -f dfhack.tar.bz2 && \
# Add launcher script
    mv /run.sh /df_linux/run.sh && \
# Prepare data-folders
	touch dfhack.init && \
	mv data data_real && \
	mv hack/scripts hack/scripts_real

WORKDIR /df_linux
VOLUME /df_linux/data
VOLUME /df_linux/hack/scripts

CMD ["./run.sh"]
