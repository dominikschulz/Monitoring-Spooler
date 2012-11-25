#!/usr/bin/perl
# ABSTRACT: the monitoring spooler frontend plack endpoint
# PODNAME: mon-spooler.cgi
use strict;
use warnings;

use lib '../lib';

use Plack::Builder;
use File::ShareDir;
use Monitoring::Spooler::Web::Frontend;

my $Frontend = Monitoring::Spooler::Web::Frontend::->new();
my $app = sub {
    my $env = shift;

    return $Frontend->run($env);
};

my $static_path = $Frontend->config()->get('Monitoring::Spooler::Frontend::StaticPath');
if(!-d $static_path) {
    my $dist_dir = File::ShareDir::dist_dir('Monitoring-Spooler');
    $static_path = $dist_dir.'/res';
}

builder {
    enable 'Plack::Middleware::Static',
        path => qr{^/(images|js|css)/}, root => $static_path;
    $app;
};
