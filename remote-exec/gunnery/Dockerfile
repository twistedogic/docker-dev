FROM ubuntu:precise
RUN apt-get update && apt-get install --assume-yes python-software-properties curl wget git supervisor
RUN git clone --recurse-submodules https://github.com/Eyjafjallajokull/gunnery.git /var/gunnery
RUN cd /var/gunnery/puppet && bash ./install.sh
RUN FACTER_environment=production puppet apply manifests/base.pp --hiera_config manifests/hiera.yaml --modulepath=modules
ADD ./production.py /var/gunnery/gunnery/gunnery/settings/production.py
RUN cd /var/gunnery/gunnery && \ 
	export DJANGO_SETTINGS_MODULE="gunnery.settings.production" && \ 
	source /var/gunnery/virtualenv/production/bin/activate && \ 
	python manage.py syncdb && \ 
	python manage.py migrate && \ 
	python manage.py createsuperuser --username=twistedogic@gmail.com --password=admin && \ 
	python manage.py collectstatic --noinput

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]