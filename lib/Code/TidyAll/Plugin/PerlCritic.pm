package Code::TidyAll::Plugin::PerlCritic;
use Capture::Tiny qw(capture_merged);
use Moo;
extends 'Code::TidyAll::Plugin';

sub _build_cmd { 'perlcritic' }

sub validate_file {
    my ( $self, $file ) = @_;

    my $cmd = sprintf( "%s %s %s", $self->cmd, $self->argv, $file );
    my $output = capture_merged { system($cmd) };
    die "$output\n" if $output !~ /^.* source OK\n/;
}

1;

__END__

=pod

=head1 NAME

Code::TidyAll::Plugin::PerlCritic - use perlcritic with tidyall

=head1 SYNOPSIS

   In configuration:

   ; Configure in-line
   ;
   [PerlCritic]
   argv = --severity 5 --exclude=nowarnings
   select = lib/**/*.pm

   ; or refer to a .perlcriticrc in the same directory
   ;
   [PerlCritic]
   argv = --profile $ROOT/.perlcriticrc
   select = lib/**/*.pm

=head1 DESCRIPTION

Runs L<perlcritic|perlcritic>, a Perl validator, and dies if any problems were
found.

=head1 INSTALLATION

Install perlcritic from CPAN.

    cpanm perlcritic

=head1 CONFIGURATION

=over

=item argv

Arguments to pass to perlcritic

=back
