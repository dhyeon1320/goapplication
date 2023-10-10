FROM golang:1.13-alpine as builder

RUN apk update && apk add git

WORKDIR /usr/src/app
COPY main.go .

# 디렉토리 안 go 파일 build해서 main 바이너리 파일을 현재 directory에 생성
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

# 다단계 build
FROM scratch

# builder 에서 /usr/src/app directory 내용을 guswo directory로 복사
COPY --from=builder /usr/src/app .
# main 실행
CMD ["/main"]