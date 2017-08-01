FROM quay.io/cvlibrary/perl:5.26

COPY uwsgi.ini /

RUN apt-get update                                                                               \
 && apt-get -y --no-install-recommends install gcc libc6-dev libpcre3-dev zlib1g-dev python wget \
 && rm -fr /var/lib/apt/lists/*                                                                  \
 && wget -q http://projects.unbit.it/downloads/uwsgi-2.0.15.tar.gz                               \
 && echo 572ef9696b97595b4f44f6198fe8c06e6f4e6351d930d22e5330b071391272ff                        \
    uwsgi-2.0.15.tar.gz | sha256sum -c --quiet                                                   \
 && tar xzf uwsgi-2.0.15.tar.gz                                                                  \
 && cd uwsgi-2.0.15                                                                              \
 && cp /uwsgi.ini buildconf/perl.ini                                                             \
 && python uwsgiconfig.py --build perl                                                           \
 && cd /                                                                                         \
 && rm -r uwsgi*                                                                                 \
 && apt-get -y purge gcc libc6-dev libpcre3-dev zlib1g-dev python wget                           \
 && apt-get -y --purge autoremove
