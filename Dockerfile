FROM python:3.6

# Nano
RUN apt-get update && apt-get install -y nano
ENV TERM xterm

# Pillow, GIT and pngquant
RUN apt-get update && apt-get install -y libjpeg-dev git pngquant

# Mono
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main"| tee /etc/apt/sources.list.d/mono-xamarin.list
RUN echo "deb http://download.mono-project.com/repo/debian wheezy-apache24-compat main" | tee -a /etc/apt/sources.list.d/mono-xamarin.list
RUN echo "deb http://download.mono-project.com/repo/debian wheezy-libjpeg62-compat main" | tee -a /etc/apt/sources.list.d/mono-xamarin.list
RUN apt-get update && apt-get install -y mono-complete

# IronPython
WORKDIR /usr/src/ironpython
RUN git clone git://github.com/markdoggen/main.git IronLanguages
WORKDIR IronLanguages
RUN apt-get update && apt-get install -y make
RUN make ironpython-release
ENV IRONPYTHONPATH=/usr/src/ironpython/IronLanguages/External.LCA_RESTRICTED/Languages/IronPython/27/Lib:$IRONPYTHONPATH

# GoAccess and lxml
RUN apt-get update && apt-get install -y goaccess=1:0.8.3-1 libxml2-dev libxslt1-dev

# cURL, wget, Varnish and Redis tools
RUN apt-get update && apt-get install -y curl wget varnish redis-tools

WORKDIR /app

EXPOSE 8000

CMD ["/sbin/init"]
