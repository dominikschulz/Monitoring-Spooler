package Monitoring::Spooler::Web;
# ABSTRACT: baseclass for any webinterface

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
use Plack::Request;

use Config::Yak;
use Log::Tree;
use Monitoring::Spooler::DB;

# extends ...
# has ...
=attr dbh

The Database connection. Must be an instance of
Monitoring::Spooler::DB.

=cut
has 'dbh' => (
    'is'      => 'ro',
    'isa'     => 'Monitoring::Spooler::DB',
    'lazy'    => 1,
    'builder' => '_init_dbh',
);

=attr config

The config object. Must be an instance of
Config::Yak.

=cut
has 'config' => (
    'is'      => 'ro',
    'isa'     => 'Config::Yak',
    'lazy'    => 1,
    'builder' => '_init_config',
);

=attr logger

The logger object. Must be an instance of
Log::Tree.

=cut
has 'logger' => (
    'is'      => 'ro',
    'isa'     => 'Log::Tree',
    'lazy'    => 1,
    'builder' => '_init_logger',
);

has '_fields' => (
    'is'        => 'ro',
    'isa'       => 'ArrayRef',
    'lazy'      => 1,
    'builder'   => '_init_fields',
);
# with ...
# initializers ...
sub _init_dbh {
    my $self = shift;

    my $DBH = Monitoring::Spooler::DB::->new({
        'config'        => $self->config(),
        'logger'        => $self->logger(),
    });

    return $DBH;
}

sub _init_fields {
    return [];
}

sub _init_config {
    my $self = shift;

    my $Config = Config::Yak::->new({
        'locations'     => [qw(conf /etc/mon-spooler)],
    });

    return $Config;
}

sub _init_logger {
    my $self = shift;

    my $Logger = Log::Tree::->new('mon-spooler-web');

    return $Logger;
}

# your code here ...
sub run {
    my $self = shift;
    my $env = shift;

    my $plack_request = Plack::Request::->new($env);
    my $request = $self->_filter_params($plack_request);

    # log request and ip
    $self->_log_request($request);

    return $self->_handle_request($request);
}

sub _filter_params {
    my $self = shift;
    my $request = shift;

    my $params = $request->parameters();

    my $request_ref = {};
    foreach my $key (@{$self->_fields()}) {
        if (defined($params->{$key})) {
            $request_ref->{$key} = $params->{$key};
        }
    }

    # add the remote_addr
    $request_ref->{'remote_addr'} = $request->address();

    return $request_ref;
}

sub _handle_request {
    my $self = shift;
    my $request = shift;
    # this _must_ be implemented by subclasses

    return [
        500,
        [],
        ['Not implemented'],
    ];
}

sub _log_request {
    my $self = shift;
    my $request_ref = shift;

    my $remote_addr = $request_ref->{'remote_addr'};
    # turn key => value pairs into smth. like key1=value1,key2=value2,...
    my $args = join(',', map { $_.'='.$request_ref->{$_} } keys %{$request_ref});

    $self->logger()->log( message => 'New Request from '.$remote_addr.'. Args: '.$args, level => 'debug', );

    return 1;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Monitoring::Spooler::Web - baseclass for any webinterface

=cut
