$b = $c = $d = $q = $e = 0

$(switch ([string[]][char[]](gc "d:\a1.txt"))
{
    
    " " {$b++}
    
    "," {$c++}
    
    "." {$d++}
    
    "?" {$q++}
    
    "!" {$e++}

}) -join ""

$a=get-content -path d:\a1.txt

$a -split {$_ -eq " " -or $_ -eq "," -or $_ -eq "." -or $_ -eq "!" -or $_ -eq "?"}

"  - "+$b
", - "+$c
". - "+$d
"? - "+$q
"! - "+$e