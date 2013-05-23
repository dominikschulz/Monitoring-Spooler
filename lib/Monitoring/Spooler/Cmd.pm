package Monitoring::Spooler::Cmd;

use 5.010_000;
use mro 'c3';
use feature ':5.10';

use Moose;
use namespace::autoclean;

# use IO::Handle;
# use autodie;
# use MooseX::Params::Validate;
# use Carp;
# use English qw( -no_match_vars );
# use Try::Tiny;

# extends ...
extends 'MooseX::App::Cmd';
# has ...
# with ...
# initializers ...

# your code here ...

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Monitoring::Spooler::Cmd - Command base class.

=head1 SYNOPSIS

    use Monitoring::Spooler::Cmd;
    my $Mod = Monitoring::Spooler::Cmd::->new();

=head1 DESCRIPTION

This class is the base class for any command implemented by its subclasses.

It is a mere requirement by App::Cmd. Don't mess with it.

=cut

