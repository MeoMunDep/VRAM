
@echo off
title Vram Bot by @MeoMunDep
color 0A

cd %~dp0

echo Checking for bot updates...
git pull origin main > nul 2>&1
echo Bot updated!

echo Checking configuration files...

if not exist configs.json (
    echo {> configs.json
    echo   "delayEachWallets": [10, 30],>> configs.json
    echo   "loopEachWallets": [10, 30],>> configs.json
    echo   "timeToRestartAllAccounts": 86400,>> configs.json
    echo.>> configs.json
    echo   "createAgent": {>> configs.json
    echo     "enabled": false,>> configs.json
    echo     "requiredVram": 400000000,>> configs.json
    echo     "devTokenAmount": 1000,>> configs.json
    echo     "amount": [1, 2]>> configs.json
    echo   },>> configs.json
    echo.>> configs.json
    echo   "buyTokens": {>> configs.json
    echo     "enabled": true,>> configs.json
    echo     "amount": [10, 20]>> configs.json
    echo   },>> configs.json
    echo.>> configs.json
    echo   "sellTokens": {>> configs.json
    echo     "enabled": true>> configs.json
    echo   },>> configs.json
    echo.>> configs.json
    echo   "sellAllTokensToVRAM": true,>> configs.json
    echo   "chatWithAgent": {>> configs.json
    echo     "enabled": true,>> configs.json
    echo     "amount": [10, 20]>> configs.json
    echo   },>> configs.json
    echo.>> configs.json
    echo   "MIN_VRAM_BALANCE": 1000000000,>> configs.json
    echo   "GAS_BUDGET": 10000000,>> configs.json
    echo.>> configs.json
    echo   "TOKENS": {}>> configs.json
    echo }>> configs.json
    echo Created configs.json
)



(for %%F in (privateKeys.txt proxies.txt) do (
    if not exist %%F (
        type nul > %%F
        echo Created %%F
    )
))

echo Configuration files checked.

echo Checking dependencies...
if exist "..\node_modules" (
    echo Using node_modules from parent directory...
    cd ..
    CALL npm install user-agents axios meo-forkcy-colors meo-forkcy-utils meo-forkcy-proxy meo-forkcy-logger @mysten/sui
    cd %~dp0
) else (
    echo Installing dependencies in current directory...
    CALL npm install user-agents axios meo-forkcy-colors meo-forkcy-utils meo-forkcy-proxy meo-forkcy-logger @mysten/sui
)
echo Dependencies installation completed!

echo Starting the bot...
node meomundep

pause
exit
