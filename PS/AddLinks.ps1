param([string]$IFILE="")


###############################################################
$before = @(Get-Process [e]xcel | %{$_.Id})
$Excel = New-Object -comobject Excel.Application
$ExcelId = Get-Process excel | %{$_.Id} | ?{$before -notcontains $_}

if( Test-Path -path $IFILE){
    
    $Excel.Displayalerts = $False
    $WorkBook=$Excel.WorkBooks.Open($IFILE)
    
    $Ws = $Excel.worksheets.Add([System.Reflection.Missing]::Value,
			    $Excel.Worksheets.Item($Excel.Worksheets.count))
    $Ws.name = "TOC"
    $Ws.activate()
    
    clear-host
    ##Main Loop
    $rCtr = 1
    $total = $Excel.Worksheets.count
    
    foreach( $tws in $WorkBook.WorkSheets){
	#write-host $tws.name
    
	$f = $Ws.Hyperlinks.Add( $Ws.Cells.Item($rCtr,1) ,"" , $tws.name+ "!A1" , "", " " + $tws.name)

	$percents = [math]::round((($rCtr/$total) * 100), 0)
	$txt = "Creating TOC"
	Write-Progress -Activity:$txt -Status:"Created $rCtr of $total  total lines ($percents%)" -PercentComplete:$percents
	
	$rCtr++
    }
}
else{
    write-host "No Sych File " $IFILE
}

#Close WorkBooks
#$Nwb.SaveAs($OFILE)
#$Nwb.Close($False)
$WorkBook.Save()
$Workbook.Close($False) 

$Excel.Quit()

[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Excel)
Remove-Variable -Name Excel
[gc]::collect()
[gc]::WaitForPendingFinalizers()
Stop-Process -Id $ExcelId -Force -ErrorAction SilentlyContinue