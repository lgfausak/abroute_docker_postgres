#!/usr/bin/env python2

import web
from subprocess import call

urls = (
        "/(dbinit.*)", "dbinit"
    )


class dbinit:
    def GET(self, path):
        rv = call("abinit")
        return rv

class index:
    def GET(self, path):
        return 'Hello ' + path

app = web.application(urls, globals())

if __name__ == "__main__":
    app.run()
