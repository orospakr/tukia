#!/bin/sh

mongrel_rails stop
mongrel_rails start -d -e production -m mongrel_mime_types.yml
