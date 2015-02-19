FROM quay.io/cvlibrary/perl:5.20

COPY uwsgi.ini /

RUN wget -q http://projects.unbit.it/downloads/uwsgi-2.0.9.tar.gz         \
 && echo fe0489bca0a8b95653908be2297e35699fb9e992f728e382224587ee6b918295 \
        uwsgi-2.0.9.tar.gz | sha256sum -c --quiet                         \
 && tar xzf uwsgi-2.0.9.tar.gz                                            \
 && cd uwsgi-2.0.9                                                        \
 && cp /uwsgi.ini buildconf/perl.ini                                      \
 && apt-get update                                                        \
 && apt-get -y --no-install-recommends install python                     \
 && rm -fr /var/lib/apt/lists/*                                           \
 && python uwsgiconfig.py --build perl                                    \
 && apt-get -y purge python                                               \
 && apt-get -y --purge autoremove                                         \
 && cd /                                                                  \
 && rm -r uwsgi*
