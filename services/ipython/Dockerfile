FROM ipython/scipystack

MAINTAINER IPython Project <ipython-dev@scipy.org>

RUN apt-get update -y && apt-get install wget unzip -y
VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

# You can mount your own SSL certs as necessary here
ENV PEM_FILE /key.pem
# $PASSWORD will get `unset` within notebook.sh, turned into an IPython style hash
ENV PASSWORD Dont make this your default

RUN pip2 install zipline
RUN pip3 install zipline
ADD notebook.sh /
RUN chmod u+x /notebook.sh

CMD ["/notebook.sh"]
