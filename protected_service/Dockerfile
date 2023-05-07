FROM node:18.16-slim
WORKDIR /srv
COPY yarn.lock package.json ./
RUN yarn
COPY . .
CMD ["yarn", "start"]