FROM continuumio/miniconda3

# File Author / Maintainer
MAINTAINER Palladium 

# copy palladium 
RUN git clone https://github.com/ottogroup/palladium.git /root/palladium

RUN   conda config --add channels https://conda.binstar.org/asmeurer \
      && conda config --add channels https://conda.binstar.org/menpo \
      && conda config --set ssl_verify false   # please deactivate if not needed

RUN conda install --yes --file /root/palladium/requirements.txt
   
# Install palladium
RUN cd root/palladium && python setup.py install
