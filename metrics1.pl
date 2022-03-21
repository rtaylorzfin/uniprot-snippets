#!/opt/zfin/bin/perl
use strict ;

#------------------- Flush Output Buffer --------------
$|=1;

#=======================================================
#
#   Main
#


chdir "/opt/zfin/www_homes/cell/server_apps/data_transfer/SWISS-PROT/";

print STDERR "Reading pre_zfin.dat and generating metrics.txt\n";

$/ = "//\n";
open(PREDAT, "pre_zfin.dat") || die("Could not open pre_zfin.dat !");
my @blocks = <PREDAT>;
close(PREDAT);
print STDERR "Processing pre_zfin.dat\n";

my $has_rna = 0;
my $has_seq = 0;

print "ID,has_rna,has_seq\n";
foreach my $block (@blocks) {
   $has_rna = "0";
   $has_seq = "0";
   if($block =~ m/^DR.*EMBL.*RNA/m) {
	$has_rna = "1";
   }
   if($block =~ m/^DR   RefSeq/m) {
	$has_seq = "1";
   }
   if($block =~ m/^ID   (.*?)\s/) {
     print "$1,$has_rna,$has_seq\n";
   } else {
     print "No ID?\n";
   }
}
