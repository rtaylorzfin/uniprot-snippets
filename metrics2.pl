#!/opt/zfin/bin/perl
use strict;

$/ = "//\n";
open(PREDAT, "pre_zfin.dat") || die("Could not open pre_zfin.dat !");
my @blocks = <PREDAT>;
close(PREDAT);
print STDERR "Processing pre_zfin.dat\n";
my $prezfin = 0;
foreach my $block (@blocks) {
    my $zfinDRs = 0;
    my $zfinLines = "";
    my @lines = split(/\n/, $block);
    my $id = "NONE";
    foreach my $line (@lines) {
        if ($line =~ m/^ID   (.*?)\s/) {
            $id = $1;
        }
        if ($line =~ m/DR   ZFIN; (ZDB-GENE-.*); (.*)\./) {
            $zfinDRs++;
            $zfinLines .= "," . $1;
        }
    }
    if ($zfinDRs > 1) {
        # print "Multiple ZFIN recs\n";
        # print "$prezfin\n";
        print "$id" . "$zfinLines\n";
    }
    if ($block =~ m/OS   Danio rerio/) {
        $prezfin++;
    }
}

print $prezfin;
