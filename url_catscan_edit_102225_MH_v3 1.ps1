# PowerShell script to test URL access by category, mimic browser headers, and export results to Excel
# Requires: PowerShell 5+, ImportExcel module (Install-Module -Name ImportExcel)

# Define Zscaler block signature
$ZSCALER_BLOCK_SIGNATURE = "request forbidden by administrative rules"

# Initialize results array
$allDetails = @()

# Define URL categories and URLs
$URL_CATEGORIES_TO_TEST = @{
    "ENTERTAINMENT" = @("www.hollywood.com", "www.sydneyoperahouse.com")
    "MUSIC" = @("www.itunes.com", "www.spotify.com")
    "OTHER_ENTERTAINMENT_AND_RECREATION" = @("rockcreekrvpark.com", "destinywateradventures.com")
    "RADIO_STATIONS" = @("radioducinema.com", "statsradio.com")
    "TELEVISION_AND_MOVIES" = @("imdb.com", "movies.com")
    "STREAMING_MEDIA" = @("netflix.com", "hotstar.com")
    "NEWS_AND_MEDIA" = @("www.cnn.com", "www.asiaone.com")
    "CLASSIFIEDS" = @("www.st701.com", "www.gumtree.com")
    "CORPORATE_MARKETING" = @("www.billabong.com", "www.crocs.com")
    "FINANCE" = @("www.hsbc.com", "www.citibank.com")
    "INSURANCE" = @("www.tataaig.com", "www.unitedhealthgroup.com")
    "TRADING_BROKARAGE_INSURANCE" = @("ameritrade.com", "etrade.com")
    "OTHER_BUSINESS_AND_ECONOMY" = @("etrind.com.br", "dfsafrica.org")
    "PROFESSIONAL_SERVICES" = @("www.micematters.com", "www.issworld.com")
    "CONTINUING_EDUCATION_COLLEGES" = @("www.duke.edu", "www.ox.ac.uk")
    "HISTORY" = @("www.hyperhistory.com", "www.besthistorysites.net")
    "K_12" = @("www.k12.com", "www.ilacademy.net")
    "OTHER_EDUCATION" = @("www.writework.com")
    "REFERENCE_SITES" = @("en.wikipedia.org", "www.dictionary.com")
    "SCIENCE_AND_TECHNOLOGY" = @("www.scitechdaily.com", "www.livescience.com")
    "WEB_BANNERS" = @("www.buysellads.com", "www.fusionads.net")
    "AI_ML_APP" = @("www.openai.com", "bard.google.com")
    "CDN" = @("cdn.espn.com", "bighost.be")
    "DEVELOPER_TOOLS" = @("rubyonrails.org", "github.com")
    "DNS_OVER_HTTPS" = @("dns.google/dns-query", "cloudflare-dns.com/dns-query")
    "FILE_CONVERTORS" = @("www.freepdfconvert.com", "www.freeconvert.com")
    "FILE_HOST" = @("www.yousendit.com", "www.rapidshare.com")
    "GENERAL_AI_ML" = @("aimagazine.com", "www.aitrends.com")
    "IMAGE_HOST" = @("www.flickr.com", "www.kodakgallery.com")
    "OSS_UPDATES" = @("swcdn.apple.com", "windowsupdate.microsoft.com")
    "OTHER_INFORMATION_TECHNOLOGY" = @("kwonnam.pe.kr", "bellsouthemailsettings.com")
    "PORTALS" = @("qq.com", "naver.com")
    "SAFE_SEARCH_ENGINE" = @("www.safesearchkids.com", "fragfinn.de")
    "SHAREWARE_DOWNLOAD" = @("www.download.cnet.com", "www.filehippo.com")
    "TRANSLATORS" = @("translate.google.com", "www.freetranslation.com")
    "WEB_HOST" = @("www.siteground.com", "www.myown.eu")
    "WEB_SEARCH" = @("www.google.com", "www.yahoo.com")
    "BLOG" = @("www.blogger.com", "onlinejournalismblog.com")
    "DISCUSSION_FORUMS" = @("www.cellar.org", "www.wsc-forum.de")
    "INTERNET_SERVICES" = @("www.singnet.com.sg", "www.imagin.com")
    "ONLINE_CHAT" = @("finnchat.com", "msngr.com")
    "OTHER_INTERNET_COMMUNICATION" = @("softyupdates.com", "ipixo.com")
    "P2P_COMMUNICATION" = @("www.bittorrent.com", "www.limewire.com")
    "REMOTE_ACCESS" = @("www.teamviewer.com", "www.logmein.com")
    "WEB_CONFERENCING" = @("www.webex.com", "www.zoom.us")
    "EMAIL_HOST" = @("mail.google.com", "www.hotmail.com")
    "JOB_SEARCH" = @("www.monster.com", "www.kellyservices.com")
    "GLOBAL_INT_OFC365_ALLOW" = @("smtp.office365.com")
    "GLOBAL_INT_OFC365_DEFAULT" = @("ssw.live.com", "storage.live.com")
    "GLOBAL_INT_OFC365_OPTIMIZE" = @("outlook.office.com", "outlook.office365.com")
    "GOVERNMENT" = @("www.usa.gov", "www.gov.sg")
    "MILITARY" = @("www.af.mil", "www.army.mil")
    "OTHER_GOVERNMENT_AND_POLITICS" = @("wec24.org", "covid-sb.org")
    "POLITICS" = @("www.nrsc.org", "www.pap.org.sg")
    "TRAVEL" = @("www.contiki.com", "www.singaporeair.com")
    "VEHICLES" = @("www.toyota.com", "www.volkswagen.com")
    "ADULT_SEX_EDUCATION" = @("www.sexedlibrary.org", "www.itsyoursexlife.com")
    "ADULT_THEMES" = @("www.truveo.com", "www.singlebrides.com")
    "SEXUALITY" = @("kicktattoo.com", "tattoogrid.net")
    "K_12_SEX_EDUCATION" = @("www.teensource.org", "www.sexetc.org")
    "LINGERIE_BIKINI" = @("www.wacoal.com", "www.victoriassecret.com")
    "NUDITY" = @("www.nudes-a-poppin.com", "www.nudistportal.com")
}

# Function to test category access
function Test-CategoryAccess {
    param(
        [string]$Category,
        [array]$Urls
    )
    
    Write-Host "Testing category: $Category"
    
    foreach ($urlRaw in $Urls) {
        $url = $urlRaw
        $status = ""
        $statusCode = $null
        $notes = ""
        
        try {
            # Normalize URL to HTTPS
            if (-not ($url -match '^https?://')) {
                $url = "https://$url"
            } elseif ($url -match '^http://') {
                $url = $url -replace '^http://', 'https://'
            }
            
            # Create headers to mimic browser
            $headers = @{
                "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                "Accept" = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                "Accept-Language" = "en-US,en;q=0.5"
                "Accept-Encoding" = "gzip, deflate, br"
                "Connection" = "keep-alive"
                "Upgrade-Insecure-Requests" = "1"
            }
            
            # Make the web request
            $response = Invoke-WebRequest -Uri $url -Headers $headers -TimeoutSec 10 -UseBasicParsing -ErrorAction Stop
            $statusCode = $response.StatusCode
            
            # Check for Zscaler block signature
            if ($response.Content -match [regex]::Escape($ZSCALER_BLOCK_SIGNATURE)) {
                $status = "Blocked"
                $notes = "Zscaler block signature detected"
            } elseif ($response.StatusCode -eq 200) {
                $status = "Allowed"
                $notes = "Status code: 200 OK"
            } elseif ($response.StatusCode -ge 300 -and $response.StatusCode -lt 400) {
                $status = "Possibly Blocked"
                $notes = "Status code: $($response.StatusCode) - Redirect (resource moved or further action required)"
            } elseif ($response.StatusCode -ge 400 -and $response.StatusCode -lt 500) {
                $status = "Possibly Blocked"
                $notes = "Status code: $($response.StatusCode) - Client Error (invalid or unauthorized request)"
            } elseif ($response.StatusCode -ge 500 -and $response.StatusCode -lt 600) {
                $status = "Possibly Blocked"
                $notes = "Status code: $($response.StatusCode) - Server Error (server failed to fulfill request)"
            } else {
                $status = "Possibly Blocked"
                $notes = "Status code: $($response.StatusCode) - Other/Unknown response code"
            }
        } catch {
            $status = "Timeout / Connection Error"
            $statusCode = if ($_.Exception.Response) { [int]$_.Exception.Response.StatusCode.value__ } else { $null }
            $notes = $_.Exception.Message
        }
        
        # Add result to collection
        $script:allDetails += [PSCustomObject]@{
            Category = $Category
            URL = $url
            Status = $status
            StatusCode = $statusCode
            Notes = $notes
        }
        
        Write-Host "  $url - $status"
        Start-Sleep -Seconds 1
    }
}

# Main logic
Write-Host "Starting URL accessibility test..."
Write-Host "Total categories to test: $($URL_CATEGORIES_TO_TEST.Count)"
Write-Host ""

foreach ($category in $URL_CATEGORIES_TO_TEST.Keys) {
    Test-CategoryAccess -Category $category -Urls $URL_CATEGORIES_TO_TEST[$category]
}

Write-Host ""
Write-Host "Testing complete. Total URLs tested: $($allDetails.Count)"
Write-Host ""

# Export to Excel if ImportExcel module is available, else CSV
if (Get-Module -ListAvailable -Name ImportExcel) {
    $allDetails | Export-Excel -Path "zscaler_url_results.xlsx" -AutoSize -BoldTopRow -FreezeTopRow -TableName Results
    Write-Host "Results exported to zscaler_url_results.xlsx"
} else {
    $allDetails | Export-Csv -Path "zscaler_url_results.csv" -NoTypeInformation -Encoding UTF8
    Write-Host "ImportExcel module not found. Results exported to zscaler_url_results.csv instead."
    Write-Host "To export to Excel, run: Install-Module -Name ImportExcel"
}
