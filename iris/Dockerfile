ARG IMAGE=store/intersystems/iris-community:2020.3.0.221.0
FROM ${IMAGE}

USER root

ENV SRC_DIR=/home/irisowner

COPY --chown=irisowner ./src/ $SRC_DIR/iriscode

USER irisowner

RUN iris start $ISC_PACKAGE_INSTANCENAME && \
    /bin/echo -e " do \$system.OBJ.Load(\"/home/irisowner/iriscode/Installer.cls\",\"ck\")\n" \
            " set sc = ##class(abc.Installer).Setup(, 3)\n" \
            " halt" \
    | iris session $ISC_PACKAGE_INSTANCENAME && \
 iris stop $ISC_PACKAGE_INSTANCENAME quietly \
  && rm -rf $SRC_DIR/iriscode

HEALTHCHECK --interval=5s CMD /irisHealth.sh || exit 1
