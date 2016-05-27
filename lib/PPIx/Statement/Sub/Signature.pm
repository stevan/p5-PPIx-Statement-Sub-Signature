package PPIx::Statement::Sub::Signature;

use strict;
use warnings;

use Scalar::Util qw[ blessed ];
use Carp         qw[ confess ];

sub new {
    my ($class, $sub) = @_;

    (blessed $sub && $sub->isa('PPI::Statement::Sub'))
        || confess 'You must pass an instance of PPI::Statement::Sub, not ' . $sub;

    my $proto  = $sub->prototype =~ s/^\(//r =~ s/\)$//r;
    my @params = split /\s*\,\s*/ => $proto;

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

=cut
