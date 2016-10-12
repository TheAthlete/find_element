use strict;
use warnings;
use feature 'say';
use DDP;

use Test::More;
use TheAthleteFindIndex;

subtest 'find without duplicate' => sub {

    { 
        my $data = {
            nums => [grep {$_%2} 0..22],
            values => [0..22],
            indexes => [qw/0 0 0 1 2 2 2 3 3 4 5 5 5 6 6 7 8 8 8 9 9 10 10/],
        };

        my $find_idx = TheAthleteFindIndex->new();
        say "cnt nums ". scalar(@{$data->{nums}});

        # my @cnt_cmps;
        for (0..$#{$data->{values}}) {
            my ($idx, $cnt_cmp) = $find_idx->find($data->{nums}, $data->{values}[$_]);
            # my $idx = $find_idx->find($data->{nums}, $data->{values}[$_]);
            # push @cnt_cmps, $cnt_cmp;
            is $idx, $data->{indexes}[$_], "find index for val $data->{values}[$_]" ;
        }
        # say "cnt cmps: @cnt_cmps";
    }
    
    { 
    # + с большими пропусками, например @nums = qw/1 5 10 25 33 50 97 112/; @values = qw/27 37 47 53 101 109/;
    # + использовать четное кол-во эл-тов в массиве (сейчас cnt nums = 11, сделать, чтобы было 10 или 12)
        my $data = {
            nums => [qw/1 5 10 25 33 50 97 112/],
            values => [qw/27 37 47 53 101 109/],
            indexes => [qw/3 4 5 5 6 7/],
        };

        my $find_idx = TheAthleteFindIndex->new();
        # say "cnt nums ". scalar(@{$data->{nums}});

        for (0..$#{$data->{values}}) {
            my ($idx, $cnt_cmp) = $find_idx->find($data->{nums}, $data->{values}[$_]);
            is $idx, $data->{indexes}[$_], "find index for val $data->{values}[$_] with large skip" ;
        }
    }

    { 
    #   + с пустым массивом - возвращать undef
    #   + возвращать undef если $l > $r 
        my $data = {
            nums => [],
            values => [qw/27/],
            indexes => [],
        };

        my $find_idx = TheAthleteFindIndex->new();
        my ($idx, $cnt_cmp) = $find_idx->find($data->{nums}, $data->{values}[0]);
        ok ! defined $idx;
    }

    { 
    #   - с искомым значением undef - возвращать undef
        my $data = {
            nums => [qw/1 2 3/],
            values => [],
            indexes => [],
        };

        my $find_idx = TheAthleteFindIndex->new();
        my ($idx, $cnt_cmp) = $find_idx->find($data->{nums}, $data->{values}[0]);
        ok ! defined $idx;
    }

    { 
        my $data = {
            nums => [qw/1/],
            values => [qw/5/],
            indexes => [],
        };

        my $find_idx = TheAthleteFindIndex->new();
        my ($idx, $cnt_cmp) = $find_idx->find($data->{nums}, $data->{values}[0]);
        is $idx, 0;
    }

    # 1. Реализовать тестирования метода find и search
    #  +- метод должен возвращать индекс элемента и количество сравнений

};

done_testing;
