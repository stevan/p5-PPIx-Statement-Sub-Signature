#!perl

use strict;
use warnings;

use Data::Dumper;

use Test::More;

BEGIN {
    use_ok('PPIx::Statement::Sub::Signature');
}

use PPI;

subtest '... single scalar parameter' => sub {
    my $src = 'sub foo ($bar) { $bar }';
    my $doc = PPI::Document->new( \$src );
    my $sub = $doc->find('PPI::Statement::Sub')->[0];
    my $sig = PPIx::Statement::Sub::Signature->new( $sub );

    is($sig->prototype, '$bar', '... got the expected prototype');
    is_deeply($sig->parameters, ['$bar'], '... got the expected parameters');
    is_deeply($sig->parameter_names, ['bar'], '... got the expected parameter_names');
};

subtest '... single array parameter' => sub {
    my $src = 'sub foo (@bar) { @bar }';
    my $doc = PPI::Document->new( \$src );
    my $sub = $doc->find('PPI::Statement::Sub')->[0];
    my $sig = PPIx::Statement::Sub::Signature->new( $sub );

    is($sig->prototype, '@bar', '... got the expected prototype');
    is_deeply($sig->parameters, ['@bar'], '... got the expected parameters');
    is_deeply($sig->parameter_names, ['bar'], '... got the expected parameter_names');
};

subtest '... single hash parameter' => sub {
    my $src = 'sub foo (%bar) { @bar }';
    my $doc = PPI::Document->new( \$src );
    my $sub = $doc->find('PPI::Statement::Sub')->[0];
    my $sig = PPIx::Statement::Sub::Signature->new( $sub );

    is($sig->prototype, '%bar', '... got the expected prototype');
    is_deeply($sig->parameters, ['%bar'], '... got the expected parameters');
    is_deeply($sig->parameter_names, ['bar'], '... got the expected parameter_names');
};

subtest '... two scalar parameters' => sub {
    my $src = 'sub add ($l, $r) { $l + $r }';
    my $doc = PPI::Document->new( \$src );
    my $sub = $doc->find('PPI::Statement::Sub')->[0];
    my $sig = PPIx::Statement::Sub::Signature->new( $sub );

    is($sig->prototype, '$l,$r', '... got the expected prototype');
    is_deeply($sig->parameters, ['$l', '$r'], '... got the expected parameters');
    is_deeply($sig->parameter_names, ['l', 'r'], '... got the expected parameter_names');
};

subtest '... mixed scalar and array parameters' => sub {
    my $src = 'sub add ($l, @r) { $l, @r }';
    my $doc = PPI::Document->new( \$src );
    my $sub = $doc->find('PPI::Statement::Sub')->[0];
    my $sig = PPIx::Statement::Sub::Signature->new( $sub );

    is($sig->prototype, '$l,@r', '... got the expected prototype');
    is_deeply($sig->parameters, ['$l', '@r'], '... got the expected parameters');
    is_deeply($sig->parameter_names, ['l', 'r'], '... got the expected parameter_names');
};

subtest '... mixed scalar and hash parameters' => sub {
    my $src = 'sub add ($l, %r) { $l, %r }';
    my $doc = PPI::Document->new( \$src );
    my $sub = $doc->find('PPI::Statement::Sub')->[0];
    my $sig = PPIx::Statement::Sub::Signature->new( $sub );

    is($sig->prototype, '$l,%r', '... got the expected prototype');
    is_deeply($sig->parameters, ['$l', '%r'], '... got the expected parameters');
    is_deeply($sig->parameter_names, ['l', 'r'], '... got the expected parameter_names');
};

subtest '... mixed parameters' => sub {
    my $src = 'sub add ($l, $r, @rr) { $l, $r, @rr }';
    my $doc = PPI::Document->new( \$src );
    my $sub = $doc->find('PPI::Statement::Sub')->[0];
    my $sig = PPIx::Statement::Sub::Signature->new( $sub );

    is($sig->prototype, '$l,$r,@rr', '... got the expected prototype');
    is_deeply($sig->parameters, ['$l', '$r', '@rr'], '... got the expected parameters');
    is_deeply($sig->parameter_names, ['l', 'r', 'rr'], '... got the expected parameter_names');
};


done_testing;
