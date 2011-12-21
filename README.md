# Tukia Controlled Vocabulary Management System

Copyright (C) 2006-2007, Infoman Inc.

Written by Andrew Clunis <andrew@orospakr.ca>

From requirements and support from:

* Jake Knoppers <mpereira@istar.ca>
* David Clemis <davidclemis@rogers.com>

Originally designed for use in ISO/IEC JTC1 subcommittees and in other
standards bodies.  Manages a registry of multi-lingual equivalents of
various normative term definitions.  Basically a fancy dictionary app
for standards wonks.

I wrote it at Infoman Inc. in 2006, and it was my first Rails app.  I
tried my best to come up with abstractions that dealt with the
complexities of the ISO workflows.  The original "database" was a
big-ass WordPerfect 5.1 file containing a gigantic table. D:

Probably still wants Rails 1.x.  It'll need to be upgraded.

Several other included components, such as the adapted "Focus" theme
by John Serris and the Globalize module are copyrighted and licensed
by their respective owners.

## Known Issues (at least, as of when I last worked on this in '07...)

- replacement of the database without deleting all of the sessions can cause
  the server to spin forever when restarted. I'm not sure why this is.
- make sure that the web server, be it lightty, mongrel or apache, make sure that
  it returns the correct MIME type for XML files.  Just returning the file with
  any old MIME type isn't enough, or very strange things will happen on browsers
  that aren't IE6 (IE7, Opera and Gecko all break).
