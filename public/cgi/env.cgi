#!/usr/bin/perl

print "Content-type: text/plain\n\n";

foreach my $key ( keys %ENV ) {
	print "$key => $ENV{$key}\n";
}

my $message = $ENV{HTTP_ACCEPT_CHARSET};

my @parts = $message =~ /([^;]+;[^,]+),?/g;

print "\n\n";

foreach my $p ( @parts ) {
	print ++$c . " -- $p\n";
}


print "\n\n";

print join(", ", getPrefferedEncoding(1));

print "\n\n";

sub getPrefferedEncoding {
    my $self = shift;

    return "*" if !$ENV{HTTP_ACCEPT_CHARSET};

    my @parts = split(/,/, $ENV{HTTP_ACCEPT_CHARSET});

    # hartog/20090626; Yes, I know it is complex, but just read like a
    # china-man and you'll be fine (right to left, bottom-up)
    #
    my @encodings = map {
	# if there are any array-refs, deref them
	ref $_->[0] ? @{ $_->[0] } : $_->[0];

    } sort {
	# sort the array based on quality (higher is better)
	$b->[1] <=> $a->[1]

    } map {
	# get the parts
	my ($enc, $qual) = split(/\;/, $_);

	# make the quality a number
	if ( $qual ) {
	    $qual =~ s/^q=//;
	} else {
	    $qual = 1;
	}

	# return a sortable array
	[ $enc, $qual ]

    } @parts;

    return @encodings;
}
