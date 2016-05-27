package PPIx::Statement::Sub::Signature;

use strict;
use warnings;

use Scalar::Util qw[ blessed ];
use Carp         qw[ confess ];

sub new {
    my ($class, $sub) = @_;

    (blessed $sub && $sub->isa('PPI::Statement::Sub'))
        || confess 'You must pass an instance of PPI::Statement::Sub, not ' . $sub;

    # NOTE:
    # the `prototype` seems to get spaces between
    # the commas removed, this might prove an issue
    # with more complex signatures.
    # - SL

    my $proto  = $sub->prototype =~ s/^\(//r =~ s/\)$//r;
    my @params = split /\s*\,\s*/ => $proto;

    # TODO:
    # the above "parsing" does not account for
    # the possibility of default values in the
    # signature, this needs to be added.
    # - SL

    bless {
        _sub    => $sub,
        _proto  => $proto,
        _params => \@params,
    } => $class;
}

# accessors

sub prototype  { $_[0]->{_proto}  }
sub parameters { $_[0]->{_params} }

# ...

# TODO: can we calculate arity correctly? with slurpies?

sub parameter_names {
    my ($self) = @_;
    return [ map s/^[\$\@\%]//r, @{ $self->{_params} } ]
}

1;

__END__

=pod

=head1 NAME

PPIx::Statement::Sub::Signature

=head1 SYNOPSIS

=head1 DESCRIPTION

Currently L<PPI> does not have a way to handle the new
subroutine signature feature in Perl 5.22, this module
attempts to (kind of) fix this.

=cut
