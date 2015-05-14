FROM quay.io/cvlibrary/perl:5.20

COPY uwsgi.ini /

RUN apt-get update                                                                               \
 && apt-get -y --no-install-recommends install gcc libc6-dev libpcre3-dev zlib1g-dev python wget \
 && rm -fr /var/lib/apt/lists/*                                                                  \
 && wget -q http://projects.unbit.it/downloads/uwsgi-2.0.10.tar.gz                               \
 && echo c0b381d6c22da931e85e3efe612629fe33a01ac25b0f028aa631b85d86d5028b                        \
    uwsgi-2.0.10.tar.gz | sha256sum -c --quiet                                                   \
 && tar xzf uwsgi-2.0.10.tar.gz                                                                  \
 && cd uwsgi-2.0.10                                                                              \
 && cp /uwsgi.ini buildconf/perl.ini                                                             \
 && python uwsgiconfig.py --build perl                                                           \
 && cd /                                                                                         \
 && rm -r uwsgi*                                                                                 \
 && apt-get -y purge gcc libc6-dev libpcre3-dev zlib1g-dev python wget                           \
 && apt-get -y --purge autoremove
