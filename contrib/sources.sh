#!/bin/bash

set -e

cd deps

curl -L --url https://github.com/martinmoene/gsl-lite/archive/v0.29.0.zip --output GSL.zip
curl -L --url https://github.com/comphack/zlib/archive/comp_hack-20161214.zip --output zlib.zip
curl -L --url https://github.com/comphack/openssl/archive/comp_hack-20171022.zip --output openssl.zip
curl -L --url https://github.com/comphack/mariadb/archive/comp_hack-20170530.zip --output mariadb.zip
curl -L --url https://github.com/comphack/ttvfs/archive/comp_hack-20161214.zip --output ttvfs.zip
curl -L --url https://github.com/comphack/physfs/archive/comp_hack-20170117.zip --output physfs.zip
curl -L --url https://github.com/comphack/sqrat/archive/comp_hack-20170905.zip --output sqrat.zip
curl -L --url https://github.com/comphack/civetweb/archive/comp_hack-20170530.zip --output civetweb.zip
curl -L --url https://github.com/comphack/squirrel3/archive/comp_hack-20161214.zip --output squirrel3.zip
curl -L --url https://github.com/comphack/asio/archive/comp_hack-20161214.zip --output asio.zip
curl -L --url https://github.com/comphack/tinyxml2/archive/comp_hack-20161214.zip --output tinyxml2.zip
curl -L --url https://github.com/comphack/googletest/archive/comp_hack-20161214.zip --output googletest.zip
curl -L --url https://github.com/comphack/JsonBox/archive/comp_hack-20170610.zip --output JsonBox.zip
