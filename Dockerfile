FROM golang as build

WORKDIR /go/src/app
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

FROM gcr.io/distroless/base
COPY --from=build /go/bin/app /
COPY --from=build /go/src/app/tmpl /tmpl
COPY --from=build /go/src/app/data /data
CMD ["/app"]
