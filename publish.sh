#!/usr/bin/env bash
set -ve
cd "$(dirname "$0")"

DOMAIN="blog.sagemath.com"
export DOMAIN

gsutil acl ch -u AllUsers:R gs://${DOMAIN}

# set default acl for any newly created file
gsutil defacl ch -u AllUsers:R gs://${DOMAIN}
# otherwise for each file ...

# upload the files
gsutil rsync -Rd www gs://${DOMAIN}

# cache control, 1 minute, cloudflare should do the rest (in the page rules)
gsutil -m setmeta -r -h "Cache-Control:public, max-age=60" "gs://${DOMAIN}/*"

# set this for html files, and probably also for many other mime types
setmime () {
    gsutil -m setmeta -r -h "Content-Type:$1" "gs://${DOMAIN}/*.$2" || true
}
export -f setmime
setmimep () {
    mime=$1
    shift
    parallel --no-notice --eta -j5 setmime "$mime" {} ::: $*
}

setmime "text/html"   html
setmime "image/png"   png
setmime "image/gif"   gif
setmimep "application/x-gzip" gz gzip

# text/plain
setmimep "text/plain" tex jl ipynb

# application/octet-stream
setmimep "application/octet-stream" sagews

# tell GCS that index.html is the default page and there is a custom 404, too
gsutil web set -m index.html -e 404.html gs://${DOMAIN}
