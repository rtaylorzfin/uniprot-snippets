#!/opt/zfin/bin/perl
use strict ;

use MIME::Lite;
use LWP::Simple;
use DBI;
use lib "/opt/zfin/www_homes/cell/server_apps/";
use ZFINPerlModules;
use Try::Tiny;
use POSIX;

#------------------- Flush Output Buffer --------------
$|=1;

#=======================================================
#
#   Main
#


#set environment variables
chdir "/opt/zfin/www_homes/cell/server_apps/data_transfer/SWISS-PROT/";


my $dbname = "celldb";
my $dbhost = "localhost";
my $username = "";
my $password = "";


print "Reading pre_zfin.dat and generating metrics.txt\n";

my $cur;

$/ = "//\n";
open(PREDAT, "pre_zfin.dat") || die("Could not open pre_zfin.dat !");
my @blocks = <PREDAT>;
close(PREDAT);
print STDERR "Processing pre_zfin.dat\n";

my $totalOnZfinDat = 0;
my $totalOnDeleted = 0;
my $ttt = 0;
my @lines = ();
my %toNewInput = ();
my %deletes = ();
my $ct = 0;
my %ZDBgeneIDgeneAbbrevs = ();
my $line;
my $lineKey = 0;
my @fields = ();
my $ZFINgeneId;
my $geneAbbrev;
my $block;
my $newLineNumber;
my $key;
my $has_rna = 0;
my $has_seq = 0;

print "ID,has_rna,has_seq\n";
foreach $block (@blocks) {
   $ttt++;
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

