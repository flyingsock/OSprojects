test_no=0

bash logAnalyzer.sh test_log1.log > test_result1

function test_contains {
    let test_no++
    ip="$1"
    if [ $( grep -e $ip test_result1 ) ]; then
        echo "test $test_no passed"
    else
        echo "test $test_no failed"
    fi
}

test_contains "243.185.193.212"
test_contains "158.167.157.188"

rm -f test_result1


bash logAnalyzer.sh test_log2.log > test_result2

function test_uniq {
    let test_no++
    if [ "$( uniq test_result2 | wc -l test_result2 | cut -d' ' -f1 )" == "2" ]; then
        echo "test $test_no passed"
    else
        echo "test $test_no failed"
    fi
}

test_uniq

rm -f test_result2
