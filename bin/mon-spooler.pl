#!/usr/bin/perl
# ABSTRACT: the monitoring spooler cli
# PODNAME: mon-spooler.pl
use strict;
use warnings;

use Monitoring::Spooler::Cmd;

# All the magic is done using MooseX::App::Cmd, App::Cmd and MooseX::Getopt
my $MonSpooler = Monitoring::Spooler::Cmd::->new();
$MonSpooler->run();
