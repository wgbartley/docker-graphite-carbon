FROM localhost:5000/ubuntu-minimal

RUN apt-get -y update
RUN apt-get -y install python-dev python-flup python-pip expect git memcached sqlite3 libcairo2 libcairo2-dev python-cairo pkg-config supervisor

# python dependencies
RUN pip install \
	django==1.3 \
	python-memcached==1.53 \
	django-tagging==0.3.1 \
	whisper==0.9.12 \
	twisted==11.1.0 \
	txAMQP==0.6.2


# logging support
VOLUME ["/storage"]
RUN mkdir -p \
	/var/log/carbon \
	/var/log/graphite \
	/var/log/supervisor \
	/storage/graphite


# install graphite
RUN git clone -b 0.9.12 https://github.com/graphite-project/graphite-web.git /usr/local/src/graphite-web
ADD scripts/local_settings.py /opt/graphite/webapp/graphite/local_settings.py
COPY conf/ /opt/graphite/conf/


# install whisper
RUN git clone -b 0.9.12 https://github.com/graphite-project/whisper.git /usr/local/src/whisper


# install carbon
RUN git clone -b 0.9.12 https://github.com/graphite-project/carbon.git /usr/local/src/carbon


# init django admin
ADD scripts/django_admin_init.exp /usr/local/bin/django_admin_init.exp


# daemons
ADD scripts/carbon.conf /etc/supervisor/conf.d/carbon.conf
ADD scripts/graphite.conf /etc/supervisor/conf.d/graphite.conf
ADD scripts/start.sh /start.sh

RUN chmod +x /start.sh


# defaults
EXPOSE 80 2003

WORKDIR /
ENV HOME /root

ADD scripts/.firstboot /.firstboot

CMD ["/start.sh"]
