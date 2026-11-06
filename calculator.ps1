# 간단한 터미널 콘솔 계산기 (PowerShell)
# 실행 방법: powershell -ExecutionPolicy Bypass -File .\calculator.ps1

function Show-Header {
    Clear-Host
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "         간단한 콘솔 계산기               " -ForegroundColor Yellow
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host " 지원 연산자: +, -, *, /, %               "
    Write-Host " 'q' 또는 'exit'를 입력하면 종료됩니다.   "
    Write-Host " 'cls'를 입력하면 화면을 지웁니다.        "
    Write-Host "------------------------------------------"
}

Show-Header

while ($true) {
    $inputStr = Read-Host "`n수식 입력 (예: 12 + 4 * 3 또는 10 / 2)"
    $trimmed = $inputStr.Trim()

    if ($trimmed -eq 'q' -or $trimmed -eq 'exit') {
        Write-Host "`n계산기를 종료합니다. 감사합니다!" -ForegroundColor Green
        break
    }

    if ($trimmed -eq 'cls' -or $trimmed -eq 'clear') {
        Show-Header
        continue
    }

    if ([string]::IsNullOrWhiteSpace($trimmed)) {
        continue
    }

    # 허용된 문자(숫자, 사칙연산자, 소수점, 괄호, 공백)만 검증하여 안전하게 계산
    if ($trimmed -notmatch '^[\d\s\+\-\*\/\%\.\(\)]+$') {
        Write-Host "오류: 잘못된 문자가 포함되어 있습니다. 숫자와 연산자만 입력해주세요." -ForegroundColor Red
        continue
    }

    try {
        # 0으로 나누기 검사
        if ($trimmed -match '/\s*0(?!\d)') {
            Write-Host "오류: 0으로 나눌 수 없습니다." -ForegroundColor Red
            continue
        }

        # 수식 계산
        $result = Invoke-Expression $trimmed
        Write-Host "결과: " -NoNewline -ForegroundColor Green
        Write-Host "$result" -ForegroundColor White
    }
    catch {
        Write-Host "계산 중 오류가 발생했습니다: $($_.Exception.Message)" -ForegroundColor Red
    }
}

