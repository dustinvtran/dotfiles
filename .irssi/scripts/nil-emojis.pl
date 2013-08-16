# Just changed the default values line. I added a few hundred emojis, all of which are taken from Shou's text_replace.py for weechat (see github) on 8/16/13.

use strict;
use vars qw($VERSION %IRSSI);

use Irssi;

$VERSION = '1.22';

%IRSSI = (
    authors     => 'Alexandre Gauthier',
    contact     => 'alex@underwares.org',
    name        => 'Knifa-mode for irssi',
    description => 'This script pretty much allows you spam ' .
                   'horrible japanese smileys. Use at your own ' .
                   'risk.',
    license     => 'Public Domain',
    url         => 'https://github.com/mrdaemon/irssi-emojis',
);

# Default values
my $default_emojis_file = Irssi::get_irssi_dir() . "/emojis-weeaboos.dat";

# internal structures and variables
my %EMOJIS = ();
my $locked = 0;

# void load_emojis()
# Load the emojis from the file specified in the 'knifamode_dbfile'
# setting in the irssi configuration. Format is trigger on a line, emoji
# on the following one, repeat until end of file.
sub load_emojis {
    my $dbfile = Irssi::settings_get_str('knifamode_dbfile');

    if ( -e $dbfile && -r $dbfile) {
        open my $fh, '<', $dbfile or die "Unable to read $dbfile: $!";

        while(<$fh>) {
            chomp;
            my $line = $_;
            my $nextline;

            # Horrible sanity check, ensure line starts with
            # a colon. Once validated, assume the next line is the emoji text.
            if ($line =~ m/^:/) {
                $nextline = <$fh>;
                chomp($nextline);
                $EMOJIS{$line} = $nextline; # Add key/value to hash
            } else {
                Irssi::print("Malformed line in emoji db: $line. Skipping.");
            }

        }
    } else {
        Irssi::print("emojis.pl: No such file, or acces denied: $dbfile");
    }
}

# void reload_emojis()
# Reloads the emojis database from file
sub reload_emojis {
    %EMOJIS = ();
    load_emojis();

    Irssi::print("Reloading emojis database from file...");

    Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'loadbanner',
        Irssi::settings_get_str('knifamode_dbfile'));
    Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'statusbanner',
        scalar(keys %EMOJIS));
}

# void knifaize($data, $server, $witem)
# Parses input line in $data, replaces emojis and emits
# the signal back where it came from.
sub knifaize {
    my ($data, $server, $witem) = @_;

    my $enabled = Irssi::settings_get_bool('knifamode_enable');
    my $signal = Irssi::signal_get_emitted();

    return unless ($enabled && !$locked);

    # Do not filter commands
    if ($data =~ /^\//) { return };

    while ( my($trigger, $emoji) = each(%EMOJIS) ) {
        $data =~ s/$trigger/$emoji/g;
    }

    # event with shit mutex, lawl
    $locked = 1;
    Irssi::signal_emit("$signal", $data, $server, $witem);
    Irssi::signal_stop();
    $locked = 0;
}

# void complete_emoji($complist, $window, $word, $linerestart, $wspace)
# Tab completion hook for emoji triggers, completes to emoji on match.
sub complete_emoji {
    my ($complist, $window, $word, $linestart, $want_space) = @_;
    my $word_regexp = quotemeta($word);
    $word_regexp = qr/^$word_regexp/i;  # Compile regexp

    my @matches = ();
    foreach my $trigger (keys %EMOJIS) {
        push(@matches, $trigger) if ($trigger =~ m/$word_regexp/);
    }

    if (scalar(@matches) > 0) {
        push(@{$complist}, $EMOJIS{$matches[0]});
    }
    # TODO if more than one match, do something smart?
}

# void emojitable()
# Display a list of all emojis and keys in a crappy table.
# TODO: Eventually reconcile this with Oliver Uvman's pretty printing
sub emojitable {
    Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'tblh', "List of emojis");
    while ( my($trigger, $emoji) = each(%EMOJIS) ) {
        Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'tbl', $trigger);
        Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'tbl', "   $emoji");
    }
    Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'tblf', "End emojis");
}

# Settings
Irssi::settings_add_bool('lookandfeel', 'knifamode_enable', 1);
Irssi::settings_add_str('lookandfeel', 'knifamode_dbfile',
                            $default_emojis_file);

# hooks
Irssi::signal_add_first('send command', 'knifaize');
Irssi::signal_add_last('complete word' => \&complete_emoji);

# commands
Irssi::command_bind emojis => \&emojitable;
Irssi::command_bind reloademojis => \&reload_emojis;

# Register formats for table-like display.
# This was mostly shamelessly lifted from scriptassist.pl
Irssi::theme_register(
    [
        'tblh', '%R,--[%n$*%R]%n',
        'tbl', '%R|%n $*',
        'tblf', '%R`--[%n$*%R]%n',
        'banner', '%R>>%n %_Knifamode:%_ $0 initialized, version $1',
        'statusbanner', '%R>>%n %_Knifamode:%_ Loaded $0 knifaisms.',
        'loadbanner', '%R>>%n %_Knifamode:%_ Loading emojis from $0 ...',
        'statusmsg', '%R>>%n %_Knifamode:%_ - $0 -'
    ]
);

# main():

Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'loadbanner',
    Irssi::settings_get_str('knifamode_dbfile'));

load_emojis();

Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'banner', $IRSSI{name}, $VERSION);
Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'statusbanner', scalar(keys %EMOJIS));
Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'statusmsg',
    "Use /emojis to list available triggers.");

###
