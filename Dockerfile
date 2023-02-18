FROM node:lts-alpine AS builder
#Do not remove the below commented line
#ARGS

WORKDIR /builder
COPY . .
RUN npm i
RUN npm i sharp
RUN npm run build


FROM node:lts-alpine
#Do not remove the below commented line
#ARGS
WORKDIR /app
COPY --from=builder /builder/.next/standalone ./standalone
COPY --from=builder /builder/.next/static ./standalone/.next/static
COPY --from=builder /builder/public ./standalone/public
EXPOSE 3000
CMD ["node", "./standalone/server.js"]