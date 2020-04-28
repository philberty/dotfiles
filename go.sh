#!/usr/bin/env bash
set -ex

go get -u golang.org/x/tools/cmd/...
go get -u github.com/rogpeppe/godef/...
go get -u github.com/nsf/gocode
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/guru
go get -u github.com/dougm/goflymake
go get -u github.com/davidrjenni/reftools/cmd/fillstruct
go get -u golang.org/x/tools/gopls@latest
