$ones = @(
    "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", 
    "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
)

$tens = @(
    "zero", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"
)

$thous = @(
    "hundred", "thousand", "million", "billion", "trillion", "quadrillion"
)

function Convert-IntegerToWords ([int]$number, [string]$appendScale="") {
    if ($number -lt 0) {
        return "negative " + (Convert-IntegerToWords -number [math]::abs($number) -appendScale $appendScale)
    }
    [string]$numString = ""
    if ($number -lt 100) {
        if ($number -le 20) {
            $numString = $ones[$number]
        } else {
            $numString = $tens[[math]::floor($number / 10)]
            if (($number % 10) -gt 0) {
                #$numString += "-" + $ones[$number % 10]
                $numString += $ones[$number % 10]
            }
        }
    } else {
        [int]$pow = 0
        [string]$powStr = ""
        if ($number -lt 1000) {
            # number is between 100 and 1000
            $pow = 100
            $powStr = $thous[0]
        } else {
            return "input > 999 not supported"
        }
        <#
        else {
             # find the scale of the number
            [int]$log = [math]::log($number, 1000)
            [int]$pow = [math]::pow(1000, $log)
            $powStr = $thous[$log]
        }
        #>
        $numString = '{0} {1}' -f (Convert-IntegerToWords -number ([math]::floor($number / $pow)) -appendScale $powStr), (Convert-IntegerToWords -number ($number % $pow))
        
    }
    return ('{0} {1}' -f $numString, $appendScale).Trim()
}
