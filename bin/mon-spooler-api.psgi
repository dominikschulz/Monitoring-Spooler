#!/usr/bin/perl
# ABSTRACT: the monitoring spooler api plack endpoint
# PODNAME: mon-spooler-api.psgi
use strict;
use warnings;

use lib '../lib';

use Monitoring::Spooler::Web::API;

my $Frontend = Monitoring::Spooler::Web::API::->new();
my $app = sub {
    my $env = shift;

    return $Frontend->run($env);
};
