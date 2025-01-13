#!/usr/bin/perl
use strict;
use warnings;
use File::Find;

# Specify the directory containing HTML files
my $directory = 'path/to/your/html/files'; # Change this to your directory path
my $replacement_file = 'replace_text.txt'; # The file containing the text to replace

# Read the replacement text from the specified file
open(my $rfh, '<', $replacement_file) or die "Could not open '$replacement_file': $!";
my $text_to_replace = do { local $/; <$rfh> }; # Slurp the entire file content
close($rfh);

# Remove any trailing newlines for accurate matching
$text_to_replace =~ s/\R\z//;

# Find all .html files in the specified directory
find(\&process_file, $directory);

sub process_file
{
    return unless /\.html$/; # Only process .html files

    my $file_path = $File::Find::name;

    # Read the content of the HTML file
    open(my $ifh, '<', $file_path) or die "Could not open '$file_path': $!";
    my $file_content = do { local $/; <$ifh> }; # Slurp entire input file
    close($ifh);

    # Perform the replacement (removing the text)
    $file_content =~ s/\Q$text_to_replace\E//g;

    # Write back to the HTML file
    open(my $ofh, '>', $file_path) or die "Could not open '$file_path' for writing: $!";
    print $ofh $file_content;
    close($ofh);

    print "Processed: $file_path\n"; # Optional: Print processed file name
}
