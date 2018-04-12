
FROM nimbix/ubuntu-desktop:trusty
MAINTAINER stephen.fox@nimbix.net

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y make && \ 
    apt-get install -y gfortran && \

    apt-get -y install software-properties-common python-software-properties && \

    wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | apt-key add - && \
    wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list && \
    apt-get update && \
    apt-get install s3cmd 

WORKDIR /home/nimbix
RUN /usr/bin/wget https://s3.amazonaws.com/yb-lab-cfg/admin/yb-admin.NIMBIX.x86_64.tar \
&& tar xvf yb-admin.NIMBIX.x86_64.tar -C /usr/bin \
&& apt-get install -y tcl \
&& apt-get install -y git \
&& apt-add-repository ppa:octave/stable \
&& apt-get update \
&& apt-get install -y octave \
&& apt-get build-dep -y octave \


# Install R + RStudio on Ubuntu 14.04

&& sudo apt-key adv –keyserver keyserver.ubuntu.com –recv-keys E084DAB9 \

# Ubuntu 12.04: precise
# Ubuntu 14.04: trusty
# Ubuntu 16.04: xenial
# Basic format of next line deb https://<my.favorite.cran.mirror>/bin/linux/ubuntu <enter your ubuntu version>/
&& sudo add-apt-repository 'deb https://ftp.ussg.iu.edu/CRAN/bin/linux/ubuntu trusty/' \
&& sudo apt-get update \
&& sudo apt-get install r-base \
&& sudo apt-get install r-base-dev \



&& mkdir -p /opt/images \
&& mkdir -p /opt/icons \
&& apt-get install -y awscli

# Install R + RStudio on Ubuntu 14.04



ADD ./scripts /usr/local/scripts

# Add PushToCompute Work Flow Metadata
ADD ./NAE/nvidia.cfg /etc/NAE/nvidia.cfg
ADD ./NAE/AppDef.json /etc/NAE/AppDef.json
ADD ./NAE/screenshot.png /etc/NAE/screenshot.png
ADD ./Wallpaper-yaybench_1280x720.png /opt/images/Wallpaper.png
ADD ./yaymark_57x57.png /opt/icons/yaybench.png
ADD ./xfce4-desktop.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
ADD ./xfce4-panel.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

CMD /usr/local/scripts/start.sh
CMD /usr/local/scripts/update_drivers.sh
