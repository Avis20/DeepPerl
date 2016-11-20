#!/usr/bin/perl
use uni::perl   qw| :dumper |;

=head operator sort
my @sorted = sort qw(Здесь текст сортированный по алфавиту);
print "@sorted";
=cut

=head operator reverse
my @reverse = reverse qw(Здесь текст сортированный в обратном порядке);
print "@reverse";
=cut

=head Оператор grep с блочным синтаксисом
# grep возвращает элемент $_, у которого четная сумма цифр
my @numbers = qw(1 2 3 4 5 6 7 8 9 10 11 12 13);
my @digit_sum = grep {
        my $input = $_;
        my @digits = split //, $input;

        my $sum;
        $sum += $_ for @digits;
        $sum % 2 == 0;
    } @numbers;
print "@digit_sum";
=head Результат
2 4 8 11 13
=cut

=head Оператор map
my @numbers = qw(1 2 3 4 5 6 7 8 9 10 11 12 13);
my @result = map $_ + 10, @numbers;
print "@result";
=head Результат
11 12 13 14 15 16 17 18 19 20 21 22 23
=cut

=head Оператор map (Один входной элемент, два выходных)
my @numbers = qw(1 2 3 4 5 6 7 8 9 10 11 12 13);
my @result = map {$_ . '->', $_ + 10 . ' '} @numbers;
print @result;
=head Результат
1->11 2->12 3->13 4->14 5->15 6->16 7->17 8->18 9->19 10->20 11->21 12->22 13->23
=cut

=head Оператор map
# Результат работы оператора map, ссылка на хеш в котором ключ - текущий элемент, а значение массив его цифр
my @numbers = qw(1 2 3 4 5 6 7 8 9 10 11 12 13);
my $hash = {map {$_, [split //, $_]} @numbers};
warn dumper $hash;
=head Результат
{
  9 => [9],
  10 => [1,0],
  12 => [1,2],
  11 => [1,1],
  8 => [8],
  6 => [6],
  1 => [1],
  5 => [5],
  3 => [3],
  4 => [4],
  7 => [7],
  13 => [1,3],
  2 => [2]
}
=cut

=head Оператор eval
# Провоцируем ошибку деления на ноль, и выпоняем в блоке eval
my $total = 0;
my $count = 2;
my $average;
eval {$average = $count / $total};
print "Ошибка: ". $@ ."\n" if ($@);
print "Ну и ладно, продолжаем :)";
=head Результат
Деление на ноль
Ну и ладно, продолжаем :)
=cut

=head Упражнение 2.1
print map {'    ' . $_ . "\n"} grep {-s $_ < 1000} @ARGV;
=head Результат
perl file.pl text.txt text2.txt text3.txt 
    text3.txt
=cut

# =head Упражнение 2.2
chdir("/etc");
while (1){
    print "Введите регулярное выражение > ";
    chomp(my $regexp = <STDIN>);
    last unless (defined $regexp && length $regexp);
    print map {'    ' . $_ . "\n"} grep /$regexp/, glob(".* *");
}
=head Результат
perl file.pl
Введите регулярное выражение > hi
    avahi
    machine-id
=cut