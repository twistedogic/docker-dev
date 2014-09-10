FROM ruby:1.9.3-p547

RUN apt-get update && apt-get -y install bison \
	libbison-dev \
	libpcap-dev \
	libpcap0.8 \
	libpcap0.8-dev \
	postgresql-client-common

# TODO: Needs bootstrapping of remote/linked database

RUN git clone https://github.com/rapid7/metasploit-framework.git \
	&& cd metasploit-framework \
	&& bundle install

# TODO: Do some setup for dev env
RUN apt-get -y update

RUN echo "deb http://http.kali.org/kali kali main contrib non-free" > /etc/apt/sources.list.d/kali.list && \
echo "deb-src http://http.kali.org/kali kali main contrib non-free" >> /etc/apt/sources.list.d/kali.list && \
echo "deb http://security.kali.org/kali-security kali/updates main contrib non-free" >> /etc/apt/sources.list.d/kali.list && \
echo "deb-src http://security.kali.org/kali-security kali/updates main contrib non-free" >> /etc/apt/sources.list.d/kali.list

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys ED444FF07D8D0BF6
RUN apt-get update
CMD  ["/metasploit-framework/msfconsole"]
