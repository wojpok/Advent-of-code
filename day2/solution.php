<?php

/**
 * 1 -> rock
 * 2 -> paper
 * 3 -> scissors
 */
function getCode($letter): int{
    return match($letter) {
        'A' => 1,
        'B' => 2,
        'C' => 3,
        'X' => 1,
        'Y' => 2,
        'Z' => 3,
    };
}

function roundScore(int $opponent, int $me): int {
    
    if($opponent === $me) 
        return $me + 3;
    
    if($me === $opponent + 1 || $me + 2 === $opponent) {
        return $me + 6;
    }

    return $me;
}

function gameScore(array $rounds): int {
    
    $total = 0;
    
    foreach($rounds as $round) {
        $total += roundScore(getCode($round[0]), getCode($round[2]));
    }

    return $total;
}

$data = file('data.in');

$total = gameScore($data);

echo "$total\n";

function secondStrat(int $opponent, int $me): int {
    //      Score for winning  
    $result = ($me * 3 - 3);
                + 
    $mySymbol = match($me) {
        1 => $opponent - 1,
        2 => $opponent,
        3 => $opponent + 1
    };

    if($mySymbol > 3) $mySymbol -= 3;
    if($mySymbol < 1) $mySymbol += 3;

    return $result + $mySymbol;
}

function secondScore(array $rounds): int {

    $total = 0;
    
    foreach($rounds as $round) {
        $total += secondStrat(getCode($round[0]), getCode($round[2]));
    }

    return $total;
}

$total = secondScore($data);

echo "$total\n";