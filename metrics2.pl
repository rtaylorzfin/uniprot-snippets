#!/opt/zfin/bin/perl
use strict;

#------------------- Flush Output Buffer --------------
$| = 1;

#=======================================================
#
#   Main
#
chdir "/opt/zfin/www_homes/cell/server_apps/data_transfer/SWISS-PROT/";
print STDERR "Reading okfile and generating metrics.txt\n";

$/ = "//\n";
open(INPUTFILE, "okfile") || die("Could not open okfile !");
my @blocks = <INPUTFILE>;
close(INPUTFILE);
print STDERR "Processing okfile\n";

my $zfin_count = 0;

print "ID,zfin_count\n";
foreach my $block (@blocks) {
    $zfin_count = 0;
    my @lines = split("\n", $block);
    foreach my $line (@lines) {
        if ($line =~ m/^DR   ZFIN/) {
            $zfin_count++;
        }
    }
    my $id = "";
    if ($block =~ m/^ID   (.*?)\s/) {
        $id = $1;
    }
    else {
        print "No ID?\n";
    }
    if ($zfin_count > 1) {
        print "$id has more than one ZFIN id\n";
    }
}
