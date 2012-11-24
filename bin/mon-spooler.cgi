#!/usr/bin/perl
# ABSTRACT: the monitoring spooler frontend cgi endpoint
# PODNAME: mon-spooler.cgi
use strict;
use warnings;

use Plack::Loader;

my $app = Plack::Util::load_psgi('mon-spooler.psgi');
Plack::Loader::->auto->run($app);
