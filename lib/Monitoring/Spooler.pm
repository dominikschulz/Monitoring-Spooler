package Monitoring::Spooler;
# ABSTRACT: Notification queue for Zabbix, Nagios, et.al.
use strict;
use warnings;

1;

__END__

=head1 NAME

Monitoring::Spooler

=head1 CONFIGURATION

<Monitoring>
   <Spooler>
      DBFile = /var/lib/mon-spooler/db.sqlite3
      <Frontend>
         TemplatePath /var/lib/mon-spooler/tpl
      </Frontend>
      <Transport>
         <Smstrade>
            apikey = somekey
            route = basic
         </Smstrade>
         <Sipgate>
            username = someuser
            password = somepass
         </Sipgate>
      </Transport>
   </Spooler>
</Monitoring>

=cut

