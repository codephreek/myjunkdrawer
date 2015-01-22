param([string]$DFILE_NAME="",
      [int]$DTB_IDX="",
      [int]$DWS_MAP_COL="",
      [int]$DWS_W_COL="",
      [string]$SFILE_NAME="",
      [int]$STB_IDX="",
      [int]$SWS_MAP_COL="",
      [int]$SWS_R_COL="")


###Function CopyRow($WS, $MDS, $WSrow, $MDSrow)
###{
###    #write-host "Copying data to Sheet: " $WS.name
###    $cols = 1
###    do{
###	$hdr = $MDS.Cells.Item($MDSrow,$cols).Value()
###	$WS.Cells.Item($WSrow,$cols) = $hdr
###	
###	#write-host "copy:  from:"  $MDSrow  ":" , $cols , "  to:" ,$WSrow , ":" $cols
###
###	$cols++
###    }while ($hdr -ne $Null)
###}
###
###Function AddHeaders($NWS, $MDS)
###{
###    #write-host "Adding Headers Sheet: " $NWS.name
###    $cols = 1
###    do{
###	$hdr = $MDS.Cells.Item(1,$cols).Value()
###	$NWS.Cells.Item(1,$cols) = $hdr
###	$cols++
###    }while ($hdr -ne $Null)
###}
###
###Function CreateNewWorkSheet($WB, $MDS, $SheetIdx, $SheetName)
###{
###    #write-host "Creating Sheet: " $SheetIdx
###    $ActiveWorkSheet = $WB.Worksheets.Item($SheetIdx)
###    $ActiveWorkSheet.name = $SheetName
###    #write-host "Created Sheet: " $ActiveWorkSheet.name
###    AddHeaders -NWS $ActiveWorkSheet -MDS $MDS
###    
###    #$WB.Worksheets.add([System.Reflection.Missing]::Value,
###    #                   $WB.Worksheets.Item($WB.Worksheets.count))
###
###    $ActiveWorkSheet
###    return
###}

###############################################################
$before = @(Get-Process [e]xcel | %{$_.Id})
$Excel = New-Object -comobject Excel.Application
$ExcelId = Get-Process excel | %{$_.Id} | ?{$before -notcontains $_}

if($DFILE_NAME -eq "-h" -or $DFILE_NAME -eq "--help"){
#    write-host " This program..."
 #   write-host " USAGE:  dest-file dest-tab-index dest-map-col dest-write-col src-file src-tab-index src-map-col src-read-col"
}
else{
    (Test-Path -path $SFILE_NAME){
	write-host $SFILE_NAME
	write-host $SWS_NAME
	
	$Excel.Displayalerts = $False
	$WorkBook=$Excel.WorkBooks.Open($SFILE_NAME)
	$MainDataSheet = $Workbook.Worksheets.Item($STB_IDX)
	
	$LastRowUsed = $MainDataSheet.UsedRange.Rows.Count
	
	#Create Hash Table
	$hashT = @{"default" = -1}
	for($row = 2;$row -le $LastRowUsed; $row++){
	    $id = $MainDataSheet.cells.item($row,$SWS_R_COL).value()
	    $u_name = $MainDataSheet.cells.item($row,$SWS_MAP_COL).value()
	    $hashT.add($u_name,$id)
	}
	##write-host ($hashT | out-string)
	##write-host $hashT.Get_Item("u_ph")
	write-host "FINISHED READING..."
	
	$Workbook.Close($False)
	
	$WorkBook=$Excel.WorkBooks.Open($DFILE_NAME)
	$MainDataSheet = $Workbook.Worksheets.Item($DTB_IDX)
	
	$LastRowUsed = $MainDataSheet.UsedRange.Rows.Count
	for($row = 2;$row -le $LastRowUsed; $row++){
	    $u_name = $MainDataSheet.cells.item($row,$DWS_MAP_COL).value()
	    $MainDataSheet.cells.item($row,$DWS_W_COL) = $hashT.Get_item($u_name)
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