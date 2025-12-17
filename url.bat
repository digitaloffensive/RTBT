@echo off
REM Batch file to test URL access by category and export results to CSV
REM This uses curl (built into Windows 10+) to test URL accessibility
REM Results are saved to zscaler_url_results.csv

setlocal enabledelayedexpansion

set OUTPUT_FILE=zscaler_url_results.csv
set TEMP_FILE=temp_result.txt
set ZSCALER_SIGNATURE=request forbidden by administrative rules

REM Initialize CSV file with headers
echo Category,URL,Status,StatusCode,Notes > "%OUTPUT_FILE%"

echo Starting URL accessibility test...
echo.

REM Test ENTERTAINMENT
call :TestURL "ENTERTAINMENT" "https://www.hollywood.com"
call :TestURL "ENTERTAINMENT" "https://www.sydneyoperahouse.com"

REM Test MUSIC
call :TestURL "MUSIC" "https://www.itunes.com"
call :TestURL "MUSIC" "https://www.spotify.com"

REM Test OTHER_ENTERTAINMENT_AND_RECREATION
call :TestURL "OTHER_ENTERTAINMENT_AND_RECREATION" "https://rockcreekrvpark.com"
call :TestURL "OTHER_ENTERTAINMENT_AND_RECREATION" "https://destinywateradventures.com"

REM Test RADIO_STATIONS
call :TestURL "RADIO_STATIONS" "https://radioducinema.com"
call :TestURL "RADIO_STATIONS" "https://statsradio.com"

REM Test TELEVISION_AND_MOVIES
call :TestURL "TELEVISION_AND_MOVIES" "https://imdb.com"
call :TestURL "TELEVISION_AND_MOVIES" "https://movies.com"

REM Test STREAMING_MEDIA
call :TestURL "STREAMING_MEDIA" "https://netflix.com"
call :TestURL "STREAMING_MEDIA" "https://hotstar.com"

REM Test NEWS_AND_MEDIA
call :TestURL "NEWS_AND_MEDIA" "https://www.cnn.com"
call :TestURL "NEWS_AND_MEDIA" "https://www.asiaone.com"

REM Test CLASSIFIEDS
call :TestURL "CLASSIFIEDS" "https://www.st701.com"
call :TestURL "CLASSIFIEDS" "https://www.gumtree.com"

REM Test CORPORATE_MARKETING
call :TestURL "CORPORATE_MARKETING" "https://www.billabong.com"
call :TestURL "CORPORATE_MARKETING" "https://www.crocs.com"

REM Test FINANCE
call :TestURL "FINANCE" "https://www.hsbc.com"
call :TestURL "FINANCE" "https://www.citibank.com"

REM Test INSURANCE
call :TestURL "INSURANCE" "https://www.tataaig.com"
call :TestURL "INSURANCE" "https://www.unitedhealthgroup.com"

REM Test TRADING_BROKARAGE_INSURANCE
call :TestURL "TRADING_BROKARAGE_INSURANCE" "https://ameritrade.com"
call :TestURL "TRADING_BROKARAGE_INSURANCE" "https://etrade.com"

REM Test OTHER_BUSINESS_AND_ECONOMY
call :TestURL "OTHER_BUSINESS_AND_ECONOMY" "https://etrind.com.br"
call :TestURL "OTHER_BUSINESS_AND_ECONOMY" "https://dfsafrica.org"

REM Test PROFESSIONAL_SERVICES
call :TestURL "PROFESSIONAL_SERVICES" "https://www.micematters.com"
call :TestURL "PROFESSIONAL_SERVICES" "https://www.issworld.com"

REM Test CONTINUING_EDUCATION_COLLEGES
call :TestURL "CONTINUING_EDUCATION_COLLEGES" "https://www.duke.edu"
call :TestURL "CONTINUING_EDUCATION_COLLEGES" "https://www.ox.ac.uk"

REM Test HISTORY
call :TestURL "HISTORY" "https://www.hyperhistory.com"
call :TestURL "HISTORY" "https://www.besthistorysites.net"

REM Test K_12
call :TestURL "K_12" "https://www.k12.com"
call :TestURL "K_12" "https://www.ilacademy.net"

REM Test OTHER_EDUCATION
call :TestURL "OTHER_EDUCATION" "https://www.writework.com"

REM Test REFERENCE_SITES
call :TestURL "REFERENCE_SITES" "https://en.wikipedia.org"
call :TestURL "REFERENCE_SITES" "https://www.dictionary.com"

REM Test SCIENCE_AND_TECHNOLOGY
call :TestURL "SCIENCE_AND_TECHNOLOGY" "https://www.scitechdaily.com"
call :TestURL "SCIENCE_AND_TECHNOLOGY" "https://www.livescience.com"

REM Test WEB_BANNERS
call :TestURL "WEB_BANNERS" "https://www.buysellads.com"
call :TestURL "WEB_BANNERS" "https://www.fusionads.net"

REM Test AI_ML_APP
call :TestURL "AI_ML_APP" "https://www.openai.com"
call :TestURL "AI_ML_APP" "https://bard.google.com"

REM Test CDN
call :TestURL "CDN" "https://cdn.espn.com"
call :TestURL "CDN" "https://bighost.be"

REM Test DEVELOPER_TOOLS
call :TestURL "DEVELOPER_TOOLS" "https://rubyonrails.org"
call :TestURL "DEVELOPER_TOOLS" "https://github.com"

REM Test DNS_OVER_HTTPS
call :TestURL "DNS_OVER_HTTPS" "https://dns.google/dns-query"
call :TestURL "DNS_OVER_HTTPS" "https://cloudflare-dns.com/dns-query"

REM Test FILE_CONVERTORS
call :TestURL "FILE_CONVERTORS" "https://www.freepdfconvert.com"
call :TestURL "FILE_CONVERTORS" "https://www.freeconvert.com"

REM Test FILE_HOST
call :TestURL "FILE_HOST" "https://www.yousendit.com"
call :TestURL "FILE_HOST" "https://www.rapidshare.com"

REM Test GENERAL_AI_ML
call :TestURL "GENERAL_AI_ML" "https://aimagazine.com"
call :TestURL "GENERAL_AI_ML" "https://www.aitrends.com"

REM Test IMAGE_HOST
call :TestURL "IMAGE_HOST" "https://www.flickr.com"
call :TestURL "IMAGE_HOST" "https://www.kodakgallery.com"

REM Test OSS_UPDATES
call :TestURL "OSS_UPDATES" "https://swcdn.apple.com"
call :TestURL "OSS_UPDATES" "https://windowsupdate.microsoft.com"

REM Test OTHER_INFORMATION_TECHNOLOGY
call :TestURL "OTHER_INFORMATION_TECHNOLOGY" "https://kwonnam.pe.kr"
call :TestURL "OTHER_INFORMATION_TECHNOLOGY" "https://bellsouthemailsettings.com"

REM Test PORTALS
call :TestURL "PORTALS" "https://qq.com"
call :TestURL "PORTALS" "https://naver.com"

REM Test SAFE_SEARCH_ENGINE
call :TestURL "SAFE_SEARCH_ENGINE" "https://www.safesearchkids.com"
call :TestURL "SAFE_SEARCH_ENGINE" "https://fragfinn.de"

REM Test SHAREWARE_DOWNLOAD
call :TestURL "SHAREWARE_DOWNLOAD" "https://www.download.cnet.com"
call :TestURL "SHAREWARE_DOWNLOAD" "https://www.filehippo.com"

REM Test TRANSLATORS
call :TestURL "TRANSLATORS" "https://translate.google.com"
call :TestURL "TRANSLATORS" "https://www.freetranslation.com"

REM Test WEB_HOST
call :TestURL "WEB_HOST" "https://www.siteground.com"
call :TestURL "WEB_HOST" "https://www.myown.eu"

REM Test WEB_SEARCH
call :TestURL "WEB_SEARCH" "https://www.google.com"
call :TestURL "WEB_SEARCH" "https://www.yahoo.com"

REM Test BLOG
call :TestURL "BLOG" "https://www.blogger.com"
call :TestURL "BLOG" "https://onlinejournalismblog.com"

REM Test DISCUSSION_FORUMS
call :TestURL "DISCUSSION_FORUMS" "https://www.cellar.org"
call :TestURL "DISCUSSION_FORUMS" "https://www.wsc-forum.de"

REM Test INTERNET_SERVICES
call :TestURL "INTERNET_SERVICES" "https://www.singnet.com.sg"
call :TestURL "INTERNET_SERVICES" "https://www.imagin.com"

REM Test ONLINE_CHAT
call :TestURL "ONLINE_CHAT" "https://finnchat.com"
call :TestURL "ONLINE_CHAT" "https://msngr.com"

REM Test OTHER_INTERNET_COMMUNICATION
call :TestURL "OTHER_INTERNET_COMMUNICATION" "https://softyupdates.com"
call :TestURL "OTHER_INTERNET_COMMUNICATION" "https://ipixo.com"

REM Test P2P_COMMUNICATION
call :TestURL "P2P_COMMUNICATION" "https://www.bittorrent.com"
call :TestURL "P2P_COMMUNICATION" "https://www.limewire.com"

REM Test REMOTE_ACCESS
call :TestURL "REMOTE_ACCESS" "https://www.teamviewer.com"
call :TestURL "REMOTE_ACCESS" "https://www.logmein.com"

REM Test WEB_CONFERENCING
call :TestURL "WEB_CONFERENCING" "https://www.webex.com"
call :TestURL "WEB_CONFERENCING" "https://www.zoom.us"

REM Test EMAIL_HOST
call :TestURL "EMAIL_HOST" "https://mail.google.com"
call :TestURL "EMAIL_HOST" "https://www.hotmail.com"

REM Test JOB_SEARCH
call :TestURL "JOB_SEARCH" "https://www.monster.com"
call :TestURL "JOB_SEARCH" "https://www.kellyservices.com"

REM Test GLOBAL_INT_OFC365_ALLOW
call :TestURL "GLOBAL_INT_OFC365_ALLOW" "https://smtp.office365.com"

REM Test GLOBAL_INT_OFC365_DEFAULT
call :TestURL "GLOBAL_INT_OFC365_DEFAULT" "https://ssw.live.com"
call :TestURL "GLOBAL_INT_OFC365_DEFAULT" "https://storage.live.com"

REM Test GLOBAL_INT_OFC365_OPTIMIZE
call :TestURL "GLOBAL_INT_OFC365_OPTIMIZE" "https://outlook.office.com"
call :TestURL "GLOBAL_INT_OFC365_OPTIMIZE" "https://outlook.office365.com"

REM Test GOVERNMENT
call :TestURL "GOVERNMENT" "https://www.usa.gov"
call :TestURL "GOVERNMENT" "https://www.gov.sg"

REM Test MILITARY
call :TestURL "MILITARY" "https://www.af.mil"
call :TestURL "MILITARY" "https://www.army.mil"

REM Test OTHER_GOVERNMENT_AND_POLITICS
call :TestURL "OTHER_GOVERNMENT_AND_POLITICS" "https://wec24.org"
call :TestURL "OTHER_GOVERNMENT_AND_POLITICS" "https://covid-sb.org"

REM Test POLITICS
call :TestURL "POLITICS" "https://www.nrsc.org"
call :TestURL "POLITICS" "https://www.pap.org.sg"

REM Test TRAVEL
call :TestURL "TRAVEL" "https://www.contiki.com"
call :TestURL "TRAVEL" "https://www.singaporeair.com"

REM Test VEHICLES
call :TestURL "VEHICLES" "https://www.toyota.com"
call :TestURL "VEHICLES" "https://www.volkswagen.com"

REM Test ADULT_SEX_EDUCATION
call :TestURL "ADULT_SEX_EDUCATION" "https://www.sexedlibrary.org"
call :TestURL "ADULT_SEX_EDUCATION" "https://www.itsyoursexlife.com"

REM Test ADULT_THEMES
call :TestURL "ADULT_THEMES" "https://www.truveo.com"
call :TestURL "ADULT_THEMES" "https://www.singlebrides.com"

REM Test SEXUALITY
call :TestURL "SEXUALITY" "https://kicktattoo.com"
call :TestURL "SEXUALITY" "https://tattoogrid.net"

REM Test K_12_SEX_EDUCATION
call :TestURL "K_12_SEX_EDUCATION" "https://www.teensource.org"
call :TestURL "K_12_SEX_EDUCATION" "https://www.sexetc.org"

REM Test LINGERIE_BIKINI
call :TestURL "LINGERIE_BIKINI" "https://www.wacoal.com"
call :TestURL "LINGERIE_BIKINI" "https://www.victoriassecret.com"

REM Test NUDITY
call :TestURL "NUDITY" "https://www.nudes-a-poppin.com"
call :TestURL "NUDITY" "https://www.nudistportal.com"

echo.
echo Testing complete!
echo Results saved to %OUTPUT_FILE%
echo.
pause
goto :eof

:TestURL
set CATEGORY=%~1
set URL=%~2
set STATUS=Unknown
set STATUS_CODE=
set NOTES=

echo Testing: %CATEGORY% - %URL%

REM Use curl to test URL (with browser-like headers and follow redirects)
curl -s -o "%TEMP_FILE%" -w "%%{http_code}" -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" -H "Accept-Language: en-US,en;q=0.5" --connect-timeout 10 --max-time 15 -L "%URL%" > temp_code.txt 2>nul

if exist temp_code.txt (
    set /p STATUS_CODE=<temp_code.txt
    
    REM Check for Zscaler block signature
    findstr /i /c:"%ZSCALER_SIGNATURE%" "%TEMP_FILE%" >nul 2>&1
    if !errorlevel! equ 0 (
        set STATUS=Blocked
        set NOTES=Zscaler block signature detected
    ) else if "!STATUS_CODE!"=="200" (
        set STATUS=Allowed
        set NOTES=Status code: 200 OK
    ) else if "!STATUS_CODE:~0,1!"=="3" (
        set STATUS=Possibly Blocked
        set NOTES=Status code: !STATUS_CODE! - Redirect
    ) else if "!STATUS_CODE:~0,1!"=="4" (
        set STATUS=Possibly Blocked
        set NOTES=Status code: !STATUS_CODE! - Client Error
    ) else if "!STATUS_CODE:~0,1!"=="5" (
        set STATUS=Possibly Blocked
        set NOTES=Status code: !STATUS_CODE! - Server Error
    ) else if "!STATUS_CODE!"=="000" (
        set STATUS=Connection Error
        set NOTES=Could not connect to URL
    ) else (
        set STATUS=Unknown
        set NOTES=Status code: !STATUS_CODE!
    )
) else (
    set STATUS=Timeout / Connection Error
    set STATUS_CODE=000
    set NOTES=curl failed to execute or timed out
)

REM Write result to CSV (escape commas in notes)
set NOTES=!NOTES:,= !
echo %CATEGORY%,%URL%,%STATUS%,!STATUS_CODE!,!NOTES! >> "%OUTPUT_FILE%"

REM Cleanup temp files
if exist "%TEMP_FILE%" del "%TEMP_FILE%" >nul 2>&1
if exist temp_code.txt del temp_code.txt >nul 2>&1

REM Small delay between requests
timeout /t 1 /nobreak >nul

goto :eof
