package Monitoring::Spooler::Cmd::Command::bootstrap;
# ABSTRACT: initializes a new installation

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
use Try::Tiny;

# extends ...
extends 'Monitoring::Spooler::Cmd::Command';
# has ...
has 'name' => (
    'is'    => 'ro',
    'isa'   => 'Str',
    'required' => 1,
    'traits' => [qw(Getopt)],
    'cmd_aliases' => 'n',
    'documentation' => 'Name of the new group',
);
# with ...
# initializers ...

# your code here ...
=method execute

Initializ a new installation

=cut
sub execute {
    my $self = shift;

    my $sql = 'SELECT COUNT(*) FROM groups';
    my $sth = $self->dbh()->prepexec($sql);
    my $cnt = $sth->fetchrow_array();

    if($cnt > 0) {
        print "You can not use this command once there is already at least one group\n";
        return;
    }

    $sql = 'INSERT INTO groups (name) VALUES (?)';
    $sth = $self->dbh()->prepexec($sql,$self->name());
    if($sth) {
      my $id = $self->dbh()->last_insert_id(undef, undef, undef, undef);
        print "Created new group '".$self->name()."' with Id $id\n";
    }

    return 1;
}

sub abstract {
    return "Initialize the database.";
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Monitoring::Spooler::Cmd::Command::bootstrap - Command to initialize the DB.

=head1 DESCRIPTION

This class implements a command to add initialize the database.

This command is usually only needed once after the inital setup.
All the boilerplate work is done by MooseX::App::Cmd.

=cut
