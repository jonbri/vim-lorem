#!/usr/bin/perl -w
use strict;
use Getopt::Long;
use File::Spec;

# tasks to match up with file patterns of source code files
# __lib__ will be replaced with the determined library of the file
my %taskHash=(
    # .js file that is NOT qunit file
    '.*\/src\/.*(?<!\.qunit)\.js$' => "copy:src-target-__lib__ copy:npm-package",

    # .js file that is NOT qunit file that has "test" after it's lib
    '.*\/*\/test\/.*(?<!\.qunit)\.js$' => "copy:test-target-__lib__ copy:npm-package",

    # qunit js or html file
    '\.qunit\.(html|js)$' => "copy:test-target-__lib__"
);

MAIN: {
    use Cwd;
    my $firstArg=$ARGV[0];
    my ($help,$debug,$repo);
    GetOptions(
        'help' => \$help,
        'debug' => \$debug,
        'repo=s' => \$repo
    );

    if ($help) {
        doHelp();
    }

    exit 0;
}
