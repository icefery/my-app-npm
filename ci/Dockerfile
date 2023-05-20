FROM --platform=${TARGETPLATFORM} node:18 AS builder
ENV WORKDIR=/my-app
WORKDIR ${WORKDIR}
COPY . .
RUN ["npm", "install", "--production"]

FROM --platform=${TARGETPLATFORM} node:18-alpine AS runtime
ENV WORKDIR=/my-app
WORKDIR ${WORKDIR}
COPY --from=builder ${WORKDIR}/package.json package.json
COPY --from=builder ${WORKDIR}/node_modules/ node_modules/
COPY --from=builder ${WORKDIR}/certs/ certs/
COPY --from=builder ${WORKDIR}/src/ src/
EXPOSE 8080 8443
ENTRYPOINT [ "npm", "run", "start" ]
