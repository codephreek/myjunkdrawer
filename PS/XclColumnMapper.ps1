param([string]$DFILE_NAME="",
      [int]$DTB_IDX="",
      [int]$DWS_MAP_COL="",
      [int]$DWS_W_COL="",
      [string]$SFILE_NAME="",
      [int]$STB_IDX="",
      [int]$SWS_MAP_COL="",
      [int]$SWS_R_COL="")

###############################################################
$before = @(Get-Process [e]xcel | %{$_.Id})
$Excel = New-Object -comobject Excel.Application
$ExcelId = Get-Process excel | %{$_.Id} | ?{$before -notcontains $_}

#write-host $PSBoundParameters

if($DFILE_NAME -eq "h" -or $DFILE_NAME -eq "help" -or $DFILE_NAME -eq "?"){
    write-host " USAGE:  

<dest-file> <dest-tab-index> <dest-map-col> <dest-idx-col> <src-file> <src-tab-index> <src-map-col> <src-idx-col>

"
    write-host " WHERE:
   
dest-file      = The Destination file (template excel file)
dest-tab-index = The tab number in the destination file where we will write data
dest-map-col   = The column continaing the mapping value (Xref for src-map-col) 
dest-idx-col   = The value column (column to write value)

src-file       = The source file (exported excel file)
src-tab-index  = The tab number in the source file where the data exists
src-map-col    = The column containing the mapping value (Xref for dest-map-col)
src-idx-col    = The value column (column to read value)"
}
else{
    if((Test-Path -path $SFILE_NAME)){
	write-host $SFILE_NAME
	write-host $SWS_NAME
	
	$Excel.Displayalerts = $False
	$WorkBook=$Excel.WorkBooks.Open($SFILE_NAME)
	$MainDataSheet = $Workbook.Worksheets.Item($STB_IDX)
	
	$LastRowUsed = $MainDataSheet.UsedRange.Rows.Count
	
	#Create Hash Table
	$hashT = @{"default" = -1}
	clear-host
	for($row = 2;$row -le $LastRowUsed; $row++){
	    $id = $MainDataSheet.cells.item($row,$SWS_R_COL).value()
	    $u_name = $MainDataSheet.cells.item($row,$SWS_MAP_COL).value()
	    $hashT.add($u_name,$id)

	    $percents = [math]::round((($row/$LastRowUsed) * 100), 0)
	    Write-Progress -Activity:"Creating hash table" -Status:"($percents%) complete" -PercentComplete:$percents
	}
	##write-host ($hashT | out-string)
	##write-host $hashT.Get_Item("u_ph")
	
	$Workbook.Close($False)
	
	$WorkBook=$Excel.WorkBooks.Open($DFILE_NAME)
	$MainDataSheet = $Workbook.Worksheets.Item($DTB_IDX)
	
	$LastRowUsed = $MainDataSheet.UsedRange.Rows.Count
	for($row = 2;$row -le $LastRowUsed; $row++){
	    $u_name = $MainDataSheet.cells.item($row,$DWS_MAP_COL).value()
	    $MainDataSheet.cells.item($row,$DWS_W_COL) = $hashT.Get_item($u_name)
	    $percents = [math]::round((($row/$LastRowUsed) * 100), 0)
	    Write-Progress -Activity:"Writing new values" -Status:"($percents%) complete" -PercentComplete:$percents
	}
    }
    else{
	write-host "No Sych File " $SFILE_NAME
    }
#Close WorkBooks
$WorkBook.SaveAs($DFILE_NAME)
#$Nwb.Close($False)
$Workbook.Close($False) 
}


$Excel.Quit()

[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Excel)
Remove-Variable -Name Excel
[gc]::collect()
[gc]::WaitForPendingFinalizers()
Stop-Process -Id $ExcelId -Force -ErrorAction SilentlyContinue