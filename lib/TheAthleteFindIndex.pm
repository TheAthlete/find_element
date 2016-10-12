package TheAthleteFindIndex;

use strict;
use warnings;

use feature 'say';
use DDP;

use constant {
    IDX => 0,
    _ABS => 1,
};

my $cnt = 0;

sub new {
    my ($class) = @_;
    my $self = bless {}, $class;
    return $self;
}

sub find {
    my ($self, $nums, $value) = @_;

    @$self{qw/nums value/} = ($nums, $value); 

    $cnt = 0;

    my ($idx, $cnt_cmp) = $self->search(0, $#{$self->{nums}}, $self->{value});

    return ($idx, $cnt_cmp);
}

sub search {
    my ($self, $l, $r, $el) = @_;

    ++$cnt;

    return (undef, undef) if $l > $r;
    return (undef, undef) unless defined $el;

    my $mid_idx = int(($l + $r) / 2);

    my $prev = [$mid_idx-1, abs($self->{nums}->[$mid_idx-1] - $el)];
    my $cur = [$mid_idx, abs($self->{nums}[$mid_idx] - $el)];
    my $next = $self->{nums}[$mid_idx+1] ? [$mid_idx+1, abs($self->{nums}[$mid_idx+1] - $el)] : undef;

    return ($prev->[IDX], $cnt) if defined $prev && !$prev->[_ABS];
    return ($cur->[IDX], $cnt) if defined $cur && !$cur->[_ABS];

    if ($prev->[_ABS] < $cur->[_ABS]) {
        $self->search($l, $mid_idx - 1, $el);
    } elsif ($prev->[_ABS] >= $cur->[_ABS]) {
        if (!defined $next || $cur->[_ABS] <= $next->[_ABS]) {
            return ($cur->[IDX], $cnt);
        } else {
            $self->search($mid_idx + 1, $r, $el);
        }
    } 
}

1;
