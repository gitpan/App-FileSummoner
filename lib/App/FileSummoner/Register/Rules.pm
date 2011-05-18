package App::FileSummoner::Register::Rules;
BEGIN {
  $App::FileSummoner::Register::Rules::VERSION = '0.003';
}

use strict;
use warnings;
use File::Spec;
use File::Basename qw(basename dirname);

use Exporter 'import';
our @EXPORT = qw(
    HasExt
    InsideDirectory
    BelowDirectory
);

sub InsideDirectory {
    my ($dir) = @_;
    return sub {
        my ($fileName) = @_;
        return $dir eq basename(dirname($fileName));
    };
}

sub BelowDirectory {
    my ($dir) = @_;
    return sub {
        my ($fileName) = @_;
        my @dirs = File::Spec->splitdir($fileName);
        return $dir ~~ @dirs;
    };
}

sub HasExt {
    my ($ext) = @_;
    return sub {
        shift =~ qr/\.$ext$/;
    };
}

1;
