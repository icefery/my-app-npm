FROM --platform=${TARGETPLATFORM} node:lts AS build
ENV WORKDIR=/app
WORKDIR ${WORKDIR}
COPY . .
RUN ["npm", "install", "--production"]

FROM --platform=${TARGETPLATFORM} node:lts-alpine
ENV WORKDIR=/app
WORKDIR ${WORKDIR}
COPY --from=build ${WORKDIR}/package.json ${WORKDIR}/package.json
COPY --from=build ${WORKDIR}/node_modules ${WORKDIR}/node_modules
COPY --from=build ${WORKDIR}/certs ${WORKDIR}/certs
COPY --from=build ${WORKDIR}/index.js ${WORKDIR}/index.js
EXPOSE 8080
EXPOSE 8443
CMD ["npm", "run", "start"]