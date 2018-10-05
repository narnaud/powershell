function Set-PromptSetting {
    [Alias("Set-PromptSettings")]
    [CmdletBinding()]
    param(
        [string]$AfterChangesText = "]:",
        [PoshCode.Pansies.RgbColor]$AfterChangesForeground,
        [PoshCode.Pansies.RgbColor]$AfterChangesBackground,

        [string]$AfterNoChangesText = "]:",
        [PoshCode.Pansies.RgbColor]$AfterNoChangesForeground,
        [PoshCode.Pansies.RgbColor]$AfterNoChangesBackground,

        [string]$AheadByText = '▲',
        [PoshCode.Pansies.RgbColor]$AheadByForeground,
        [PoshCode.Pansies.RgbColor]$AheadByBackground,

        [string]$BehindByText = '▼',
        [PoshCode.Pansies.RgbColor]$BehindByForeground,
        [PoshCode.Pansies.RgbColor]$BehindByBackground,

        [string]$BeforeText = "[",
        [PoshCode.Pansies.RgbColor]$BeforeForeground,
        [PoshCode.Pansies.RgbColor]$BeforeBackground,

        [string]$BranchText = $([char]0x03BB),
        [PoshCode.Pansies.RgbColor]$BranchForeground,
        [PoshCode.Pansies.RgbColor]$BranchBackground,

        [string]$BeforeChangesText = '',
        [PoshCode.Pansies.RgbColor]$BeforeChangesForeground,
        [PoshCode.Pansies.RgbColor]$BeforeChangesBackground,

        [string]$SeparatorText = '|',
        [PoshCode.Pansies.RgbColor]$SeparatorForeground,
        [PoshCode.Pansies.RgbColor]$SeparatorBackground,

        [PoshCode.Pansies.RgbColor]$StagedChangesForeground,
        [PoshCode.Pansies.RgbColor]$StagedChangesBackground,

        [PoshCode.Pansies.RgbColor]$UnStagedChangesForeground,
        [PoshCode.Pansies.RgbColor]$UnStagedChangesBackground,

        [string]$NoStatusText = ':',
        [PoshCode.Pansies.RgbColor]$NoStatusForeground,
        [PoshCode.Pansies.RgbColor]$NoStatusBackground,

        [PoshCode.Pansies.RgbColor]$IndexForeground,
        [PoshCode.Pansies.RgbColor]$IndexBackground,

        [PoshCode.Pansies.RgbColor]$WorkingForeground,
        [PoshCode.Pansies.RgbColor]$WorkingBackground,

        [Switch]$HideZero
    )

    $config = Import-Configuration
    switch($PSBoundParameters.Keys) {
        "AfterChangesText" { $config.AfterChanges.Object = $PSBoundParameters[$_] }
        "AfterChangesBackground" { $config.AfterChanges.Background = $PSBoundParameters[$_] }
        "AfterChangesForeground" { $config.AfterChanges.Foreground = $PSBoundParameters[$_] }

        "AfterNoChangesText" { $config.AfterNoChanges.Object = $PSBoundParameters[$_] }
        "AfterNoChangesBackground" { $config.AfterNoChanges.Background = $PSBoundParameters[$_] }
        "AfterNoChangesForeground" { $config.AfterNoChanges.Foreground = $PSBoundParameters[$_] }

        "AheadByText" { $config.AheadBy.Object = $PSBoundParameters[$_] }
        "AheadByBackground" { $config.AheadBy.Background = $PSBoundParameters[$_] }
        "AheadByForeground" { $config.AheadBy.Foreground = $PSBoundParameters[$_] }

        "BeforeText" { $config.Before.Object = $PSBoundParameters[$_] }
        "BeforeBackground" { $config.Before.Background = $PSBoundParameters[$_] }
        "BeforeForeground" { $config.Before.Foreground = $PSBoundParameters[$_] }

        "BeforeChangesText" { $config.BeforeChanges.Object = $PSBoundParameters[$_] }
        "BeforeChangesBackground" { $config.BeforeChanges.Background = $PSBoundParameters[$_] }
        "BeforeChangesForeground" { $config.BeforeChanges.Foreground = $PSBoundParameters[$_] }

        "BehindByText" { $config.BehindBy.Object = $PSBoundParameters[$_] }
        "BehindByBackground" { $config.BehindBy.Background = $PSBoundParameters[$_] }
        "BehindByForeground" { $config.BehindBy.Foreground = $PSBoundParameters[$_] }

        "BranchText" { $config.Branch.Object = $PSBoundParameters[$_] }
        "BranchBackground" { $config.Branch.Background = $PSBoundParameters[$_] }
        "BranchForeground" { $config.Branch.Foreground = $PSBoundParameters[$_] }

        "SeparatorText" { $Config.Separator.Object = $PSBoundParameters[$_] }
        "SeparatorBackground" { $Config.Separator.Background = $PSBoundParameters[$_] }
        "SeparatorForeground" { $Config.Separator.Foreground = $PSBoundParameters[$_] }

        "StagedChangesBackground" { $config.StagedChanges.Background = $PSBoundParameters[$_] }
        "StagedChangesForeground" { $config.StagedChanges.Foreground = $PSBoundParameters[$_] }

        "UnStagedChangesBackground" { $config.UnStagedChanges.Background = $PSBoundParameters[$_] }
        "UnStagedChangesForeground" { $config.UnStagedChanges.Foreground = $PSBoundParameters[$_] }

        "NoStatusText" { $config.NoStatus.Text = $PSBoundParameters[$_] }
        "NoStatusForeground" { $config.NoStatus.Foreground = $PSBoundParameters[$_] }
        "NoStatusBackground" { $config.NoStatus.Background = $PSBoundParameters[$_] }

        "IndexForeground" { $config.Index.Foreground = $PSBoundParameters[$_] }
        "IndexBackground" { $config.Index.Background = $PSBoundParameters[$_] }

        "WorkingForeground" { $config.Working.Foreground = $PSBoundParameters[$_] }
        "WorkingBackground" { $config.Working.Background = $PSBoundParameters[$_] }

        "HideZero" { $Config.HideZero = [bool]$HideZero }
    }

    # function Clear-Config {
    #     [CmdletBinding()]
    #     param(
    #         [AllowNull()][AllowEmptyString()]
    #         [Parameter(ValueFromPipelineByPropertyName)]
    #         [String]$Text,

    #         [AllowNull()][AllowEmptyString()]
    #         [Parameter(ValueFromPipelineByPropertyName)]
    #         [PoshCode.Pansies.RgbColor]$Foreground,

    #         [AllowNull()][AllowEmptyString()]
    #         [Parameter(ValueFromPipelineByPropertyName)]
    #         [PoshCode.Pansies.RgbColor]$Background
    #     )
    #     $Properties = @{} + $PSBoundParameters
    #     foreach($key in @($Properties.Keys)) {
    #         if($Properties.$key -eq "" -or $Properties.$Key -eq $Null) {
    #             $null = $Properties.Remove($Key)
    #         }
    #     }
    #     [PSCustomObject]$Properties
    # }

    # foreach($section in "AfterChanges","AfterNoChanges","AheadBy","Before","BeforeChanges","BehindBy","Branch","Separator","StagedChanges","UnStagedChanges","NoStatus","Index","Working") {
    #     $config.$section = $config.$section | Clear-Config
    # }

    Export-Configuration $config
}

function Write-Text {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipelineByPropertyName=$true, Position=0)]
        [Alias("Content","text")]
        $Object,

        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [Alias("fg","Foreground")]
        $ForegroundColor,

        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [Alias("bg","Background")]
        $BackgroundColor
    )
    process {
        $Parameters = @{} + $PSBoundParameters
        $Null = $PSBoundParameters.GetEnumerator() | Where Value -eq $null | % { $Parameters.Remove($_.Key) }
        # Write-Debug ($Parameters | Out-String)
        Write-Host -NoNewLine @Parameters
    }
}

function Write-Status {
    [CmdletBinding()]
    param (
        $Status,
        $Config
    )
    end {
        if(!$Status) { $Status = Get-Status -WarningAction SilentlyContinue}
        if(!$Config) { $Config = Import-Configuration }

        if($Status -and $Config) {
            $config.Before | Write-Text
            $config.Branch | Write-Text
            $config.Branch | Write-Text ($Status.Branch + " ")
            if($Status.AheadBy -gt 0) {
                $config.AheadBy | Write-Text
                $config.AheadBy | Write-Text ($Status.AheadBy + " ")
            }
            if($Status.BehindBy -gt 0) {
                $config.BehindBy | Write-Text
                $config.BehindBy | Write-Text ($Status.BehindBy + " ")
            }

            $StagedChanges = @($Status.Changes | Where { $_.Staged })
            $UnStagedChanges = @($Status.Changes | Where { !$_.Staged })

            if(($StagedChanges.Length -gt 0 -or $UnStagedChanges.Length -gt 0) -and $config.BeforeChanges.Object) {
                $config.BeforeChanges | Write-Text
            }

            if(0 -ne $StagedChanges.Length) {
                $count = @($StagedChanges | Where { $_.Change -eq "Added" }).Length
                if(0 -lt $count -or !$config.HideZero) {
                    $config.StagedChanges | Write-Text "+$count "
                }
                $count = @($StagedChanges | Where { $_.Change -eq "Modified" }).Length
                if(0 -lt $count -or !$config.HideZero) {
                    $config.StagedChanges | Write-Text "~$count "
                }
                $count = @($StagedChanges | Where { $_.Change -eq "Removed" }).Length
                if(0 -lt $count -or !$config.HideZero) {
                    $config.StagedChanges | Write-Text "-$count "
                }
                $count = @($StagedChanges | Where { $_.Change -eq "Renamed" }).Length
                if(0 -lt $count -or !$config.HideZero) {
                    $config.StagedChanges | Write-Text "%$count "
                }
            }

            if(($StagedChanges.Length -gt 0 -and $UnStagedChanges.Length -gt 0) -and $config.Separator.Object) {
                $config.Separator | Write-Text
            }

            if(0 -ne $UnStagedChanges.Length) {
                $count = @($UnStagedChanges | Where { $_.Change -eq "Added" }).Length
                if(0 -lt $count -or !$config.HideZero) {
                    $config.UnStagedChanges | Write-Text "+$count "
                }
                $count = @($UnStagedChanges | Where { $_.Change -eq "Modified" }).Length
                if(0 -lt $count -or !$config.HideZero) {
                    $config.UnStagedChanges | Write-Text "~$count "
                }
                $count = @($UnStagedChanges | Where { $_.Change -eq "Removed" }).Length
                if(0 -lt $count -or !$config.HideZero) {
                    $config.UnStagedChanges | Write-Text "-$count "
                }
                $count = @($UnStagedChanges | Where { $_.Change -eq "Renamed" }).Length
                if(0 -lt $count -or !$config.HideZero) {
                    $config.UnStagedChanges | Write-Text "%$count "
                }
            }

            if(($StagedChanges.Length -gt 0 -or $UnStagedChanges.Length -gt 0) -and $config.AfterChanges.Object) {
                $config.AfterChanges | Write-Text
            }
            if(($StagedChanges.Length -eq 0 -and $UnStagedChanges.Length -eq 0) -and $config.AfterNoChanges.Object) {
                $config.AfterNoChanges | Write-Text
            }

        } else {
            $config.NoStatus | Write-Text
        }
    }
}

# This stuff leaks out on purpose
if(!(Test-Path Variable:Global:VcsPromptStatuses)) {
    $Global:VcsPromptStatuses = @()
}

function Global:Write-VcsStatus { $Global:VcsPromptStatuses | foreach { & $_ } }

# Add scriptblock that will execute for Write-VcsStatus
$Global:VcsPromptStatuses = @($Global:VcsPromptStatuses) + @({
    $WarningPreference, $WP = "SilentlyContinue", $WarningPreference
    Write-Status
    $WarningPreference = $WP
})

# but we don't want any duplicate hooks (if people import the module twice)
$Global:VcsPromptStatuses = @( $Global:VcsPromptStatuses | Select -Unique )

# SIG # Begin signature block
# MIIXzgYJKoZIhvcNAQcCoIIXvzCCF7sCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUzoX6cngRgAjY8GTP7v47nzVv
# JhugghMBMIID7jCCA1egAwIBAgIQfpPr+3zGTlnqS5p31Ab8OzANBgkqhkiG9w0B
# AQUFADCBizELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTEUMBIG
# A1UEBxMLRHVyYmFudmlsbGUxDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUVGhh
# d3RlIENlcnRpZmljYXRpb24xHzAdBgNVBAMTFlRoYXd0ZSBUaW1lc3RhbXBpbmcg
# Q0EwHhcNMTIxMjIxMDAwMDAwWhcNMjAxMjMwMjM1OTU5WjBeMQswCQYDVQQGEwJV
# UzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xMDAuBgNVBAMTJ1N5bWFu
# dGVjIFRpbWUgU3RhbXBpbmcgU2VydmljZXMgQ0EgLSBHMjCCASIwDQYJKoZIhvcN
# AQEBBQADggEPADCCAQoCggEBALGss0lUS5ccEgrYJXmRIlcqb9y4JsRDc2vCvy5Q
# WvsUwnaOQwElQ7Sh4kX06Ld7w3TMIte0lAAC903tv7S3RCRrzV9FO9FEzkMScxeC
# i2m0K8uZHqxyGyZNcR+xMd37UWECU6aq9UksBXhFpS+JzueZ5/6M4lc/PcaS3Er4
# ezPkeQr78HWIQZz/xQNRmarXbJ+TaYdlKYOFwmAUxMjJOxTawIHwHw103pIiq8r3
# +3R8J+b3Sht/p8OeLa6K6qbmqicWfWH3mHERvOJQoUvlXfrlDqcsn6plINPYlujI
# fKVOSET/GeJEB5IL12iEgF1qeGRFzWBGflTBE3zFefHJwXECAwEAAaOB+jCB9zAd
# BgNVHQ4EFgQUX5r1blzMzHSa1N197z/b7EyALt0wMgYIKwYBBQUHAQEEJjAkMCIG
# CCsGAQUFBzABhhZodHRwOi8vb2NzcC50aGF3dGUuY29tMBIGA1UdEwEB/wQIMAYB
# Af8CAQAwPwYDVR0fBDgwNjA0oDKgMIYuaHR0cDovL2NybC50aGF3dGUuY29tL1Ro
# YXd0ZVRpbWVzdGFtcGluZ0NBLmNybDATBgNVHSUEDDAKBggrBgEFBQcDCDAOBgNV
# HQ8BAf8EBAMCAQYwKAYDVR0RBCEwH6QdMBsxGTAXBgNVBAMTEFRpbWVTdGFtcC0y
# MDQ4LTEwDQYJKoZIhvcNAQEFBQADgYEAAwmbj3nvf1kwqu9otfrjCR27T4IGXTdf
# plKfFo3qHJIJRG71betYfDDo+WmNI3MLEm9Hqa45EfgqsZuwGsOO61mWAK3ODE2y
# 0DGmCFwqevzieh1XTKhlGOl5QGIllm7HxzdqgyEIjkHq3dlXPx13SYcqFgZepjhq
# IhKjURmDfrYwggSjMIIDi6ADAgECAhAOz/Q4yP6/NW4E2GqYGxpQMA0GCSqGSIb3
# DQEBBQUAMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3Jh
# dGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBTZXJ2aWNlcyBD
# QSAtIEcyMB4XDTEyMTAxODAwMDAwMFoXDTIwMTIyOTIzNTk1OVowYjELMAkGA1UE
# BhMCVVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBvcmF0aW9uMTQwMgYDVQQDEytT
# eW1hbnRlYyBUaW1lIFN0YW1waW5nIFNlcnZpY2VzIFNpZ25lciAtIEc0MIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAomMLOUS4uyOnREm7Dv+h8GEKU5Ow
# mNutLA9KxW7/hjxTVQ8VzgQ/K/2plpbZvmF5C1vJTIZ25eBDSyKV7sIrQ8Gf2Gi0
# jkBP7oU4uRHFI/JkWPAVMm9OV6GuiKQC1yoezUvh3WPVF4kyW7BemVqonShQDhfu
# ltthO0VRHc8SVguSR/yrrvZmPUescHLnkudfzRC5xINklBm9JYDh6NIipdC6Anqh
# d5NbZcPuF3S8QYYq3AhMjJKMkS2ed0QfaNaodHfbDlsyi1aLM73ZY8hJnTrFxeoz
# C9Lxoxv0i77Zs1eLO94Ep3oisiSuLsdwxb5OgyYI+wu9qU+ZCOEQKHKqzQIDAQAB
# o4IBVzCCAVMwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAO
# BgNVHQ8BAf8EBAMCB4AwcwYIKwYBBQUHAQEEZzBlMCoGCCsGAQUFBzABhh5odHRw
# Oi8vdHMtb2NzcC53cy5zeW1hbnRlYy5jb20wNwYIKwYBBQUHMAKGK2h0dHA6Ly90
# cy1haWEud3Muc3ltYW50ZWMuY29tL3Rzcy1jYS1nMi5jZXIwPAYDVR0fBDUwMzAx
# oC+gLYYraHR0cDovL3RzLWNybC53cy5zeW1hbnRlYy5jb20vdHNzLWNhLWcyLmNy
# bDAoBgNVHREEITAfpB0wGzEZMBcGA1UEAxMQVGltZVN0YW1wLTIwNDgtMjAdBgNV
# HQ4EFgQURsZpow5KFB7VTNpSYxc/Xja8DeYwHwYDVR0jBBgwFoAUX5r1blzMzHSa
# 1N197z/b7EyALt0wDQYJKoZIhvcNAQEFBQADggEBAHg7tJEqAEzwj2IwN3ijhCcH
# bxiy3iXcoNSUA6qGTiWfmkADHN3O43nLIWgG2rYytG2/9CwmYzPkSWRtDebDZw73
# BaQ1bHyJFsbpst+y6d0gxnEPzZV03LZc3r03H0N45ni1zSgEIKOq8UvEiCmRDoDR
# EfzdXHZuT14ORUZBbg2w6jiasTraCXEQ/Bx5tIB7rGn0/Zy2DBYr8X9bCT2bW+IW
# yhOBbQAuOA2oKY8s4bL0WqkBrxWcLC9JG9siu8P+eJRRw4axgohd8D20UaF5Mysu
# e7ncIAkTcetqGVvP6KUwVyyJST+5z3/Jvz4iaGNTmr1pdKzFHTx/kuDDvBzYBHUw
# ggUwMIIEGKADAgECAhAECRgbX9W7ZnVTQ7VvlVAIMA0GCSqGSIb3DQEBCwUAMGUx
# CzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3
# dy5kaWdpY2VydC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9v
# dCBDQTAeFw0xMzEwMjIxMjAwMDBaFw0yODEwMjIxMjAwMDBaMHIxCzAJBgNVBAYT
# AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
# dC5jb20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBDb2RlIFNp
# Z25pbmcgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQD407Mcfw4R
# r2d3B9MLMUkZz9D7RZmxOttE9X/lqJ3bMtdx6nadBS63j/qSQ8Cl+YnUNxnXtqrw
# nIal2CWsDnkoOn7p0WfTxvspJ8fTeyOU5JEjlpB3gvmhhCNmElQzUHSxKCa7JGnC
# wlLyFGeKiUXULaGj6YgsIJWuHEqHCN8M9eJNYBi+qsSyrnAxZjNxPqxwoqvOf+l8
# y5Kh5TsxHM/q8grkV7tKtel05iv+bMt+dDk2DZDv5LVOpKnqagqrhPOsZ061xPeM
# 0SAlI+sIZD5SlsHyDxL0xY4PwaLoLFH3c7y9hbFig3NBggfkOItqcyDQD2RzPJ6f
# pjOp/RnfJZPRAgMBAAGjggHNMIIByTASBgNVHRMBAf8ECDAGAQH/AgEAMA4GA1Ud
# DwEB/wQEAwIBhjATBgNVHSUEDDAKBggrBgEFBQcDAzB5BggrBgEFBQcBAQRtMGsw
# JAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBDBggrBgEFBQcw
# AoY3aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElE
# Um9vdENBLmNydDCBgQYDVR0fBHoweDA6oDigNoY0aHR0cDovL2NybDQuZGlnaWNl
# cnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENBLmNybDA6oDigNoY0aHR0cDov
# L2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENBLmNybDBP
# BgNVHSAESDBGMDgGCmCGSAGG/WwAAgQwKjAoBggrBgEFBQcCARYcaHR0cHM6Ly93
# d3cuZGlnaWNlcnQuY29tL0NQUzAKBghghkgBhv1sAzAdBgNVHQ4EFgQUWsS5eyoK
# o6XqcQPAYPkt9mV1DlgwHwYDVR0jBBgwFoAUReuir/SSy4IxLVGLp6chnfNtyA8w
# DQYJKoZIhvcNAQELBQADggEBAD7sDVoks/Mi0RXILHwlKXaoHV0cLToaxO8wYdd+
# C2D9wz0PxK+L/e8q3yBVN7Dh9tGSdQ9RtG6ljlriXiSBThCk7j9xjmMOE0ut119E
# efM2FAaK95xGTlz/kLEbBw6RFfu6r7VRwo0kriTGxycqoSkoGjpxKAI8LpGjwCUR
# 4pwUR6F6aGivm6dcIFzZcbEMj7uo+MUSaJ/PQMtARKUT8OZkDCUIQjKyNookAv4v
# cn4c10lFluhZHen6dGRrsutmQ9qzsIzV6Q3d9gEgzpkxYz0IGhizgZtPxpMQBvwH
# gfqL2vmCSfdibqFT+hKUGIUukpHqaGxEMrJmoecYpJpkUe8wggUwMIIEGKADAgEC
# AhAFmB+6PJIk/oqP7b4FPfHsMA0GCSqGSIb3DQEBCwUAMHIxCzAJBgNVBAYTAlVT
# MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j
# b20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBDb2RlIFNpZ25p
# bmcgQ0EwHhcNMTcwNjE0MDAwMDAwWhcNMTgwNjAxMTIwMDAwWjBtMQswCQYDVQQG
# EwJVUzERMA8GA1UECBMITmV3IFlvcmsxFzAVBgNVBAcTDldlc3QgSGVucmlldHRh
# MRgwFgYDVQQKEw9Kb2VsIEguIEJlbm5ldHQxGDAWBgNVBAMTD0pvZWwgSC4gQmVu
# bmV0dDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANALmLHevB7LvTmI
# p2oVErnz915fP1JUKoC+/5BRWUtAGooxg95jxX8+qT1yc02ZnkK7u1UyM0Mfs3b8
# MzhSqe5OkkQeT2RHrGe52+0/0ZWD68pvUBZoMQxrAnWJETjFO6IoXPKmoXN3zzpF
# +5s/UIbNGI5mdiN4v4F93Yaajzu2ymsJsXK6NgRh/AUbUzUlefpOas+o06wT0vqp
# LniGWw26321zJo//2QEo5PBrJvDDDIBBN6Xn5A2ww6v6fH2KGk2qf4vpr58rhDIH
# fLOHLg9s35effaktygUMQBCFmxOAbPLKWId8n5+O7zbMfKw3qxqCp2QeXhjkIh9v
# ETIX9pECAwEAAaOCAcUwggHBMB8GA1UdIwQYMBaAFFrEuXsqCqOl6nEDwGD5LfZl
# dQ5YMB0GA1UdDgQWBBQ8xh3xoTXbMfJUSyFBfPsrxoD8XzAOBgNVHQ8BAf8EBAMC
# B4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwdwYDVR0fBHAwbjA1oDOgMYYvaHR0cDov
# L2NybDMuZGlnaWNlcnQuY29tL3NoYTItYXNzdXJlZC1jcy1nMS5jcmwwNaAzoDGG
# L2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNvbS9zaGEyLWFzc3VyZWQtY3MtZzEuY3Js
# MEwGA1UdIARFMEMwNwYJYIZIAYb9bAMBMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8v
# d3d3LmRpZ2ljZXJ0LmNvbS9DUFMwCAYGZ4EMAQQBMIGEBggrBgEFBQcBAQR4MHYw
# JAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBOBggrBgEFBQcw
# AoZCaHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0U0hBMkFzc3Vy
# ZWRJRENvZGVTaWduaW5nQ0EuY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEL
# BQADggEBAGvlfIiin9JAyL16oeCNApnAWLfZpUBob4D+XLzdRJXidPq/pvNkE9Rg
# pRZFaWs30f2WPhWeqCpSCahoHzFsD5S9mOzsGTXsT+EdjAS0yEe1t9LfMvEC/pI3
# aBQJeJ/DdgpTMUEUJSvddc0P0NbDJ6TJC/niEMOJ8XvsfF75J4YVJ10yVNahbAuU
# MrRrRLe30pW74MRv1s7SKxwPmLhcsMQuK0mWGERtGYMwDHwW0ZdRHKNDGHRsl0Wh
# DS1P8+JRpE3eNFPcO17yiOfKDnVh+/1AOg7QopD6R6+P9rErorebsvW680s4WTlr
# hDcMsTOX0js2KFF6uT4nSojS4GNlSxExggQ3MIIEMwIBATCBhjByMQswCQYDVQQG
# EwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNl
# cnQuY29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQgQ29kZSBT
# aWduaW5nIENBAhAFmB+6PJIk/oqP7b4FPfHsMAkGBSsOAwIaBQCgeDAYBgorBgEE
# AYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwG
# CisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBSTQ6kZ
# Jo4wDdV9040tWPr9YzWZBzANBgkqhkiG9w0BAQEFAASCAQBKmpZZggZLQRkmw9+D
# R3A9Es685XdtII4B2uG9jLeZJYzKu6L0ChniIOJtJoM/xAAWH71EtLHY1XQmW1EL
# kORZ/x21nUBTRGkduFuBAqA7P2saKIYZSXCehJ4dtZPjAC9m2kCr9XJ+C2QQ9nTm
# ImUCjZY211gVqybgWwzODfF5aOFbReojOi1Za+c71hjwXRMA3MVSWdU6zaG2bsXV
# IvxhMpuH1RzdS6AARJWUeMFgnmPhQYcMV0hkAQWMXoDbrFVBS0rW67fB38HzN+Hz
# qRYRtl5ZawySRgRJsBAcOEDRmpx6dnAb1pD4S7agqGYL5mkpvzA6mev0ctKofWH9
# CswHoYICCzCCAgcGCSqGSIb3DQEJBjGCAfgwggH0AgEBMHIwXjELMAkGA1UEBhMC
# VVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBvcmF0aW9uMTAwLgYDVQQDEydTeW1h
# bnRlYyBUaW1lIFN0YW1waW5nIFNlcnZpY2VzIENBIC0gRzICEA7P9DjI/r81bgTY
# apgbGlAwCQYFKw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
# KoZIhvcNAQkFMQ8XDTE3MTExNzA3NTEzMFowIwYJKoZIhvcNAQkEMRYEFG3Li6JB
# wEWaQtezd/+Da6VwRfQiMA0GCSqGSIb3DQEBAQUABIIBABUPghBbjZCrqJAg7fdO
# Lv7No2TSazEm22T0pPM4B9Tq60oDY92enpUPkGdVGQ2WiTCRfuIITKkJv85HGe34
# XZqeCk/gIpumHpyo43dbl93red0YPKYaksXyQ5JBnB77iicDi2kWw0TRoNPlg1xP
# 1Ok/UmHSh3BNnZ/SEXGkMY6Ndut0yLnX5ITAI7fkdWXDP1MnRFQZ+BH0QVjWsDuI
# EBYuG/HTU0UisLzfJT+d3sYZPt45r8QJpWpEoryzmB19nijp8KMB9Vy46ZFT9bIW
# OFSsLQvR58iKjW9lTDkfoIDq1a9oAuOXcBvKGfgN8JDYzLpEnsH9d1pTZqDSfJ7c
# 3Cs=
# SIG # End signature block
