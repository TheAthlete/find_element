Модуль поиска элемента массива наиболее близкого к заданному числу

Метод search - выполняет рекурсивный поиск наименьшего элемента

Поиск происходит за логарифмическое время, т.к. во внутреннем методе search используется модифицированный бинарный поиск,
Алгоритм следующий:

1. делим массив на две части,  
2. работаем с левой частью:

   получаем разность двух элементов - среднего элемента и искомого значения, и предыдущего элемента и искомого, взятые по модулю, т.е. abs($mid - $value) и abs($mid - 1 - $value). Если средний элемент больше предыдущего (элементы идут по возрастанию), то работаем дальше с этой частью, иначе работаем с правой

3. делим эту часть еще пополам, пока не найдем элемент
4. элемент найден, если $prev > $cur && $cur < $next, т.к. при преобразовании разности abs(...) мы получаем 

   примерную последовательность (12 10 5 2 1 2 3 7 11), т.е. искомым элементом (индексом) является элемент, у которого значения слева и справа него больше.

В папке lib/ лежит модуль с методами search и find, в папке t/ лежат тесты метода find
