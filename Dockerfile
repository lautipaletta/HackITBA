FROM node:18.15 as base

WORKDIR /smartContract

COPY smartContracts/ .

RUN npm install --global --quiet npm truffle ganache

FROM base as truffle

RUN truffle version

WORKDIR /backEnd

COPY back-end/ .

RUN npm install

EXPOSE 3000

CMD [ "npm", "start" ]

FROM base as ganache

EXPOSE 8545

ENTRYPOINT ["ganache-cli"]

