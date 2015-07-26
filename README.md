# perltest
CPAN Smoke Testing Scripts

Documentation is badly missing from this - this is my
personal scripts to do CPAN smoke testing, so there is not
a lot of notes yet.

Before you start this, you must configure your CPAN client
to be able to report, and also configure your metabase
config files.

To start these, put the bin directory in your path, create a 
config file in config with a name matching the FQDN of your
host (see sample.example.com for an example), and install
Perlbrew and the relevent versions of Perl you want to test.

Then use pt_watchdog.sh to start things.

Use pt_session_list.sh to list sessions.

Use pt_console.sh and pt_console_all.sh to connect to the
screen sessions running the testing.

Use pt_kill_all.sh to stop things.

