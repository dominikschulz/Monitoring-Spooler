#!/usr/bin/perl
# ABSTRACT: the monitoring spooler api cgi endpoint
# PODNAME: mon-spooler-api.cgi
use strict;
use warnings;

use Plack::Loader;

my $app = Plack::Util::load_psgi('mon-spooler-api.psgi');
Plack::Loader::->auto->run($app);
