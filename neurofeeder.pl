#!/bin/perl

#########
# neurofeeder: neural feeder 
# it take input from a yahoo finance csv file then process it to have a 
# a row with a parametrized number of value followed by an "output" value. 
# author Giovambattista Vieri 
# license GPL 
# version 0
# status alpha
# warning this code is alpha-code it can make you bald or it can corrupt all of you data... 
#########
#########
# parameters:
# 1 file name 
# 2 number of period in output single line
# 3 output column number
# 4 input column number start
# 5 input column number end (optional) 
#
#########

my $filename="";
my $numOfPer;
my $outColumn;
my $inpColNumberStart;
my $inpColNumberEnd;
#####
my $line;
my @dataArray;
my @tempArray=();
my @temp;
my $newline;
my @inputData;
my @ouputData;
my $endOfper;
my $numberOfItem;


sub usage
{
print "ne_fe <input filename> <number of output period> <output column number> <input colum number start> [input column number end]\n";
}


# check that the parameter number is correct
if (@ARGV<4 || @ARGV>5) {
	usage();
	exit(1);
}

$filename		=$ARGV[0];
$numOfPer		=$ARGV[1];
$outColumn		=$ARGV[2];
$inpColNumberStart	=$ARGV[3];
if(@ARGV>4) {
	$inpColNumberEnd	=$ARGV[4];
}


# verify if the parameters are correct 
# to be implemented 

# verify that paramenter 5 is greater than the 4 

# open the file (try to) ...
open FI, $filename or die $!;

# chop the first line of input file 
$line=<FI>; 

# read all the file contents in memory 
@dataArray=();
while ($line=<FI>) {
	chop $line;
	push(@dataArray,$line);
}

while ($line=pop(@dataArray)) {
	push(@tempArray,$line);
}

@dataArray=@tempArray;
@tempArray=();

# prepare another array with all the lines and | as line field separator
@purgedData=();
foreach $line (@dataArray) {
		@temp=split(',',$line);
		$newline=@temp[$inpColNumberStart];
		$newline.="|".@temp[$outColumn];
		push(@purgedData,$newline);
}

# destroy and free the memory of the array with  file contents. 
@dataArray=();
@inputData=();
@outputData=();
foreach $line (@purgedData) {
	($inp,$out)=split('\|',$line);
	push(@inputData,$inp);
	push(@outputData, $out);
}

# now we will start to prepare the output

$numberOfItem= $#inputData+1;
$endOfFor=$numberOfItem-$numOfPer;

for ($i=0;$i<$endOfFor;$i++) {
	for ($x=0;$x<$numOfPer;$x++) {
		print $inputData[$i+$x].",";
	}
	print $outputData[$i+$x]."\n";
}

