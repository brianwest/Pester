﻿function Should-BeLikeExactly($ActualValue, $ExpectedValue, [switch] $Negate, [String] $Because) {
    <#
    .SYNOPSIS
    Asserts that the actual value matches a wildcard pattern using PowerShell's -like operator.
    This comparison is case-sensitive.

    .EXAMPLE
    $actual = "Actual value"
    $actual | Should -BeLikeExactly "Actual *"

    This test will pass, as the string matches the provided pattern.

    .EXAMPLE
    $actual = "Actual value"
    $actual | Should -BeLikeExactly "actual *"

    This test will fail, as -BeLikeExactly is case-sensitive.
    #>
    [bool] $succeeded = $ActualValue -clike $ExpectedValue
    if ($Negate) {
        $succeeded = -not $succeeded
    }

    if (-not $succeeded) {
        if ($Negate) {
            return [PSCustomObject] @{
                Succeeded      = $false
                FailureMessage = "Expected case sensitive like wildcard $(Format-Nicely $ExpectedValue) to not match $(Format-Nicely $ActualValue),$(Format-Because $Because) but it did match."
            }
        }
        else {
            return [PSCustomObject] @{
                Succeeded      = $false
                FailureMessage = "Expected case sensitive like wildcard $(Format-Nicely $ExpectedValue) to match $(Format-Nicely $ActualValue),$(Format-Because $Because) but it did not match."
            }
        }
    }

    return [PSCustomObject] @{
        Succeeded = $true
    }
}

& $script:SafeCommands['Add-ShouldOperator'] -Name         BeLikeExactly `
    -InternalName Should-BeLikeExactly `
    -Test         ${function:Should-BeLikeExactly}

function ShouldBeLikeExactlyFailureMessage() {
}
function NotShouldBeLikeExactlyFailureMessage() {
}
